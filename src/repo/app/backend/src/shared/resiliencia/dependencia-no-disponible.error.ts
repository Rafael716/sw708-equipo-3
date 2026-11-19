/** Motivo por el que una dependencia no pudo responder. */
export type MotivoDegradado =
  'circuito_abierto' | 'tiempo_agotado' | 'error_dependencia';

/**
 * Error de una dependencia externa caída, lenta o con el circuito abierto.
 * Vive fuera de Nest para que los servicios no acoplen su contrato al framework;
 * el controlador HTTP lo traduce a 503 con un cuerpo estable.
 */
export class DependenciaNoDisponibleError extends Error {
  readonly codigo = 'DEPENDENCIA_NO_DISPONIBLE';

  constructor(
    readonly dependencia: string,
    readonly motivo: MotivoDegradado,
    readonly reintentarEnMs: number,
    mensaje: string,
  ) {
    super(mensaje);
    this.name = 'DependenciaNoDisponibleError';
  }
}

/** Error HTTP devuelto por la dependencia; permite distinguir 4xx de 5xx. */
export class ErrorRespuestaDependencia extends Error {
  constructor(
    mensaje: string,
    readonly statusHttp: number,
  ) {
    super(mensaje);
    this.name = 'ErrorRespuestaDependencia';
  }
}
