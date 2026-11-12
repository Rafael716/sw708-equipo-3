import {
  ArgumentsHost,
  Catch,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { BaseExceptionFilter } from '@nestjs/core';
import type { ModelError } from './generado/models';

/** Rutas que responden errores con el cuerpo del contrato (openapi.yaml 1.1.0). */
const RUTA_DEL_CONTRATO = '/v1/incidencias';

interface RespuestaHttp {
  status(codigo: number): { json(cuerpo: unknown): void };
}

/**
 * Algunos errores ocurren antes de llegar al controlador, y Nest los responde con
 * su propio formato ({ statusCode, message, error }):
 *  - el JSON inválido, que rechaza el parser del cuerpo (acta A9);
 *  - la falta de token, que rechaza JwtAuthGuard (401).
 * Este filtro los traduce al cuerpo { codigo, mensaje } del contrato, solo para
 * RUTA_DEL_CONTRATO. Las demás rutas conservan el comportamiento de Nest.
 *
 * Se registra como filtro global en main.ts, porque el error del parser no pasa
 * por los filtros del controlador.
 */
@Catch()
export class ErroresContratoFilter extends BaseExceptionFilter {
  catch(excepcion: unknown, host: ArgumentsHost): void {
    const http = host.switchToHttp();
    const url = http.getRequest<{ url?: string }>().url ?? '';
    if (!url.startsWith(RUTA_DEL_CONTRATO)) {
      super.catch(excepcion, host);
      return;
    }

    const traducido = this.traducir(excepcion);
    if (!traducido) {
      super.catch(excepcion, host);
      return;
    }
    http
      .getResponse<RespuestaHttp>()
      .status(traducido.status)
      .json(traducido.cuerpo);
  }

  private traducir(
    excepcion: unknown,
  ): { status: number; cuerpo: ModelError } | null {
    if (!(excepcion instanceof HttpException)) {
      return {
        status: HttpStatus.INTERNAL_SERVER_ERROR,
        cuerpo: {
          codigo: 'ERROR_INTERNO',
          mensaje: 'Ocurrió un error inesperado. Intente nuevamente.',
        },
      };
    }

    const status: HttpStatus = excepcion.getStatus();
    const respuesta = excepcion.getResponse();
    // Errores que ya armó el adaptador con el cuerpo del contrato: se respetan.
    if (
      typeof respuesta === 'object' &&
      respuesta !== null &&
      'codigo' in respuesta
    ) {
      return { status, cuerpo: respuesta as ModelError };
    }
    if (status === HttpStatus.UNAUTHORIZED) {
      return {
        status,
        cuerpo: {
          codigo: 'NO_AUTENTICADO',
          mensaje: 'Debe iniciar sesión para registrar una incidencia',
        },
      };
    }
    if (status === HttpStatus.BAD_REQUEST) {
      // Acta A9: el único 400 que no arma el adaptador es el del parser (JSON inválido).
      return {
        status,
        cuerpo: {
          codigo: 'VALIDACION',
          mensaje: 'El cuerpo de la petición debe ser un JSON válido',
        },
      };
    }
    // Otros status (por ejemplo, 404 de un método no definido): fuera del contrato.
    return null;
  }
}
