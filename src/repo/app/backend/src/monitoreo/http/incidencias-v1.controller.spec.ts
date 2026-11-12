import {
  ExecutionContext,
  INestApplication,
  UnauthorizedException,
  ValidationPipe,
} from '@nestjs/common';
import { HttpAdapterHost } from '@nestjs/core';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import type { App } from 'supertest/types';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { RegistrarIncidenciaUseCase } from '../dominio/registrar-incidencia.use-case';
import { IncidenciasEnMemoriaAdapter } from '../infraestructura/incidencias-en-memoria.adapter';
import { IncidenciasV1Controller } from './incidencias-v1.controller';
import { ErroresContratoFilter } from './errores-contrato.filter';
import { ModelError } from './generado/models';

/**
 * Pruebas del adaptador contra el contrato semana-10/docs/api/openapi.yaml (1.1.0).
 * Cada prueba corresponde a una respuesta o a un ejemplo del contrato; el prefijo
 * A# indica el punto del acta de ambigüedades (acta-ambiguedades-equipo-1.md).
 */

// Valores de los ejemplos del contrato.
const TIPO = '6f1c2b9e-3a4d-4c8e-9f10-2b7d5a6c8e01';
const OPERACION = '0b7e4c2a-9d31-4f6a-8c5e-1a2b3c4d5e6f';
const ESTADO_ABIERTA = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
const USUARIO = 'c4d5e6f7-a8b9-4c0d-9e1f-2a3b4c5d6e7f';
const OTRO_UUID = '11111111-2222-4333-8444-555555555555';

/** Acta A12: operaciones que existen pero no están «En curso». */
const OPERACIONES_NO_ACTIVAS: Record<string, string> = {
  Pendiente: '22222222-3333-4444-8555-666666666661',
  Completada: '22222222-3333-4444-8555-666666666662',
  Cancelada: '22222222-3333-4444-8555-666666666663',
};

const PETICION_VALIDA = {
  id_tipo_incidencia: TIPO,
  descripcion: 'Sensor de temperatura del contenedor fuera de rango',
  grado_severidad: 4,
  id_operacion: OPERACION,
};

const CODIGOS_DEL_CONTRATO: string[] = Object.values(ModelError.CodigoEnum);

/** Guard de prueba: "Bearer token-valido" autentica a USUARIO; lo demás, 401. */
const guardDePrueba = {
  canActivate(ctx: ExecutionContext): boolean {
    const req = ctx
      .switchToHttp()
      .getRequest<{ headers: Record<string, string>; user?: unknown }>();
    if (req.headers.authorization !== 'Bearer token-valido') {
      throw new UnauthorizedException();
    }
    req.user = { id_usuario: USUARIO };
    return true;
  },
};

describe('POST /v1/incidencias (adaptador contra el contrato 1.1.0)', () => {
  let app: INestApplication<App>;

  beforeEach(async () => {
    const incidencias = new IncidenciasEnMemoriaAdapter();
    incidencias.sembrarTipo(TIPO);
    incidencias.sembrarEstadoInicial(ESTADO_ABIERTA);
    incidencias.sembrarOperacionActiva(OPERACION);
    for (const [estado, id] of Object.entries(OPERACIONES_NO_ACTIVAS)) {
      incidencias.sembrarOperacion(id, estado);
    }

    const modulo = await Test.createTestingModule({
      controllers: [IncidenciasV1Controller],
      providers: [
        {
          provide: RegistrarIncidenciaUseCase,
          useValue: new RegistrarIncidenciaUseCase(incidencias),
        },
      ],
    })
      .overrideGuard(JwtAuthGuard)
      .useValue(guardDePrueba)
      .compile();

    app = modulo.createNestApplication();
    // Igual que main.ts
    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        transform: true,
        forbidNonWhitelisted: true,
      }),
    );
    app.useGlobalFilters(
      new ErroresContratoFilter(app.get(HttpAdapterHost).httpAdapter),
    );
    await app.init();
  });

  afterEach(async () => {
    await app.close();
  });

  const enviar = (cuerpo: unknown) =>
    request(app.getHttpServer())
      .post('/v1/incidencias')
      .set('Authorization', 'Bearer token-valido')
      .send(cuerpo as object);

  /** El cuerpo de error cumple el esquema Error del contrato. */
  function esperarError(
    respuesta: request.Response,
    status: number,
    codigo: string,
    campo?: string,
  ) {
    expect(respuesta.status).toBe(status);
    const cuerpo = respuesta.body as Record<string, unknown>;
    expect(CODIGOS_DEL_CONTRATO).toContain(codigo);
    expect(cuerpo.codigo).toBe(codigo);
    expect(typeof cuerpo.mensaje).toBe('string');
    expect(cuerpo.campo).toBe(campo);
    const permitidos = ['codigo', 'mensaje', 'campo'];
    expect(Object.keys(cuerpo).every((k) => permitidos.includes(k))).toBe(true);
  }

  describe('201', () => {
    it('incidencia_creada: responde el esquema Incidencia completo', async () => {
      const res = await enviar(PETICION_VALIDA);

      expect(res.status).toBe(201);
      const cuerpo = res.body as Record<string, unknown>;
      expect(Object.keys(cuerpo).sort()).toEqual(
        [
          'id_incidencia',
          'codigo',
          'id_tipo_incidencia',
          'descripcion',
          'grado_severidad',
          'fecha_hora',
          'id_estado_incidencia',
          'id_operacion',
          'id_usuario',
        ].sort(),
      );
      expect(cuerpo.codigo).toMatch(/^INC-\d{4}-\d{4,}$/);
      expect(cuerpo.id_tipo_incidencia).toBe(TIPO);
      expect(cuerpo.id_operacion).toBe(OPERACION);
      expect(cuerpo.grado_severidad).toBe(4);
      expect(new Date(cuerpo.fecha_hora as string).toISOString()).toBe(
        cuerpo.fecha_hora,
      );
    });

    it('A3: id_estado_incidencia es el de «Abierta»', async () => {
      const res = await enviar(PETICION_VALIDA);
      expect((res.body as Record<string, unknown>).id_estado_incidencia).toBe(
        ESTADO_ABIERTA,
      );
    });

    it('id_usuario sale del token, no del cuerpo', async () => {
      const res = await enviar(PETICION_VALIDA);
      expect((res.body as Record<string, unknown>).id_usuario).toBe(USUARIO);
    });

    it('A8: devuelve la descripción sin los espacios de los extremos', async () => {
      const res = await enviar({
        ...PETICION_VALIDA,
        descripcion: '   Contenedor abierto   ',
      });
      expect(res.status).toBe(201);
      expect((res.body as Record<string, unknown>).descripcion).toBe(
        'Contenedor abierto',
      );
    });

    it('A10: repetir la misma petición crea otra incidencia con otro código', async () => {
      const primera = await enviar(PETICION_VALIDA);
      const segunda = await enviar(PETICION_VALIDA);
      expect(segunda.status).toBe(201);
      expect((segunda.body as Record<string, unknown>).codigo).not.toBe(
        (primera.body as Record<string, unknown>).codigo,
      );
    });
  });

  describe('400', () => {
    it('campo_ausente: falta id_operacion -> VALIDACION', async () => {
      const sinOperacion: Record<string, unknown> = { ...PETICION_VALIDA };
      delete sinOperacion.id_operacion;
      esperarError(
        await enviar(sinOperacion),
        400,
        'VALIDACION',
        'id_operacion',
      );
    });

    it('A5: id_tipo_incidencia en null -> VALIDACION', async () => {
      esperarError(
        await enviar({ ...PETICION_VALIDA, id_tipo_incidencia: null }),
        400,
        'VALIDACION',
        'id_tipo_incidencia',
      );
    });

    it.each([
      ['A4: ausente', undefined],
      ['A5: null', null],
      ['vacía', ''],
      ['solo espacios', '    '],
    ])('descripcion_vacia (%s) -> DESCRIPCION_VACIA', async (_caso, valor) => {
      esperarError(
        await enviar({ ...PETICION_VALIDA, descripcion: valor }),
        400,
        'DESCRIPCION_VACIA',
        'descripcion',
      );
    });

    it.each([
      ['fuera de rango', 9],
      ['A4: ausente', undefined],
      ['A5: null', null],
      ['A5: texto "4"', '4'],
      ['A5: decimal 4.5', 4.5],
    ])(
      'severidad_invalida (%s) -> SEVERIDAD_INVALIDA',
      async (_caso, valor) => {
        esperarError(
          await enviar({ ...PETICION_VALIDA, grado_severidad: valor }),
          400,
          'SEVERIDAD_INVALIDA',
          'grado_severidad',
        );
      },
    );

    it('A5 tipo_incorrecto: descripcion numérica -> VALIDACION', async () => {
      esperarError(
        await enviar({ ...PETICION_VALIDA, descripcion: 123 }),
        400,
        'VALIDACION',
        'descripcion',
      );
    });

    it('uuid_mal_formado: id_operacion no es UUID -> VALIDACION', async () => {
      esperarError(
        await enviar({ ...PETICION_VALIDA, id_operacion: 'op-99' }),
        400,
        'VALIDACION',
        'id_operacion',
      );
    });

    it('campo_desconocido: id_usuario en el cuerpo -> VALIDACION', async () => {
      esperarError(
        await enviar({ ...PETICION_VALIDA, id_usuario: USUARIO }),
        400,
        'VALIDACION',
        'id_usuario',
      );
    });

    it('A9 cuerpo_no_json: Content-Type text/plain -> VALIDACION', async () => {
      const res = await request(app.getHttpServer())
        .post('/v1/incidencias')
        .set('Authorization', 'Bearer token-valido')
        .set('Content-Type', 'text/plain')
        .send(JSON.stringify(PETICION_VALIDA));
      esperarError(res, 400, 'VALIDACION');
    });

    it('A9 cuerpo_no_json: cuerpo vacío -> VALIDACION', async () => {
      esperarError(await enviar({}), 400, 'VALIDACION');
    });

    it('A8 descripcion_muy_larga: más de 1000 caracteres tras recortar -> VALIDACION', async () => {
      esperarError(
        await enviar({
          ...PETICION_VALIDA,
          descripcion: `  ${'x'.repeat(1001)}  `,
        }),
        400,
        'VALIDACION',
        'descripcion',
      );
    });
    it('A9 cuerpo_no_json: JSON inválido -> VALIDACION', async () => {
      const res = await request(app.getHttpServer())
        .post('/v1/incidencias')
        .set('Authorization', 'Bearer token-valido')
        .set('Content-Type', 'application/json')
        .send('{"descripcion": ');
      esperarError(res, 400, 'VALIDACION');
    });
  });

  describe('401', () => {
    it('token_ausente_o_invalido: sin token -> 401', async () => {
      const res = await request(app.getHttpServer())
        .post('/v1/incidencias')
        .send(PETICION_VALIDA);
      esperarError(res, 401, 'NO_AUTENTICADO');
    });
  });

  describe('fuera del contrato', () => {
    it('las demás rutas conservan el formato de error de Nest', async () => {
      const res = await request(app.getHttpServer())
        .post('/monitoreo/otra-ruta')
        .send({});
      expect(res.status).toBe(404);
      expect(res.body).toMatchObject({ statusCode: 404 });
      expect(res.body).not.toHaveProperty('codigo');
    });
  });

  describe('409', () => {
    it.each(Object.entries(OPERACIONES_NO_ACTIVAS))(
      'A12 operacion_no_activa: operación %s -> OPERACION_NO_ACTIVA',
      async (_estado, idOperacion) => {
        esperarError(
          await enviar({ ...PETICION_VALIDA, id_operacion: idOperacion }),
          409,
          'OPERACION_NO_ACTIVA',
        );
      },
    );
  });

  describe('422', () => {
    it('tipo_inexistente -> TIPO_INEXISTENTE', async () => {
      esperarError(
        await enviar({ ...PETICION_VALIDA, id_tipo_incidencia: OTRO_UUID }),
        422,
        'TIPO_INEXISTENTE',
      );
    });

    it('A6: tipo y operación con problemas a la vez -> TIPO_INEXISTENTE (se revisa primero)', async () => {
      esperarError(
        await enviar({
          ...PETICION_VALIDA,
          id_tipo_incidencia: OTRO_UUID,
          id_operacion: OTRO_UUID,
        }),
        422,
        'TIPO_INEXISTENTE',
      );
    });

    it('A6 operacion_inexistente -> OPERACION_INEXISTENTE', async () => {
      esperarError(
        await enviar({ ...PETICION_VALIDA, id_operacion: OTRO_UUID }),
        422,
        'OPERACION_INEXISTENTE',
      );
    });
  });
});
