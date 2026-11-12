import {
  IncidenciaDominio,
  Incidencias,
  RegistrarIncidenciaComando,
} from './incidencias.port';
import { ErrorDeIncidencia } from './errores-incidencia';

/** Severidad máxima: dispara notificación a supervisores (E3). */
export const SEVERIDAD_CRITICA = 5;

export class RegistrarIncidenciaUseCase {
  constructor(private readonly incidencias: Incidencias) {}

  async ejecutar(comando: RegistrarIncidenciaComando): Promise<IncidenciaDominio> {
    if (!comando.idUsuario || comando.idUsuario.trim().length === 0) {
      throw new ErrorDeIncidencia('NO_AUTENTICADO', 'Usuario no autenticado');
    }

    const descripcion = (comando.descripcion ?? '').trim();
    if (descripcion.length === 0) {
      throw new ErrorDeIncidencia(
        'DESCRIPCION_VACIA',
        'La descripción no puede estar vacía',
        'descripcion',
      );
    }

    if (
      !Number.isInteger(comando.gradoSeveridad) ||
      comando.gradoSeveridad < 1 ||
      comando.gradoSeveridad > 5
    ) {
      throw new ErrorDeIncidencia(
        'SEVERIDAD_INVALIDA',
        'El grado de severidad debe ser un entero entre 1 y 5',
        'grado_severidad',
      );
    }

    if (!comando.idTipoIncidencia || comando.idTipoIncidencia.trim().length === 0) {
      throw new ErrorDeIncidencia(
        'VALIDACION',
        'Tipo de incidencia no válido',
        'id_tipo_incidencia',
      );
    }

    if (!comando.idOperacion || comando.idOperacion.trim().length === 0) {
      throw new ErrorDeIncidencia(
        'VALIDACION',
        'La operación es obligatoria',
        'id_operacion',
      );
    }

    const tipoExiste = await this.incidencias.existeTipo(comando.idTipoIncidencia);
    if (!tipoExiste) {
      throw new ErrorDeIncidencia('TIPO_INEXISTENTE', 'Tipo de incidencia no válido');
    }

    const operacionActiva = await this.incidencias.operacionEstaActiva(
      comando.idOperacion,
    );
    if (!operacionActiva) {
      throw new ErrorDeIncidencia(
        'OPERACION_NO_ACTIVA',
        'La operación no está activa',
      );
    }

    const estadoInicial = await this.incidencias.obtenerEstadoInicial();
    if (!estadoInicial) {
      throw new ErrorDeIncidencia(
        'ERROR_INTERNO',
        'No hay estados de incidencia configurados',
      );
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
      throw new ErrorDeIncidencia(
        'ERROR_INTERNO',
        'El registro de incidencia debe incluir usuario y timestamp',
      );
    }

    if (comando.gradoSeveridad === SEVERIDAD_CRITICA) {
      await this.incidencias.notificarSupervisores(guardada);
    }

    return guardada;
  }
}
