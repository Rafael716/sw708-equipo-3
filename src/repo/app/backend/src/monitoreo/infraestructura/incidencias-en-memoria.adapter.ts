import {
  DatosNuevaIncidencia,
  IncidenciaDominio,
  Incidencias,
} from '../dominio/incidencias.port';

/** Segundo adaptador del puerto Incidencias: sin base de datos (pruebas). */
export class IncidenciasEnMemoriaAdapter implements Incidencias {
  private readonly tipos = new Set<string>();
  private readonly estadosDeOperacion = new Map<string, string>();
  private estadoInicialId: string | null = null;
  private secuencia = 0;
  private readonly guardadas: IncidenciaDominio[] = [];
  private readonly notificacionesSupervisores: IncidenciaDominio[] = [];

  sembrarTipo(idTipoIncidencia: string): void {
    this.tipos.add(idTipoIncidencia);
  }

  sembrarEstadoInicial(idEstadoIncidencia: string): void {
    this.estadoInicialId = idEstadoIncidencia;
  }

  sembrarOperacionActiva(idOperacion: string): void {
    this.sembrarOperacion(idOperacion, 'En curso');
  }

  sembrarOperacion(idOperacion: string, estado: string): void {
    this.estadosDeOperacion.set(idOperacion, estado);
  }

  listar(): IncidenciaDominio[] {
    return [...this.guardadas];
  }

  listarNotificacionesSupervisores(): IncidenciaDominio[] {
    return [...this.notificacionesSupervisores];
  }

  async existeTipo(idTipoIncidencia: string): Promise<boolean> {
    return this.tipos.has(idTipoIncidencia);
  }

  async obtenerEstadoInicial(): Promise<{ idEstadoIncidencia: string } | null> {
    if (!this.estadoInicialId) {
      return null;
    }
    return { idEstadoIncidencia: this.estadoInicialId };
  }

  async estadoDeOperacion(idOperacion: string): Promise<string | null> {
    return this.estadosDeOperacion.get(idOperacion) ?? null;
  }

  async siguienteCodigo(): Promise<string> {
    this.secuencia += 1;
    const fecha = new Date();
    // Acta A14: AAMM en UTC, igual que el adaptador TypeORM.
    const año = fecha.getUTCFullYear().toString().slice(-2);
    const mes = (fecha.getUTCMonth() + 1).toString().padStart(2, '0');
    const seq = this.secuencia.toString().padStart(4, '0');
    return `INC-${año}${mes}-${seq}`;
  }

  async guardar(datos: DatosNuevaIncidencia): Promise<IncidenciaDominio> {
    const incidencia: IncidenciaDominio = {
      idIncidencia: `mem-${this.guardadas.length + 1}`,
      codigo: datos.codigo,
      idTipoIncidencia: datos.idTipoIncidencia,
      descripcion: datos.descripcion,
      gradoSeveridad: datos.gradoSeveridad,
      idOperacion: datos.idOperacion,
      idUsuario: datos.idUsuario,
      idEstadoIncidencia: datos.idEstadoIncidencia,
      fechaHora: new Date(),
    };
    this.guardadas.push(incidencia);
    return incidencia;
  }

  async notificarSupervisores(incidencia: IncidenciaDominio): Promise<void> {
    this.notificacionesSupervisores.push(incidencia);
  }
}
