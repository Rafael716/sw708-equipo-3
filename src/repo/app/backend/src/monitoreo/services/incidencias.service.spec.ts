import { IncidenciasService } from './incidencias.service';

describe('IncidenciasService.update (RN-08)', () => {
  const incidenciaExistente = {
    id_incidencia: 'inc-1',
    codigo: 'INC-2611-0001',
    descripcion: 'Original',
    grado_severidad: 2,
    fecha_hora: new Date('2026-01-15T10:00:00.000Z'),
    id_usuario: 'user-alta',
    id_tipo_incidencia: 'tipo-1',
    id_estado_incidencia: 'estado-1',
    id_operacion: 'op-1',
    tipo_incidencia: { id_tipo_incidencia: 'tipo-1', nombre: 'Avería' },
    estado_incidencia: { id_estado_incidencia: 'estado-1', nombre: 'Abierta' },
    operacion: { codigo: 'OP-1' },
  };

  let service: IncidenciasService;
  let incidenciaRepository: {
    findOne: jest.Mock;
    update: jest.Mock;
    remove: jest.Mock;
  };
  let tipoIncidenciaRepository: { findOne: jest.Mock };
  let estadoIncidenciaRepository: { findOne: jest.Mock };

  beforeEach(() => {
    incidenciaRepository = {
      findOne: jest.fn().mockResolvedValue(incidenciaExistente),
      update: jest.fn().mockResolvedValue({ affected: 1 }),
      remove: jest.fn(),
    };
    tipoIncidenciaRepository = {
      findOne: jest.fn().mockResolvedValue({ id_tipo_incidencia: 'tipo-2' }),
    };
    estadoIncidenciaRepository = {
      findOne: jest.fn().mockResolvedValue({ id_estado_incidencia: 'estado-2' }),
    };

    service = new IncidenciasService(
      incidenciaRepository as never,
      tipoIncidenciaRepository as never,
      estadoIncidenciaRepository as never,
    );
  });

  it('no persiste id_usuario ni fecha_hora aunque vengan en el body', async () => {
    await service.update('inc-1', {
      descripcion: 'Actualizada',
      grado_severidad: 4,
      id_tipo_incidencia: 'tipo-2',
      id_estado_incidencia: 'estado-2',
      // @ts-expect-error campos de auditoría no forman parte del DTO público
      id_usuario: 'atacante',
      // @ts-expect-error
      fecha_hora: new Date('2099-01-01T00:00:00.000Z'),
    });

    expect(incidenciaRepository.update).toHaveBeenCalledWith('inc-1', {
      descripcion: 'Actualizada',
      grado_severidad: 4,
      id_tipo_incidencia: 'tipo-2',
      id_estado_incidencia: 'estado-2',
    });
    expect(incidenciaRepository.update.mock.calls[0][1]).not.toHaveProperty(
      'id_usuario',
    );
    expect(incidenciaRepository.update.mock.calls[0][1]).not.toHaveProperty(
      'fecha_hora',
    );
  });

  it('no expone remove (método eliminado)', () => {
    expect(
      (service as unknown as { remove?: unknown }).remove,
    ).toBeUndefined();
  });
});
