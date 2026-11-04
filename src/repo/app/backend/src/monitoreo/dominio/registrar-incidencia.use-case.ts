import {
  IncidenciaDominio,
  Incidencias,
  RegistrarIncidenciaComando,
} from './incidencias.port';

/** Severidad máxima: dispara notificación a supervisores (E3). */
export const SEVERIDAD_CRITICA = 5;

export class RegistrarIncidenciaUseCase {
  constructor(private readonly incidencias: Incidencias) {}

  async ejecutar(comando: RegistrarIncidenciaComando): Promise<IncidenciaDominio> {
    if (!comando.idUsuario || comando.idUsuario.trim().length === 0) {
      throw new Error('Usuario no autenticado');
    }

    const descripcion = (comando.descripcion ?? '').trim();
    if (descripcion.length === 0) {
      throw new Error('La descripción no puede estar vacía');
    }

    if (
      !Number.isInteger(comando.gradoSeveridad) ||
      comando.gradoSeveridad < 1 ||
      comando.gradoSeveridad > 5
    ) {
      throw new Error('El grado de severidad debe ser un entero entre 1 y 5');
    }

    if (!comando.idTipoIncidencia || comando.idTipoIncidencia.trim().length === 0) {
      throw new Error('Tipo de incidencia no válido');
    }

    if (!comando.idOperacion || comando.idOperacion.trim().length === 0) {
      throw new Error('La operación es obligatoria');
    }

    const tipoExiste = await this.incidencias.existeTipo(comando.idTipoIncidencia);
    if (!tipoExiste) {
      throw new Error('Tipo de incidencia no válido');
    }

    const operacionActiva = await this.incidencias.operacionEstaActiva(
      comando.idOperacion,
    );
    if (!operacionActiva) {
      throw new Error('La operación no está activa');
    }

    const estadoInicial = await this.incidencias.obtenerEstadoInicial();
    if (!estadoInicial) {
      throw new Error('No hay estados de incidencia configurados');
    }

    const codigo = await this.incidencias.siguienteCodigo();

    const guardada = await this.incidencias.guardar({
      codigo,
      idTipoIncidencia: comando.idTipoIncidencia,
      descripcion,
      gradoSeveridad: comando.gradoSeveridad,
      idOperacion: comando.idOperacion,
      idUsuario: comando.idUsuario,
      idEstadoIncidencia: estadoInicial.idEstadoIncidencia,
    });

    // Registro inmutable de auditoría: usuario + timestamp quedan fijados en el alta.
    if (!guardada.idUsuario || !guardada.fechaHora) {
      throw new Error('El registro de incidencia debe incluir usuario y timestamp');
    }

    if (comando.gradoSeveridad === SEVERIDAD_CRITICA) {
      await this.incidencias.notificarSupervisores(guardada);
    }

    return guardada;
  }
}
