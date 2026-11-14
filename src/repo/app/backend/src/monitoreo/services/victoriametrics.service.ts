import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import {
  CircuitoDependencia,
  esCircuitoAbierto,
  type ConfiguracionCircuito,
  type ResumenCircuito,
} from '../../shared/resiliencia/circuito-dependencia';
import {
  DependenciaNoDisponibleError,
  ErrorRespuestaDependencia,
  type MotivoDegradado,
} from '../../shared/resiliencia/dependencia-no-disponible.error';

interface VictoriaMetricsRangeQueryResult {
  status: string;
  data?: {
    resultType: string;
    result: Array<{
      metric: Record<string, string>;
      values: [number, string][];
    }>;
  };
  error?: string;
}

export interface TimeSeriesPoint {
  timestamp: number;
  value: number;
}

export interface ConsultaTemperatura {
  points: TimeSeriesPoint[];
  /** true cuando la respuesta no viene de VictoriaMetrics sino del respaldo. */
  degradado: boolean;
  motivo?: MotivoDegradado;
  /** Solo cuando el circuito está abierto: cuándo volverá a intentarse. */
  reintentarEnMs?: number;
}

type ParametrosResiliencia = Pick<
  ConfiguracionCircuito,
  | 'tiempoMaximoMs'
  | 'porcentajeErrores'
  | 'minimoLlamadas'
  | 'ventanaMs'
  | 'esperaAntesDeProbarMs'
>;

/**
 * Valores por defecto de la protección de VictoriaMetrics.
 * El motivo de cada número está en docs/resiliencia.md; se pueden ajustar por
 * entorno con las variables de VARIABLES_ENTORNO_RESILIENCIA_VM.
 */
export const VALORES_RESILIENCIA_VM: ParametrosResiliencia = {
  tiempoMaximoMs: 2_000,
  porcentajeErrores: 50,
  minimoLlamadas: 5,
  ventanaMs: 10_000,
  esperaAntesDeProbarMs: 15_000,
};

export const VARIABLES_ENTORNO_RESILIENCIA_VM = {
  tiempoMaximoMs: 'VICTORIA_METRICS_TIMEOUT_MS',
  porcentajeErrores: 'VICTORIA_METRICS_CIRCUIT_ERROR_PERCENTAGE',
  minimoLlamadas: 'VICTORIA_METRICS_CIRCUIT_MIN_CALLS',
  ventanaMs: 'VICTORIA_METRICS_CIRCUIT_WINDOW_MS',
  esperaAntesDeProbarMs: 'VICTORIA_METRICS_CIRCUIT_RESET_MS',
} as const;

const NOMBRE_DEPENDENCIA = 'victoriametrics';

@Injectable()
export class VictoriaMetricsService {
  private readonly logger = new Logger(VictoriaMetricsService.name);
  private readonly baseUrl: string;
  private readonly resiliencia: ParametrosResiliencia;
  private readonly circuitoEscritura: CircuitoDependencia<[string], void>;
  private readonly circuitoConsulta: CircuitoDependencia<
    [string, number, number, number],
    ConsultaTemperatura
  >;

  constructor(private readonly configService: ConfigService) {
    this.baseUrl =
      this.configService.get<string>('VICTORIA_METRICS_URL') ||
      'http://localhost:8428';
    this.resiliencia = this.leerResiliencia();

    // Los 4xx (por ejemplo un PromQL inválido nuestro) son un defecto de la
    // petición, no una caída: no deben abrir el circuito.
    const ignorarError = (error: unknown): boolean =>
      error instanceof ErrorRespuestaDependencia &&
      error.statusHttp >= 400 &&
      error.statusHttp < 500;

    this.circuitoEscritura = new CircuitoDependencia(
      {
        ...this.resiliencia,
        nombre: 'victoriametrics-escritura',
        ignorarError,
      },
      (cuerpo) => this.escribirEnVictoriaMetrics(cuerpo),
      (_cuerpo: string, error: Error) => {
        const motivo = this.motivoDeError(error);
        throw new DependenciaNoDisponibleError(
          NOMBRE_DEPENDENCIA,
          motivo,
          this.resiliencia.esperaAntesDeProbarMs,
          this.mensajeDependenciaCaida(motivo),
        );
      },
    );

    this.circuitoConsulta = new CircuitoDependencia(
      {
        ...this.resiliencia,
        nombre: 'victoriametrics-consulta',
        ignorarError,
      },
      (query, start, end, step) =>
        this.consultarTemperatura(query, start, end, step),
      (
        _query: string,
        _start: number,
        _end: number,
        _step: number,
        error: Error,
      ) => this.respuestaDegradada(error),
    );
  }

  async writeLines(lines: string | string[]): Promise<void> {
    const body = Array.isArray(lines) ? lines.join('\n') : lines;
    // Escritura: si el circuito está abierto el respaldo lanza
    // DependenciaNoDisponibleError (el controlador lo traduce a 503).
    await this.circuitoEscritura.ejecutar(body);
  }

  async getTemperaturaContenedor(
    contenedorId: string,
    // Por defecto consultamos el último año para cubrir lecturas históricas.
    horas: number = 24 * 365,
    // Step de 1 hora para mantener el número de puntos por debajo del límite de VictoriaMetrics.
    stepSeconds: number = 3600,
  ): Promise<ConsultaTemperatura> {
    const nowSec = Math.floor(Date.now() / 1000);
    // Para la demo usamos un rango amplio: hasta 1 año hacia atrás, para cubrir lecturas históricas.
    const maxHoras = 24 * 365;
    const effectiveHoras = Math.min(horas, maxHoras);
    const startSec = nowSec - effectiveHoras * 3600;

    // Para la demo usamos todas las lecturas del contenedor sin filtrar por tipo de sensor,
    // ya que la etiqueta "tipo" puede variar (temperatura_interior, temperatura_exterior, etc.).
    const query = `contenedor_sensor_valor{contenedor_id="${contenedorId}"}`;

    return this.circuitoConsulta.ejecutar(query, startSec, nowSec, stepSeconds);
  }

  /** Estado de los circuitos para diagnóstico y evidencia del laboratorio. */
  estadoCircuitos(): {
    dependencia: string;
    circuitos: Record<string, ResumenCircuito>;
  } {
    return {
      dependencia: NOMBRE_DEPENDENCIA,
      circuitos: {
        escritura: this.circuitoEscritura.resumen(),
        consulta: this.circuitoConsulta.resumen(),
      },
    };
  }

  /** Libera temporizadores de opossum (pruebas y apagado ordenado). */
  apagarCircuitos(): void {
    this.circuitoEscritura.apagar();
    this.circuitoConsulta.apagar();
  }

  private async escribirEnVictoriaMetrics(body: string): Promise<void> {
    // Usamos el endpoint de importación para formato Prometheus exposition.
    const url = new URL('/api/v1/import/prometheus', this.baseUrl);
    const response = await fetch(url.toString(), {
      method: 'POST',
      headers: {
        'Content-Type': 'text/plain',
      },
      body,
      // El timeout de opossum rechaza la promesa, pero no cancela el socket:
      // AbortSignal.timeout cierra la conexión HTTP y libera recursos.
      signal: AbortSignal.timeout(this.resiliencia.tiempoMaximoMs),
    });

    if (!response.ok) {
      const text = await response.text();
      this.logger.error(
        `Error al escribir en VictoriaMetrics: ${response.status} ${text}`,
      );
      throw new ErrorRespuestaDependencia(
        'Error al escribir métricas en VictoriaMetrics',
        response.status,
      );
    }
  }

  private async consultarTemperatura(
    query: string,
    start: number,
    end: number,
    step: number,
  ): Promise<ConsultaTemperatura> {
    const result = await this.consultarRango(query, start, end, step);
    const serie = result.data?.result?.[0];
    if (!serie) {
      return { points: [], degradado: false };
    }

    return {
      points: serie.values.map(([ts, val]) => ({
        timestamp: ts,
        value: Number(val),
      })),
      degradado: false,
    };
  }

  private async consultarRango(
    query: string,
    start: number,
    end: number,
    step: number,
  ): Promise<VictoriaMetricsRangeQueryResult> {
    const url = new URL('/api/v1/query_range', this.baseUrl);
    url.searchParams.set('query', query);
    url.searchParams.set('start', String(start));
    url.searchParams.set('end', String(end));
    url.searchParams.set('step', String(step));

    const response = await fetch(url.toString(), {
      signal: AbortSignal.timeout(this.resiliencia.tiempoMaximoMs),
    });
    const texto = await response.text();

    let data: VictoriaMetricsRangeQueryResult;
    try {
      data = JSON.parse(texto) as VictoriaMetricsRangeQueryResult;
    } catch {
      throw new ErrorRespuestaDependencia(
        'VictoriaMetrics devolvió una respuesta que no es JSON',
        response.status,
      );
    }

    if (!response.ok || data.status !== 'success') {
      this.logger.error(
        `Error en query_range VictoriaMetrics: ${response.status} ${data.error || ''}`,
      );
      throw new ErrorRespuestaDependencia(
        data.error || 'Error al consultar VictoriaMetrics',
        response.status,
      );
    }

    return data;
  }

  /**
   * Respuesta definida mientras el circuito está abierto (o la dependencia
   * falla/timeout): serie vacía y bandera de degradación, nunca un 5xx para
   * una lectura que la interfaz puede mostrar como "sin datos".
   */
  private respuestaDegradada(error: Error): ConsultaTemperatura {
    const motivo = this.motivoDeError(error);
    return {
      points: [],
      degradado: true,
      motivo,
      ...(motivo === 'circuito_abierto'
        ? { reintentarEnMs: this.resiliencia.esperaAntesDeProbarMs }
        : {}),
    };
  }

  private motivoDeError(error: unknown): MotivoDegradado {
    if (esCircuitoAbierto(error)) return 'circuito_abierto';

    const codigo = (error as { code?: string } | null)?.code;
    const nombre = (error as { name?: string } | null)?.name;
    if (
      codigo === 'ETIMEDOUT' ||
      nombre === 'TimeoutError' ||
      nombre === 'AbortError'
    ) {
      return 'tiempo_agotado';
    }
    return 'error_dependencia';
  }

  private mensajeDependenciaCaida(motivo: MotivoDegradado): string {
    const segundos = Math.ceil(this.resiliencia.esperaAntesDeProbarMs / 1000);
    switch (motivo) {
      case 'circuito_abierto':
        return (
          'VictoriaMetrics no está disponible: el circuito está abierto. ' +
          `Reintente en ${segundos} s.`
        );
      case 'tiempo_agotado':
        return (
          `VictoriaMetrics no respondió en ${this.resiliencia.tiempoMaximoMs} ms. ` +
          `Reintente en ${segundos} s.`
        );
      default:
        return `VictoriaMetrics devolvió un error. Reintente en ${segundos} s.`;
    }
  }

  private leerResiliencia(): ParametrosResiliencia {
    const leer = (
      clave: string,
      porDefecto: number,
      maximo?: number,
    ): number => {
      const valor = Number(this.configService.get<string>(clave));
      if (!Number.isFinite(valor) || valor <= 0) return porDefecto;
      return maximo ? Math.min(valor, maximo) : valor;
    };

    return {
      tiempoMaximoMs: leer(
        VARIABLES_ENTORNO_RESILIENCIA_VM.tiempoMaximoMs,
        VALORES_RESILIENCIA_VM.tiempoMaximoMs,
      ),
      porcentajeErrores: leer(
        VARIABLES_ENTORNO_RESILIENCIA_VM.porcentajeErrores,
        VALORES_RESILIENCIA_VM.porcentajeErrores,
        100,
      ),
      minimoLlamadas: Math.ceil(
        leer(
          VARIABLES_ENTORNO_RESILIENCIA_VM.minimoLlamadas,
          VALORES_RESILIENCIA_VM.minimoLlamadas,
        ),
      ),
      ventanaMs: leer(
        VARIABLES_ENTORNO_RESILIENCIA_VM.ventanaMs,
        VALORES_RESILIENCIA_VM.ventanaMs,
      ),
      esperaAntesDeProbarMs: leer(
        VARIABLES_ENTORNO_RESILIENCIA_VM.esperaAntesDeProbarMs,
        VALORES_RESILIENCIA_VM.esperaAntesDeProbarMs,
      ),
    };
  }
}
