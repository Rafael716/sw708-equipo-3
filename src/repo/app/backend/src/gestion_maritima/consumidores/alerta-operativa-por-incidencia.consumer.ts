import { IncidenciaRegistrada } from '../../monitoreo/dominio/incidencia-registrada.evento';

/** Efecto comprobable en el módulo de operaciones marítimas (Partición B). */
export interface AlertaOperativa {
  idIncidencia: string;
  codigoIncidencia: string;
  idOperacion: string;
  gradoSeveridad: number;
  registradaEn: Date;
}

/**
 * Consumidor de otro módulo: reacciona a IncidenciaRegistrada.
 * No lo conoce el caso de uso de monitoreo; se engancha al puerto de eventos.
 */
export class AlertaOperativaPorIncidenciaConsumer {
  private readonly alertas: AlertaOperativa[] = [];

  /** Solo las incidencias críticas (severidad 5) generan alerta operativa. */
  async manejar(evento: IncidenciaRegistrada): Promise<void> {
    if (evento.gradoSeveridad < 5) {
      return;
    }

    this.alertas.push({
      idIncidencia: evento.idIncidencia,
      codigoIncidencia: evento.codigo,
      idOperacion: evento.idOperacion,
      gradoSeveridad: evento.gradoSeveridad,
      registradaEn: evento.ocurrioEn,
    });
  }

  listarAlertas(): readonly AlertaOperativa[] {
    return this.alertas;
  }
}
