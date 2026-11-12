import {
  Body,
  Controller,
  HttpCode,
  HttpException,
  HttpStatus,
  Logger,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { RegistrarIncidenciaUseCase } from '../dominio/registrar-incidencia.use-case';
import {
  CodigoErrorIncidencia,
  ErrorDeIncidencia,
} from '../dominio/errores-incidencia';
import type { IncidenciaDominio } from '../dominio/incidencias.port';
import { IncidenciasApi } from './generado/api';
import type {
  CrearIncidenciaRequest,
  Incidencia,
  ModelError,
} from './generado/models';

/** Lo que este adaptador lee de la petición HTTP de Express. */
interface PeticionHttp {
  headers: Record<string, string | string[] | undefined>;
  user?: { id_usuario?: string };
}

const CAMPOS_PERMITIDOS = [
  'id_tipo_incidencia',
  'descripcion',
  'grado_severidad',
  'id_operacion',
];

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/** Traducción del código de dominio al status HTTP del contrato. */
const STATUS_POR_CODIGO: Record<CodigoErrorIncidencia, number> = {
  VALIDACION: HttpStatus.BAD_REQUEST,
  DESCRIPCION_VACIA: HttpStatus.BAD_REQUEST,
  SEVERIDAD_INVALIDA: HttpStatus.BAD_REQUEST,
  NO_AUTENTICADO: HttpStatus.UNAUTHORIZED,
  OPERACION_NO_ACTIVA: HttpStatus.CONFLICT,
  TIPO_INEXISTENTE: HttpStatus.UNPROCESSABLE_ENTITY,
  OPERACION_INEXISTENTE: HttpStatus.UNPROCESSABLE_ENTITY,
  ERROR_INTERNO: HttpStatus.INTERNAL_SERVER_ERROR,
};

const MENSAJE_ERROR_INTERNO =
  'Ocurrió un error inesperado. Intente nuevamente.';

function errorHttp(
  codigo: CodigoErrorIncidencia,
  mensaje: string,
  campo?: string,
): HttpException {
  const cuerpo: ModelError = campo
    ? { codigo, mensaje, campo }
    : { codigo, mensaje };
  return new HttpException(cuerpo, STATUS_POR_CODIGO[codigo]);
}

/**
 * Adaptador HTTP de POST /v1/incidencias (contrato semana-10/docs/api/openapi.yaml, 1.1.0).
 *
 * Implementa la interfaz generada desde el contrato (IncidenciasApi). NestJS solo
 * existe aquí: el controlador revisa la forma de la petición, la traduce a un
 * comando, llama al caso de uso y traduce su resultado o su error al contrato.
 * El dominio no sabe que existe HTTP.
 */
@Controller('v1/incidencias')
export class IncidenciasV1Controller implements IncidenciasApi {
  private readonly logger = new Logger(IncidenciasV1Controller.name);

  constructor(
    private readonly registrarIncidencia: RegistrarIncidenciaUseCase,
  ) {}

  @Post()
  @HttpCode(HttpStatus.CREATED)
  @UseGuards(JwtAuthGuard)
  async crearIncidencia(
    @Body() cuerpo: CrearIncidenciaRequest,
    // La interfaz generada tipa este parámetro con el Request de fetch; en
    // ejecución es el request de Express, que es lo que se lee aquí.
    @Req() request: Request,
  ): Promise<Incidencia> {
    const peticion = request as unknown as PeticionHttp;
    const datos = this.validarForma(peticion, cuerpo);

    try {
      const creada = await this.registrarIncidencia.ejecutar({
        idTipoIncidencia: datos.id_tipo_incidencia as string,
        // Ausente o null llega como undefined: el dominio responde
        // DESCRIPCION_VACIA (acta A4, A5).
        descripcion: datos.descripcion as string,
        // Sin convertir: "4", 4.5, null o ausente los rechaza el dominio
        // con SEVERIDAD_INVALIDA (acta A4, A5).
        gradoSeveridad: datos.grado_severidad as number,
        idOperacion: datos.id_operacion as string,
        idUsuario: peticion.user?.id_usuario ?? '',
      });
      return this.aContrato(creada);
    } catch (error) {
      if (
        error instanceof ErrorDeIncidencia &&
        error.codigo !== 'ERROR_INTERNO'
      ) {
        throw errorHttp(error.codigo, error.message, error.campo);
      }
      this.logger.error(error instanceof Error ? error.message : String(error));
      throw errorHttp('ERROR_INTERNO', MENSAJE_ERROR_INTERNO);
    }
  }

  /**
   * Forma de la petición (400 VALIDACION). Orden del contrato: primero el formato
   * del cuerpo, luego los campos (acta A6).
   */
  private validarForma(
    peticion: PeticionHttp,
    cuerpo: unknown,
  ): Record<string, unknown> {
    // Acta A9: solo JSON. Otro Content-Type o cuerpo vacío / no objeto -> 400 VALIDACION.
    const contentType = String(peticion.headers['content-type'] ?? '');
    const esObjeto =
      typeof cuerpo === 'object' && cuerpo !== null && !Array.isArray(cuerpo);
    if (
      !contentType.toLowerCase().startsWith('application/json') ||
      !esObjeto ||
      Object.keys(cuerpo).length === 0
    ) {
      throw errorHttp(
        'VALIDACION',
        'El cuerpo de la petición debe ser un JSON válido',
      );
    }
    const datos = cuerpo as Record<string, unknown>;

    // additionalProperties: false. id_usuario nunca se acepta: sale del token.
    const desconocido = Object.keys(datos).find(
      (campo) => !CAMPOS_PERMITIDOS.includes(campo),
    );
    if (desconocido) {
      throw errorHttp(
        'VALIDACION',
        `El campo ${desconocido} no está permitido`,
        desconocido,
      );
    }

    // Acta A4, A5: identificador ausente o null -> VALIDACION; no UUID -> VALIDACION.
    for (const campo of ['id_tipo_incidencia', 'id_operacion']) {
      const valor = datos[campo];
      if (valor === undefined || valor === null) {
        throw errorHttp(
          'VALIDACION',
          `El campo ${campo} es obligatorio`,
          campo,
        );
      }
      if (typeof valor !== 'string' || !UUID.test(valor)) {
        throw errorHttp(
          'VALIDACION',
          `El campo ${campo} debe ser un UUID`,
          campo,
        );
      }
    }

    // Acta A5: descripcion con tipo distinto de texto -> VALIDACION.
    const descripcion = datos.descripcion;
    if (
      descripcion !== undefined &&
      descripcion !== null &&
      typeof descripcion !== 'string'
    ) {
      throw errorHttp(
        'VALIDACION',
        'El campo descripcion debe ser texto',
        'descripcion',
      );
    }

    return {
      ...datos,
      descripcion: descripcion ?? undefined,
      grado_severidad: datos.grado_severidad ?? undefined,
    };
  }

  /** Dominio -> esquema Incidencia del contrato. */
  private aContrato(incidencia: IncidenciaDominio): Incidencia {
    return {
      id_incidencia: incidencia.idIncidencia,
      codigo: incidencia.codigo,
      id_tipo_incidencia: incidencia.idTipoIncidencia,
      descripcion: incidencia.descripcion,
      grado_severidad: incidencia.gradoSeveridad,
      fecha_hora: incidencia.fechaHora.toISOString(),
      id_estado_incidencia: incidencia.idEstadoIncidencia,
      id_operacion: incidencia.idOperacion,
      id_usuario: incidencia.idUsuario,
    };
  }
}
