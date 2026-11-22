import {
  ExecutionContext,
  INestApplication,
  UnauthorizedException,
} from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import type { App } from 'supertest/types';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { IncidenciasService } from '../services/incidencias.service';
import { IncidenciasController } from './incidencias.controller';

const guardDePrueba = {
  canActivate(ctx: ExecutionContext): boolean {
    const req = ctx
      .switchToHttp()
      .getRequest<{ headers: Record<string, string>; user?: unknown }>();
    if (req.headers.authorization !== 'Bearer token-valido') {
      throw new UnauthorizedException();
    }
    req.user = { id_usuario: 'user-1' };
    return true;
  },
};

describe('IncidenciasController (RN-08)', () => {
  let app: INestApplication<App>;
  const incidenciasService = {
    findAll: jest.fn(),
    getEstadisticas: jest.fn(),
    getTiposIncidencia: jest.fn(),
    getEstadosIncidencia: jest.fn(),
    findOne: jest.fn(),
    update: jest.fn().mockResolvedValue({ id_incidencia: 'inc-1' }),
  };

  beforeEach(async () => {
    jest.clearAllMocks();
    const modulo = await Test.createTestingModule({
      controllers: [IncidenciasController],
      providers: [
        { provide: IncidenciasService, useValue: incidenciasService },
      ],
    })
      .overrideGuard(JwtAuthGuard)
      .useValue(guardDePrueba)
      .compile();

    app = modulo.createNestApplication();
    await app.init();
  });

  afterEach(async () => {
    await app.close();
  });

  it('DELETE /monitoreo/incidencias/:id responde 404 (ruta retirada)', async () => {
    await request(app.getHttpServer())
      .delete('/monitoreo/incidencias/inc-1')
      .set('Authorization', 'Bearer token-valido')
      .expect(404);
  });

  it('PUT /monitoreo/incidencias/:id delega en update con body operativo', async () => {
    const body = {
      descripcion: 'Nueva descripción',
      grado_severidad: 3,
      id_estado_incidencia: 'estado-2',
    };

    await request(app.getHttpServer())
      .put('/monitoreo/incidencias/inc-1')
      .set('Authorization', 'Bearer token-valido')
      .send(body)
      .expect(200);

    expect(incidenciasService.update).toHaveBeenCalledWith('inc-1', body);
  });
});
