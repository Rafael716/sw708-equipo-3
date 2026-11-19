import { Logger } from '@nestjs/common';
import CircuitBreaker from 'opossum';

/**
 * Envoltorio delgado sobre opossum (librería mantenida) para no escribir un
 * circuit breaker a mano. Aplica timeout, ventana deslizante de errores y una
 * respuesta de respaldo cuando el circuito está abierto o la dependencia falla.
 *
 * Decisión de diseño: el respaldo recibe el error como último argumento
 * (opossum invoca `fallback(...args, error)`), así cada dependencia decide si
 * degrada con datos vacíos o si falla con un error de negocio.
 */

export type EstadoCircuito = 'cerrado' | 'abierto' | 'medio_abierto';

export interface ConfiguracionCircuito {
  /** Nombre para logs y para el endpoint de diagnóstico. */
  nombre: string;
  /** Tiempo máximo que se espera una respuesta de la dependencia. */
  tiempoMaximoMs: number;
  /** Porcentaje de errores que abre el circuito (0-100). */
  porcentajeErrores: number;
  /** Llamadas mínimas dentro de la ventana antes de poder abrir. */
  minimoLlamadas: number;
  /** Duración de la ventana deslizante de estadísticas. */
  ventanaMs: number;
  /** Tiempo que el circuito permanece abierto antes de media apertura. */
  esperaAntesDeProbarMs: number;
  /**
   * Errores que no cuentan como fallo de la dependencia (por ejemplo, un 4xx
   * causado por una petición mal formada nuestra). No abren el circuito.
   */
  ignorarError?: (error: unknown) => boolean;
}

export interface MetricasCircuito {
  llamadas: number;
  exitos: number;
  fallos: number;
  timeouts: number;
  rechazosPorCircuitoAbierto: number;
  respuestasDeRespaldo: number;
}

export interface ResumenCircuito {
  nombre: string;
  estado: EstadoCircuito;
  configuracion: Omit<ConfiguracionCircuito, 'ignorarError' | 'nombre'>;
  metricas: MetricasCircuito;
}

/** Código con el que opossum rechaza cuando el circuito ya está abierto. */
export function esCircuitoAbierto(error: unknown): boolean {
  return (
    typeof error === 'object' &&
    error !== null &&
    (error as { code?: string }).code === 'EOPENBREAKER'
  );
}

export class CircuitoDependencia<TArgs extends unknown[], TResultado> {
  private readonly breaker: CircuitBreaker<TArgs, TResultado>;
  private readonly logger: Logger;

  constructor(
    readonly configuracion: ConfiguracionCircuito,
    accion: (...args: TArgs) => Promise<TResultado>,
    respaldo: (...args: [...TArgs, Error]) => TResultado | Promise<TResultado>,
  ) {
    this.logger = new Logger(`Resiliencia:${configuracion.nombre}`);

    this.breaker = new CircuitBreaker<TArgs, TResultado>(accion, {
      name: configuracion.nombre,
      timeout: configuracion.tiempoMaximoMs,
      resetTimeout: configuracion.esperaAntesDeProbarMs,
      errorThresholdPercentage: configuracion.porcentajeErrores,
      volumeThreshold: configuracion.minimoLlamadas,
      rollingCountTimeout: configuracion.ventanaMs,
      rollingCountBuckets: 10,
      errorFilter: configuracion.ignorarError,
      // Solo se necesitan las métricas del endpoint de diagnóstico, no snapshots.
      enableSnapshots: false,
    });

    this.breaker.fallback(respaldo);

    this.breaker.on('open', () => {
      const m = this.metricas();
      this.logger.warn(
        `Circuito ABIERTO (${m.fallos}/${m.llamadas} fallos en la ventana). ` +
          `Se responde con el respaldo durante ${configuracion.esperaAntesDeProbarMs} ms.`,
      );
    });
    this.breaker.on('halfOpen', () => {
      this.logger.log(
        `Circuito en MEDIA APERTURA: se permite una llamada de prueba a la dependencia.`,
      );
    });
    this.breaker.on('close', () => {
      this.logger.log('Circuito CERRADO: la dependencia volvió a responder.');
    });
    this.breaker.on('timeout', (error: Error) => {
      this.logger.warn(
        `Timeout de ${configuracion.tiempoMaximoMs} ms: ${error.message}`,
      );
    });
  }

  /** Ejecuta la acción protegida (o el respaldo si el circuito está abierto). */
  ejecutar(...args: TArgs): Promise<TResultado> {
    return this.breaker.fire(...args);
  }

  get estado(): EstadoCircuito {
    if (this.breaker.opened) return 'abierto';
    if (this.breaker.halfOpen) return 'medio_abierto';
    return 'cerrado';
  }

  metricas(): MetricasCircuito {
    const stats = this.breaker.stats;
    return {
      llamadas: stats.fires,
      exitos: stats.successes,
      fallos: stats.failures,
      timeouts: stats.timeouts,
      rechazosPorCircuitoAbierto: stats.rejects,
      respuestasDeRespaldo: stats.fallbacks,
    };
  }

  resumen(): ResumenCircuito {
    return {
      nombre: this.configuracion.nombre,
      estado: this.estado,
      configuracion: {
        tiempoMaximoMs: this.configuracion.tiempoMaximoMs,
        porcentajeErrores: this.configuracion.porcentajeErrores,
        minimoLlamadas: this.configuracion.minimoLlamadas,
        ventanaMs: this.configuracion.ventanaMs,
        esperaAntesDeProbarMs: this.configuracion.esperaAntesDeProbarMs,
      },
      metricas: this.metricas(),
    };
  }

  /** Libera los temporizadores internos (pruebas y apagado ordenado). */
  apagar(): void {
    this.breaker.shutdown();
  }
}
