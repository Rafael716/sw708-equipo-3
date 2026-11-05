import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import {
  DatosNuevaIncidencia,
  IncidenciaDominio,
  Incidencias,
} from '../dominio/incidencias.port';
import { Incidencia } from '../entities/incidencia.entity';
import { TipoIncidencia } from '../entities/tipo-incidencia.entity';
import { EstadoIncidencia } from '../entities/estado-incidencia.entity';
import { Operacion } from '../../shared/entities/operacion.entity';
import { Notificacion } from '../entities/notificacion.entity';
import { TipoNotificacion } from '../entities/tipo-notificacion.entity';
import { Sensor } from '../entities/sensor.entity';
import { Reporte } from '../entities/reporte.entity';

/** Primer adaptador: persiste incidencias con TypeORM (producción). */
@Injectable()
export class IncidenciasTypeormAdapter implements Incidencias {
  constructor(
    @InjectRepository(Incidencia)
    private readonly incidenciaRepository: Repository<Incidencia>,
    @InjectRepository(TipoIncidencia)
    private readonly tipoIncidenciaRepository: Repository<TipoIncidencia>,
    @InjectRepository(EstadoIncidencia)
    private readonly estadoIncidenciaRepository: Repository<EstadoIncidencia>,
    @InjectRepository(Operacion)
    private readonly operacionRepository: Repository<Operacion>,
    @InjectRepository(Notificacion)
    private readonly notificacionRepository: Repository<Notificacion>,
    @InjectRepository(TipoNotificacion)
    private readonly tipoNotificacionRepository: Repository<TipoNotificacion>,
    @InjectRepository(Sensor)
    private readonly sensorRepository: Repository<Sensor>,
    @InjectRepository(Reporte)
    private readonly reporteRepository: Repository<Reporte>,
  ) {}

  async existeTipo(idTipoIncidencia: string): Promise<boolean> {
    const tipo = await this.tipoIncidenciaRepository.findOne({
      where: { id_tipo_incidencia: idTipoIncidencia },
    });
    return !!tipo;
  }

  async obtenerEstadoInicial(): Promise<{ idEstadoIncidencia: string } | null> {
    const estado = await this.estadoIncidenciaRepository.findOne({
      where: { nombre: 'Abierta' },
    });
    if (!estado) {
      return null;
    }
    return { idEstadoIncidencia: estado.id_estado_incidencia };
  }

  async operacionEstaActiva(idOperacion: string): Promise<boolean> {
    const operacion = await this.operacionRepository.findOne({
      where: { id_operacion: idOperacion },
      relations: ['estado_operacion'],
    });
    if (!operacion?.estado_operacion) {
      return false;
    }
    return operacion.estado_operacion.nombre === 'En curso';
  }

  async siguienteCodigo(): Promise<string> {
    const fecha = new Date();
    const año = fecha.getFullYear().toString().slice(-2);
    const mes = (fecha.getMonth() + 1).toString().padStart(2, '0');

    const count = await this.incidenciaRepository
      .createQueryBuilder('incidencia')
      .where('EXTRACT(YEAR FROM incidencia.fecha_hora) = :year', {
        year: fecha.getFullYear(),
      })
      .andWhere('EXTRACT(MONTH FROM incidencia.fecha_hora) = :month', {
        month: fecha.getMonth() + 1,
      })
      .getCount();

    const secuencia = (count + 1).toString().padStart(4, '0');
    return `INC-${año}${mes}-${secuencia}`;
  }

  async guardar(datos: DatosNuevaIncidencia): Promise<IncidenciaDominio> {
    const entidad = this.incidenciaRepository.create({
      codigo: datos.codigo,
      id_tipo_incidencia: datos.idTipoIncidencia,
      descripcion: datos.descripcion,
      grado_severidad: datos.gradoSeveridad,
      id_operacion: datos.idOperacion,
      id_usuario: datos.idUsuario,
      id_estado_incidencia: datos.idEstadoIncidencia,
    });

    const saved = await this.incidenciaRepository.save(entidad);

    return {
      idIncidencia: saved.id_incidencia,
      codigo: saved.codigo,
      idTipoIncidencia: saved.id_tipo_incidencia,
      descripcion: saved.descripcion,
      gradoSeveridad: saved.grado_severidad,
      idOperacion: saved.id_operacion,
      idUsuario: saved.id_usuario,
      idEstadoIncidencia: saved.id_estado_incidencia,
      fechaHora: saved.fecha_hora,
    };
  }

  async notificarSupervisores(incidencia: IncidenciaDominio): Promise<void> {
    const tipoNombrado = await this.tipoNotificacionRepository.findOne({
      where: { nombre: 'Alerta incidencia crítica' },
    });
    const tipo =
      tipoNombrado ??
      (await this.tipoNotificacionRepository.find({ take: 1 }))[0] ??
      null;
    const sensor = (await this.sensorRepository.find({ take: 1 }))[0] ?? null;
    const reporte = (await this.reporteRepository.find({ take: 1 }))[0] ?? null;

    if (!tipo || !sensor || !reporte) {
      // Sin catálogo de notificaciones sembrado: la regla de dominio ya se ejecutó;
      // no bloqueamos el alta de la incidencia crítica.
      return;
    }

    const codigo = `ALT-${incidencia.codigo}`;
    const entidad = this.notificacionRepository.create({
      codigo,
      id_tipo_notificacion: tipo.id_tipo_notificacion,
      fecha_hora: new Date(),
      valor: incidencia.gradoSeveridad,
      id_sensor: sensor.id_sensor,
      id_reporte: reporte.id_reporte,
    });
    await this.notificacionRepository.save(entidad);
  }
}
