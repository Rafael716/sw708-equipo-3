/**
 * Códigos con los que el dominio explica por qué rechaza una incidencia.
 * Son el vocabulario del contrato (`Error.codigo` en openapi.yaml), pero el
 * dominio no sabe de status HTTP: traducir el código a 400/409/422 es tarea
 * del adaptador.
 */
export type CodigoErrorIncidencia =
  | 'VALIDACION'
  | 'DESCRIPCION_VACIA'
  | 'SEVERIDAD_INVALIDA'
  | 'NO_AUTENTICADO'
  | 'OPERACION_NO_ACTIVA'
  | 'TIPO_INEXISTENTE'
  | 'OPERACION_INEXISTENTE'
  | 'ERROR_INTERNO';

/**
 * Error de dominio al registrar una incidencia.
 * `campo` dice qué dato de la petición causó el error (acta A7: el cliente
 * decide por `codigo` y `campo`, nunca leyendo `mensaje`).
 */
export class ErrorDeIncidencia extends Error {
  constructor(
    readonly codigo: CodigoErrorIncidencia,
    mensaje: string,
    readonly campo?: string,
  ) {
    super(mensaje);
    this.name = 'ErrorDeIncidencia';
  }
}
