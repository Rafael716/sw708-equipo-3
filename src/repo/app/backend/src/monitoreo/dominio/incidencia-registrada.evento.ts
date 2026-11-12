/**
 * Evento de dominio: una incidencia acabó de registrarse.
 * Nombre en pasado, inmutable. El emisor no conoce a los consumidores.
 */
export class IncidenciaRegistrada {
  readonly nombre = 'IncidenciaRegistrada' as const;

  constructor(
    readonly idIncidencia: string,
    readonly codigo: string,
    readonly idOperacion: string,
    readonly gradoSeveridad: number,
    readonly idUsuario: string,
    readonly ocurrioEn: Date,
  ) {
    Object.freeze(this);
  }
}
