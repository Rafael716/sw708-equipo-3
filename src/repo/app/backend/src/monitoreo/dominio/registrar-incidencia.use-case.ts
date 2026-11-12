import {
  IncidenciaDominio,
  Incidencias,
  RegistrarIncidenciaComando,
} from './incidencias.port';
import { ErrorDeIncidencia } from './errores-incidencia';
import { IncidenciaRegistrada } from './incidencia-registrada.evento';
import { PublicadorEventos } from './publicador-eventos.port';

/** Severidad máxima: dispara notificación a supervisores (E3). */
export const SEVERIDAD_CRITICA = 5;

/** Acta A8: largo máximo de la descripción, medido después de recortar espacios. */
export const LARGO_MAXIMO_DESCRIPCION = 1000;

/** Acta A12: único estado de operación que admite incidencias. */
export const ESTADO_OPERACION_ADMITE_INCIDENCIAS = 'En curso';

/** Publicador que no hace nada: útil en pruebas que solo miran el puerto de persistencia. */
const PUBLICADOR_NULO: PublicadorEventos = {
  publicar: async () => undefined,
};

export class RegistrarIncidenciaUseCase {
  constructor(
    private readonly incidencias: Incidencias,
    private readonly publicador: PublicadorEventos = PUBLICADOR_NULO,
  ) {}

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

    // Acta A8: el límite se mide sobre el texto ya recortado.
    if (descripcion.length > LARGO_MAXIMO_DESCRIPCION) {
      throw new ErrorDeIncidencia(
        'VALIDACION',
        `La descripción no puede superar ${LARGO_MAXIMO_DESCRIPCION} caracteres`,
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

    // Acta A6: primero la existencia (422), después el estado (409).
    const estadoOperacion = await this.incidencias.estadoDeOperacion(
      comando.idOperacion,
    );
    if (estadoOperacion === null) {
      throw new ErrorDeIncidencia(
        'OPERACION_INEXISTENTE',
        'No existe una operación con ese id',
      );
    }
    // Acta A12: solo «En curso»; Pendiente, Completada o Cancelada -> 409.
    if (
      estadoOperacion.trim().toLowerCase() !==
      ESTADO_OPERACION_ADMITE_INCIDENCIAS.toLowerCase()
    ) {
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
      // Acta A13: la notificación es secundaria y de mejor esfuerzo. Si falla,
      // la incidencia ya quedó guardada y el alta no se revierte ni falla.
      try {
        await this.incidencias.notificarSupervisores(guardada);
      } catch {
        // Sin reintento en esta versión; el registro principal ya está hecho.
      }
    }

    // Paso 6: el caso de uso emite el evento; no conoce a los consumidores.
    // Si el publicador o un consumidor fallan, el alta ya está hecha.
    try {
      await this.publicador.publicar(
        new IncidenciaRegistrada(
          guardada.idIncidencia,
          guardada.codigo,
          guardada.idOperacion,
          guardada.gradoSeveridad,
          guardada.idUsuario,
          guardada.fechaHora,
        ),
      );
    } catch {
      // Mejor esfuerzo: el efecto del consumidor no forma parte de la transacción de alta.
    }

    return guardada;
  }
}
