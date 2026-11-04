import { Injectable, InternalServerErrorException, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CreateOperacionMaritimaDto } from '../dto/create-operacion-maritima.dto';
import { Operacion } from '../../shared/entities/operacion.entity';
import { OperacionMaritima } from '../../shared/entities/operacion-maritima.entity';
import { OperacionRutaMaritima } from '../entities/operacion-ruta-maritima.entity';
import { OperacionEmpleado } from '../entities/operacion-empleado.entity';
import { OperacionContenedor } from '../entities/operacion-contenedor.entity';
import { BuqueTripulante } from '../../personal_tripulacion/entities/buque-tripulante.entity';
import { EstadoOperacion } from '../../shared/entities/estado-operacion.entity';
import { EstatusNavegacion } from '../../shared/entities/estatus-navegacion.entity';
import { Tripulante } from '../../shared/entities/tripulante.entity';
import { Contenedor } from '../../shared/entities/contenedor.entity';
import { ContenedorMercancia } from '../../shared/entities/contenedor-mercancia.entity';

@Injectable()
export class OperacionMaritimaService {
    constructor(
        private dataSource: DataSource,
        @InjectRepository(EstadoOperacion)
        private estadoOperacionRepository: Repository<EstadoOperacion>,
        @InjectRepository(EstatusNavegacion)
        private estatusNavegacionRepository: Repository<EstatusNavegacion>,
        @InjectRepository(Tripulante)
        private tripulanteRepository: Repository<Tripulante>,
    ) { }

    async create(createDto: CreateOperacionMaritimaDto) {
        const queryRunner = this.dataSource.createQueryRunner();
        await queryRunner.connect();
        await queryRunner.startTransaction();

        try {
            if (createDto.fecha_fin && new Date(createDto.fecha_fin) <= new Date(createDto.fecha_inicio)) {
                throw new BadRequestException('La fecha de fin debe ser posterior a la fecha de inicio');
            }

            // Paso 1: Insertar operación base
            const operacionResult = await queryRunner.query(`
                INSERT INTO shared.Operacion (
                    id_operacion,
                    codigo,
                    fecha_inicio,
                    fecha_fin,
                    id_estado_operacion
                ) VALUES (
                    gen_random_uuid(),
                    $1,
                    $2,
                    $3,
                    (SELECT id_estado_operacion FROM shared.EstadoOperacion WHERE nombre = $4 LIMIT 1)
                ) RETURNING id_operacion;
            `, [
                createDto.codigo,
                createDto.fecha_inicio,
                createDto.fecha_fin || null,
                createDto.estado_nombre
            ]);

            const idOperacion = operacionResult[0].id_operacion;

            // Paso 2: Insertar operación marítima
            // Generamos un código para la operación marítima basado en el de la operación
            const codigoMaritimo = createDto.codigo.replace('OP-', 'OPM-');

            const opMaritimaResult = await queryRunner.query(`
                INSERT INTO shared.OperacionMaritima (
                    id_operacion_maritima,
                    id_operacion,
                    codigo,
                    cantidad_contenedores,
                    id_estatus_navegacion,
                    porcentaje_trayecto,
                    id_buque
                ) VALUES (
                    gen_random_uuid(),
                    $1,
                    $2,
                    $3,
                    (SELECT id_estatus_navegacion FROM shared.EstatusNavegacion WHERE nombre = $4 LIMIT 1),
                    $5,
                    $6
                ) RETURNING id_operacion_maritima;
            `, [
                idOperacion,
                codigoMaritimo,
                createDto.cantidad_contenedores,
                createDto.estatus_navegacion_nombre || 'En Puerto',
                createDto.porcentaje_trayecto || 0,
                createDto.id_buque
            ]);

            const idOperacionMaritima = opMaritimaResult[0].id_operacion_maritima;

            // Paso 3: Asociar ruta marítima
            await queryRunner.query(`
                INSERT INTO gestion_maritima.OperacionRutaMaritima (
                    id_operacion_ruta_maritima,
                    id_operacion_maritima,
                    id_ruta_maritima,
                    id_muelle_origen,
                    id_muelle_destino
                ) VALUES (
                    gen_random_uuid(),
                    $1,
                    $2,
                    $3,
                    $4
                );
            `, [
                idOperacionMaritima,
                createDto.id_ruta_maritima,
                createDto.id_muelle_origen,
                createDto.id_muelle_destino
            ]);

            // Paso 4: Asignar contenedores
            if (createDto.contenedor_ids && createDto.contenedor_ids.length > 0) {
                for (const idContenedor of createDto.contenedor_ids) {
                    await queryRunner.query(`
                        INSERT INTO gestion_maritima.OperacionContenedor (
                            id_operacion_contenedor,
                            id_operacion,
                            id_contenedor,
                            fecha_asignacion
                        ) VALUES (
                            gen_random_uuid(),
                            $1,
                            $2,
                            CURRENT_DATE
                        );
                    `, [idOperacion, idContenedor]);
                }
            }

            // Paso 5: Asignar tripulación
            if (createDto.tripulacion_ids && createDto.tripulacion_ids.length > 0) {
                for (const idTripulante of createDto.tripulacion_ids) {
                    await queryRunner.query(`
                        INSERT INTO gestion_maritima.OperacionEmpleado (
                            id_operacion_empleado,
                            id_operacion,
                            id_empleado,
                            fecha_asignacion
                        ) VALUES (
                            gen_random_uuid(),
                            $1,
                            (SELECT id_empleado FROM shared.Tripulante WHERE id_tripulante = $2),
                            CURRENT_DATE
                        );
                    `, [idOperacion, idTripulante]);
                }
            }

            await queryRunner.commitTransaction();
            return { id_operacion: idOperacion, id_operacion_maritima: idOperacionMaritima };

        } catch (err) {
            await queryRunner.rollbackTransaction();
            console.error('Error creating maritime operation:', err);
            throw new InternalServerErrorException('Failed to create maritime operation');
        } finally {
            await queryRunner.release();
        }
    }
    async findAll(page: number = 1, limit: number = 10) {
        const skip = (page - 1) * limit;

        const [operations, total] = await this.dataSource.getRepository(OperacionMaritima)
            .createQueryBuilder('om')
            .leftJoinAndSelect('om.operacion', 'op')
            .leftJoinAndSelect('om.buque', 'buque')
            .leftJoinAndSelect('om.estatus_navegacion', 'estatus')
            .leftJoinAndSelect('op.estado_operacion', 'estado')
            .orderBy('om.codigo', 'ASC')
            .skip(skip)
            .take(limit)
            .getManyAndCount();

        return {
            data: operations.map(om => {
                return {
                    code: om.codigo,
                    containers: om.cantidad_contenedores,
                    status: om.operacion?.estado_operacion?.nombre || 'Desconocido',
                    progress: Number(om.porcentaje_trayecto),
                    ship: om.buque?.nombre || 'Desconocido',
                    merchandise: 'Sin mercancía', // Simplified for now
                    correctionNote: null
                };
            }),
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit)
        };
    }

    async findOne(id: string) {
        const opQuery = `
            SELECT 
                o.id_operacion,
                o.codigo as codigo_operacion,
                o.fecha_inicio,
                o.fecha_fin,
                eo.id_estado_operacion,
                eo.nombre as estado,
                om.id_operacion_maritima,
                om.codigo as codigo_maritimo,
                om.cantidad_contenedores,
                om.porcentaje_trayecto,
                en.nombre as estatus_navegacion,
                b.id_buque,
                b.nombre as buque_nombre,
                b.matricula as buque_matricula,
                b.capacidad as buque_capacidad,
                b.peso as buque_peso,
                b.ubicacion_actual as buque_ubicacion,
                eb.nombre as buque_estado
            FROM shared.Operacion o
            JOIN shared.OperacionMaritima om ON om.id_operacion = o.id_operacion
            LEFT JOIN shared.EstadoOperacion eo ON eo.id_estado_operacion = o.id_estado_operacion
            LEFT JOIN shared.EstatusNavegacion en ON en.id_estatus_navegacion = om.id_estatus_navegacion
            LEFT JOIN shared.Buque b ON b.id_buque = om.id_buque
            LEFT JOIN shared.EstadoEmbarcacion eb ON eb.id_estado_embarcacion = b.id_estado_embarcacion
            WHERE o.id_operacion = $1 OR om.id_operacion_maritima = $1
        `;
        const opRows = await this.dataSource.query(opQuery, [id]);
        if (!opRows || opRows.length === 0) {
            throw new NotFoundException(`Operación marítima con ID ${id} no encontrada`);
        }
        const op = opRows[0];

        // Ruta marítima
        let ruta: any = null;
        try {
            const rutaQuery = `
                SELECT 
                    orm.id_operacion_ruta_maritima,
                    rm.id_ruta_maritima,
                    rm.codigo as ruta_codigo,
                    rm.distancia,
                    mo.id_muelle as id_muelle_origen,
                    mo.codigo as muelle_origen_codigo,
                    mo.ubicacion as muelle_origen_ubicacion,
                    po.nombre as puerto_origen_nombre,
                    po.pais as puerto_origen_pais,
                    md.id_muelle as id_muelle_destino,
                    md.codigo as muelle_destino_codigo,
                    md.ubicacion as muelle_destino_ubicacion,
                    pd.nombre as puerto_destino_nombre,
                    pd.pais as puerto_destino_pais
                FROM gestion_maritima.OperacionRutaMaritima orm
                JOIN gestion_maritima.RutaMaritima rm ON rm.id_ruta_maritima = orm.id_ruta_maritima
                LEFT JOIN gestion_maritima.Muelle mo ON mo.id_muelle = orm.id_muelle_origen
                LEFT JOIN gestion_maritima.Puerto po ON po.id_puerto = rm.id_puerto_origen
                LEFT JOIN gestion_maritima.Muelle md ON md.id_muelle = orm.id_muelle_destino
                LEFT JOIN gestion_maritima.Puerto pd ON pd.id_puerto = rm.id_puerto_destino
                WHERE orm.id_operacion_maritima = $1
            `;
            const rutaRows = await this.dataSource.query(rutaQuery, [op.id_operacion_maritima]);
            if (rutaRows.length > 0) {
                const r = rutaRows[0];
                ruta = {
                    id_ruta_maritima: r.id_ruta_maritima,
                    codigo: r.ruta_codigo,
                    distancia: Number(r.distancia || 0),
                    origen: {
                        puerto: r.puerto_origen_nombre,
                        pais: r.puerto_origen_pais,
                        muelle: r.muelle_origen_codigo ? `${r.muelle_origen_codigo} (${r.muelle_origen_ubicacion || ''})` : null,
                    },
                    destino: {
                        puerto: r.puerto_destino_nombre,
                        pais: r.puerto_destino_pais,
                        muelle: r.muelle_destino_codigo ? `${r.muelle_destino_codigo} (${r.muelle_destino_ubicacion || ''})` : null,
                    },
                };
            }
        } catch (e) {
            console.error('Error fetching ruta:', e);
        }

        // Contenedores
        let contenedores: any[] = [];
        try {
            const contenedoresQuery = `
                SELECT 
                    c.id_contenedor,
                    c.codigo,
                    tc.nombre as tipo,
                    c.peso,
                    c.capacidad,
                    c.dimensiones,
                    ec.nombre as estado,
                    oc.fecha_asignacion
                FROM gestion_maritima.OperacionContenedor oc
                JOIN shared.Contenedor c ON c.id_contenedor = oc.id_contenedor
                LEFT JOIN shared.TipoContenedor tc ON tc.id_tipo_contenedor = c.id_tipo_contenedor
                LEFT JOIN shared.EstadoContenedor ec ON ec.id_estado_contenedor = c.id_estado_contenedor
                WHERE oc.id_operacion = $1
                ORDER BY c.codigo ASC
            `;
            contenedores = await this.dataSource.query(contenedoresQuery, [op.id_operacion]);
        } catch (e) {
            console.error('Error fetching contenedores:', e);
        }

        // Tripulación
        let tripulacion: any[] = [];
        try {
            const tripulacionQuery = `
                SELECT 
                    e.id_empleado,
                    e.nombre,
                    e.apellido,
                    e.codigo as codigo_empleado,
                    e.dni,
                    t.nacionalidad,
                    t.disponibilidad,
                    oe.fecha_asignacion
                FROM gestion_maritima.OperacionEmpleado oe
                JOIN shared.Empleado e ON e.id_empleado = oe.id_empleado
                LEFT JOIN shared.Tripulante t ON t.id_empleado = e.id_empleado
                WHERE oe.id_operacion = $1
                ORDER BY e.apellido ASC, e.nombre ASC
            `;
            tripulacion = await this.dataSource.query(tripulacionQuery, [op.id_operacion]);
        } catch (e) {
            console.error('Error fetching tripulacion:', e);
        }

        // Incidencias
        let incidencias: any[] = [];
        try {
            const incidenciasQuery = `
                SELECT 
                    i.id_incidencia,
                    i.codigo,
                    i.descripcion,
                    i.grado_severidad,
                    i.fecha_hora,
                    ti.nombre as tipo,
                    ei.nombre as estado
                FROM shared.Incidencia i
                LEFT JOIN monitoreo.TipoIncidencia ti ON ti.id_tipo_incidencia = i.id_tipo_incidencia
                LEFT JOIN monitoreo.EstadoIncidencia ei ON ei.id_estado_incidencia = i.id_estado_incidencia
                WHERE i.id_operacion = $1
                ORDER BY i.fecha_hora DESC
            `;
            incidencias = await this.dataSource.query(incidenciasQuery, [op.id_operacion]);
        } catch (e) {
            console.error('Error fetching incidencias:', e);
        }

        // Auditoría / Corrección
        let correccion: any = null;
        try {
            const correccionQuery = `
                SELECT 
                    tipo_correccion,
                    descripcion_correccion,
                    fecha_registro_batch as fecha_correccion,
                    correccion_aplicada,
                    requiere_intervencion_manual,
                    duracion_real_horas
                FROM gestion_maritima_audit.FactConciliacionOperacion
                WHERE id_operacion = $1
                ORDER BY fecha_registro_batch DESC
                LIMIT 1
            `;
            const corrRows = await this.dataSource.query(correccionQuery, [op.id_operacion]);
            if (corrRows && corrRows.length > 0) {
                correccion = corrRows[0];
            }
        } catch (e) {
            // ignore if audit table not accessible
        }

        return {
            id_operacion: op.id_operacion,
            id_operacion_maritima: op.id_operacion_maritima,
            codigo_operacion: op.codigo_operacion,
            codigo_maritimo: op.codigo_maritimo,
            fecha_inicio: op.fecha_inicio,
            fecha_fin: op.fecha_fin,
            id_estado_operacion: op.id_estado_operacion,
            estado: op.estado || 'Desconocido',
            porcentaje_trayecto: parseFloat(op.porcentaje_trayecto || '0'),
            estatus_navegacion: op.estatus_navegacion || 'Desconocido',
            cantidad_contenedores: op.cantidad_contenedores || contenedores.length,
            buque: {
                id_buque: op.id_buque,
                nombre: op.buque_nombre || 'N/A',
                matricula: op.buque_matricula || 'N/A',
                capacidad: op.buque_capacidad || 0,
                peso: Number(op.buque_peso || 0),
                ubicacion_actual: op.buque_ubicacion || 'N/A',
                estado: op.buque_estado || 'N/A',
            },
            ruta,
            contenedores: contenedores.map((c: any) => ({
                id_contenedor: c.id_contenedor,
                codigo: c.codigo,
                tipo: c.tipo || 'Estándar',
                peso: Number(c.peso || 0),
                capacidad: Number(c.capacidad || 0),
                dimensiones: c.dimensiones,
                estado: c.estado || 'En Tránsito',
                fecha_asignacion: c.fecha_asignacion,
            })),
            tripulacion: tripulacion.map((t: any) => ({
                id_empleado: t.id_empleado,
                nombre: t.nombre,
                apellido: t.apellido,
                codigo: t.codigo_empleado,
                dni: t.dni,
                nacionalidad: t.nacionalidad || 'N/A',
                disponibilidad: t.disponibilidad ?? true,
                fecha_asignacion: t.fecha_asignacion,
            })),
            incidencias: incidencias.map((i: any) => ({
                id_incidencia: i.id_incidencia,
                codigo: i.codigo,
                descripcion: i.descripcion,
                grado_severidad: i.grado_severidad,
                fecha_hora: i.fecha_hora,
                tipo: i.tipo || 'General',
                estado: i.estado || 'Reportada',
            })),
            correccion,
        };
    }

    async updateEstado(id: string, body: { id_estado_operacion?: string; estado_nombre?: string }) {
        const opResult = await this.dataSource.query(`
            SELECT o.id_operacion, o.codigo, o.fecha_fin, eo.nombre as estado_actual
            FROM shared.Operacion o
            LEFT JOIN shared.EstadoOperacion eo ON eo.id_estado_operacion = o.id_estado_operacion
            WHERE o.id_operacion = $1 OR o.id_operacion IN (
                SELECT om.id_operacion FROM shared.OperacionMaritima om WHERE om.id_operacion_maritima = $1
            )
        `, [id]);

        if (!opResult || opResult.length === 0) {
            throw new NotFoundException(`Operación marítima con ID ${id} no encontrada`);
        }

        const operacion = opResult[0];

        let targetEstado: EstadoOperacion | null = null;
        if (body.id_estado_operacion) {
            targetEstado = await this.estadoOperacionRepository.findOne({
                where: { id_estado_operacion: body.id_estado_operacion },
            });
        } else if (body.estado_nombre) {
            targetEstado = await this.estadoOperacionRepository.findOne({
                where: { nombre: body.estado_nombre },
            });
        }

        if (!targetEstado) {
            throw new BadRequestException('Estado de operación no válido');
        }

        let setFechaFinSql = '';
        const params: any[] = [targetEstado.id_estado_operacion, operacion.id_operacion];
        if (targetEstado.nombre === 'Completada' && !operacion.fecha_fin) {
            setFechaFinSql = ', fecha_fin = CURRENT_TIMESTAMP';
        }

        await this.dataSource.query(`
            UPDATE shared.Operacion
            SET id_estado_operacion = $1 ${setFechaFinSql}
            WHERE id_operacion = $2
        `, params);

        return {
            message: 'Estado de operación actualizado correctamente',
            id_operacion: operacion.id_operacion,
            estado_anterior: operacion.estado_actual,
            estado_nuevo: targetEstado.nombre,
            id_estado_nuevo: targetEstado.id_estado_operacion,
        };
    }

    async getEstados() {
        return await this.estadoOperacionRepository.find({
            order: { nombre: 'ASC' },
        });
    }
}
