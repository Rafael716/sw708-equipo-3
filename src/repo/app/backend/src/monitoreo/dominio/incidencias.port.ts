/** Modelo de dominio (sin TypeORM). */
export interface IncidenciaDominio {
  idIncidencia: string;
  codigo: string;
  idTipoIncidencia: string;
  descripcion: string;
  gradoSeveridad: number;
  idOperacion: string;
  idUsuario: string;
  idEstadoIncidencia: string;
  fechaHora: Date;
}

export interface RegistrarIncidenciaComando {
  idTipoIncidencia: string;
  descripcion: string;
  gradoSeveridad: number;
  idOperacion: string;
  idUsuario: string;
}

export interface DatosNuevaIncidencia {
  codigo: string;
  idTipoIncidencia: string;
  descripcion: string;
  gradoSeveridad: number;
  idOperacion: string;
  idUsuario: string;
  idEstadoIncidencia: string;
}

/**
 * Puerto de salida: lo que el dominio necesita del mundo exterior.
 * Vive en dominio; lo implementa infraestructura.
 */
export interface Incidencias {
  existeTipo(idTipoIncidencia: string): Promise<boolean>;
  /** Estado inicial de negocio: nombre «Abierta». */
  obtenerEstadoInicial(): Promise<{ idEstadoIncidencia: string } | null>;
  /**
   * Nombre del estado de la operación (por ejemplo «En curso», «Completada»),
   * o null si la operación no existe (acta A6). Qué estados admiten incidencias
   * lo decide el dominio (acta A12).
   */
  estadoDeOperacion(idOperacion: string): Promise<string | null>;
  siguienteCodigo(): Promise<string>;
  /**
   * Persistencia de alta (registro inmutable de auditoría):
   * siempre incluye idUsuario y fechaHora; el caso de uso no actualiza.
   */
  guardar(datos: DatosNuevaIncidencia): Promise<IncidenciaDominio>;
  /** Aviso a supervisores ante incidencia crítica (severidad 5). */
  notificarSupervisores(incidencia: IncidenciaDominio): Promise<void>;
}

/** Token Nest para inyectar el puerto sin acoplar el controlador al adaptador concreto. */
export const INCIDENCIAS_PORT = 'INCIDENCIAS_PORT';
