import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PosicionContenedor } from '../entities/posicion-contenedor.entity';
import { PosicionVehiculo } from '../entities/posicion-vehiculo.entity';
import { PosicionBuque } from '../entities/posicion-buque.entity';

@Injectable()
export class GpsService {
  constructor(
    @InjectRepository(PosicionContenedor)
    private posicionContenedorRepository: Repository<PosicionContenedor>,
    @InjectRepository(PosicionVehiculo)
    private posicionVehiculoRepository: Repository<PosicionVehiculo>,
    @InjectRepository(PosicionBuque)
    private posicionBuqueRepository: Repository<PosicionBuque>,
  ) {}

  // perf(gps): paginacion en getPosicionesContenedores
  // Antes: LIMIT 100 fijo sin offset, forzaba al motor a ordenar toda la tabla
  //        y transferir siempre 100 filas aunque el llamador solo necesitara las primeras.
  // Ahora: LIMIT $1 OFFSET $2 con defaults (50, 0). El indice compuesto
  //        idx_posicion_contenedor_fecha (id_contenedor, fecha_hora) cubre el ORDER BY,
  //        y la reduccion de filas por pagina baja la presion sobre el buffer pool.
  async getPosicionesContenedores(limit = 50, offset = 0) {
    try {
      const rows = await this.posicionContenedorRepository.query(
        `
        SELECT
          id_posicion,
          id_contenedor,
          latitud,
          longitud,
          fecha_hora
        FROM monitoreo.posicioncontenedor
        ORDER BY fecha_hora DESC
        LIMIT $1 OFFSET $2
        `,
        [limit, offset],
      );

      return rows;
    } catch (error) {
      console.error('Error en getPosicionesContenedores:', error.message);
      return [];
    }
  }

  async getUltimaPosicionContenedor(id_contenedor: string) {
    try {
      const rows = await this.posicionContenedorRepository.query(
        `
        SELECT
          id_posicion,
          id_contenedor,
          latitud,
          longitud,
          fecha_hora
        FROM monitoreo.posicioncontenedor
        WHERE id_contenedor = $1
        ORDER BY fecha_hora DESC
        LIMIT 1
        `,
        [id_contenedor],
      );

      return rows[0] ?? null;
    } catch (error) {
      console.error('Error en getUltimaPosicionContenedor:', error.message);
      return null;
    }
  }

  async getHistorialPosicionesContenedor(id_contenedor: string, limit = 50) {
    try {
      const rows = await this.posicionContenedorRepository.query(
        `
        SELECT
          id_posicion,
          id_contenedor,
          latitud,
          longitud,
          fecha_hora
        FROM monitoreo.posicioncontenedor
        WHERE id_contenedor = $1
        ORDER BY fecha_hora DESC
        LIMIT $2
        `,
        [id_contenedor, limit],
      );

      return rows;
    } catch (error) {
      console.error('Error en getHistorialPosicionesContenedor:', error.message);
      return [];
    }
  }

  async getAllPosiciones() {
    try {
      const contRows = await this.posicionContenedorRepository.query(
        `
        SELECT DISTINCT ON (pc.id_contenedor)
          pc.id_posicion,
          pc.id_contenedor,
          pc.latitud,
          pc.longitud,
          pc.fecha_hora,
          c.codigo AS contenedor_codigo,
          ec.nombre AS estado_contenedor_nombre
        FROM monitoreo.posicioncontenedor pc
        JOIN shared.contenedor c ON c.id_contenedor = pc.id_contenedor
        LEFT JOIN shared.estadocontenedor ec ON ec.id_estado_contenedor = c.id_estado_contenedor
        ORDER BY pc.id_contenedor, pc.fecha_hora DESC
        `,
      );

      const vehiculos = await this.posicionVehiculoRepository
        .createQueryBuilder('pv')
        .leftJoinAndSelect('pv.vehiculo', 'v')
        .leftJoinAndSelect('v.estado_vehiculo', 'ev')
        .distinctOn(['pv.id_vehiculo'])
        .orderBy('pv.id_vehiculo')
        .addOrderBy('pv.fecha_hora', 'DESC')
        .getMany();

      const buques = await this.posicionBuqueRepository
        .createQueryBuilder('pb')
        .leftJoinAndSelect('pb.buque', 'b')
        .leftJoinAndSelect('b.estado_embarcacion', 'eb')
        .distinctOn(['pb.id_buque'])
        .orderBy('pb.id_buque')
        .addOrderBy('pb.fecha_hora', 'DESC')
        .getMany();

      const assetsContenedores = contRows.map((pc: any) => ({
        id: pc.id_posicion,
        code: pc.contenedor_codigo || `CNT-${pc.id_contenedor.substring(0, 8)}`,
        type: 'container',
        position: [Number(pc.latitud), Number(pc.longitud)],
        status: pc.estado_contenedor_nombre || 'Desconocido',
        statusColor: this.getStatusColor(pc.estado_contenedor_nombre),
        icon: 'inventory_2',
        lastUpdate: pc.fecha_hora,
        speed: 'N/A',
        temp: 'N/A',
      }));

      const assets = [
        ...assetsContenedores,
        ...vehiculos.map(pv => ({
          id: pv.id_posicion,
          code: pv.vehiculo?.placa || `VEH-${pv.id_vehiculo.substring(0, 8)}`,
          type: 'vehicle',
          position: [Number(pv.latitud), Number(pv.longitud)],
          status: pv.vehiculo?.estado_vehiculo?.nombre || 'Desconocido',
          statusColor: this.getVehiculoStatusColor(pv.vehiculo?.estado_vehiculo?.nombre),
          icon: 'local_shipping',
          lastUpdate: pv.fecha_hora,
          speed: 'N/A',
          temp: 'N/A',
        })),
        ...buques.map(pb => ({
          id: pb.id_posicion,
          code: pb.buque?.nombre || `BQE-${pb.id_buque.substring(0, 8)}`,
          type: 'ship',
          position: [Number(pb.latitud), Number(pb.longitud)],
          status: pb.buque?.estado_embarcacion?.nombre || 'Desconocido',
          statusColor: this.getBuqueStatusColor(pb.buque?.estado_embarcacion?.nombre),
          icon: 'sailing',
          lastUpdate: pb.fecha_hora,
          speed: 'N/A',
          temp: 'N/A',
        })),
      ];

      return assets;
    } catch (error) {
      console.error('Error en getAllPosiciones:', error.message);
      return [];
    }
  }

  private getStatusColor(status: string | undefined): string {
    if (!status) return '#6b7280';
    const key = status.toLowerCase();
    const colors: Record<string, string> = {
      'disponible':        '#10b981',
      'en transito':       '#3b82f6',
      'en puerto':         '#6366f1',
      'en reparacion':     '#f59e0b',
      'fuera de servicio': '#ef4444',
    };
    return colors[key] || '#6b7280';
  }

  private getVehiculoStatusColor(status: string | undefined): string {
    if (!status) return '#6b7280';
    const key = status.toLowerCase();
    const colors: Record<string, string> = {
      'disponible':        '#10b981',
      'en ruta':           '#3b82f6',
      'en mantenimiento':  '#f59e0b',
      'fuera de servicio': '#ef4444',
      'en revision':       '#8b5cf6',
    };
    return colors[key] || '#6b7280';
  }

  private getBuqueStatusColor(status: string | undefined): string {
    if (!status) return '#6b7280';
    const key = status.toLowerCase();
    const colors: Record<string, string> = {
      'operativo':         '#10b981',
      'en mantenimiento':  '#f59e0b',
      'fuera de servicio': '#ef4444',
      'en reparacion':     '#f97316',
      'disponible':        '#3b82f6',
    };
    return colors[key] || '#6b7280';
  }
}
