import { RegistrarIncidenciaUseCase } from './registrar-incidencia.use-case';
import { Incidencias } from './incidencias.port';
import { IncidenciasEnMemoriaAdapter } from '../infraestructura/incidencias-en-memoria.adapter';
import { IncidenciasTypeormAdapter } from '../infraestructura/incidencias-typeorm.adapter';

const COMANDO_VALIDO = {
  idTipoIncidencia: 'tipo-1',
  descripcion: 'Sensor de temperatura fuera de rango',
  gradoSeveridad: 4,
  idOperacion: 'op-99',
  idUsuario: 'user-42',
};

function prepararMemoria(): IncidenciasEnMemoriaAdapter {
  const adaptador = new IncidenciasEnMemoriaAdapter();
  adaptador.sembrarTipo('tipo-1');
  adaptador.sembrarEstadoInicial('estado-abierta');
  adaptador.sembrarOperacionActiva('op-99');
  return adaptador;
}

/** TypeORM sin base real: repositorios stub (prueba de dominio / intercambio). */
function prepararTypeormStub(): Incidencias {
  const tipoRepo = {
    findOne: jest.fn(async ({ where }: any) =>
      where.id_tipo_incidencia === 'tipo-1' ? { id_tipo_incidencia: 'tipo-1' } : null,
    ),
  };
  const estadoRepo = {
    findOne: jest.fn(async ({ where }: any) =>
      where.nombre === 'Abierta'
        ? { id_estado_incidencia: 'estado-abierta', nombre: 'Abierta' }
        : null,
    ),
  };
  const operacionRepo = {
    findOne: jest.fn(async ({ where }: any) =>
      where.id_operacion === 'op-99'
        ? {
            id_operacion: 'op-99',
            estado_operacion: { nombre: 'En curso' },
          }
        : null,
    ),
  };
  const incidenciaRepo = {
    create: jest.fn((data: any) => data),
    save: jest.fn(async (data: any) => ({
      ...data,
      id_incidencia: 'uuid-generado',
      fecha_hora: new Date('2026-10-14T12:00:00Z'),
    })),
    createQueryBuilder: jest.fn(() => ({
      where: () => ({
        andWhere: () => ({
          getCount: async () => 0,
        }),
      }),
    })),
  };
  const notificacionRepo = {
    create: jest.fn((data: any) => data),
    save: jest.fn(async (data: any) => data),
  };
  const tipoNotificacionRepo = {
    findOne: jest.fn(async () => null),
    find: jest.fn(async () => []),
  };
  const sensorRepo = { find: jest.fn(async () => []) };
  const reporteRepo = { find: jest.fn(async () => []) };

  return new IncidenciasTypeormAdapter(
    incidenciaRepo as any,
    tipoRepo as any,
    estadoRepo as any,
    operacionRepo as any,
    notificacionRepo as any,
    tipoNotificacionRepo as any,
    sensorRepo as any,
    reporteRepo as any,
  );
}

function suiteDominio(nombre: string, crearAdaptador: () => Incidencias) {
  describe(`RegistrarIncidenciaUseCase (${nombre})`, () => {
    let useCase: RegistrarIncidenciaUseCase;

    beforeEach(() => {
      useCase = new RegistrarIncidenciaUseCase(crearAdaptador());
    });

    it('registra una incidencia válida', async () => {
      const creada = await useCase.ejecutar(COMANDO_VALIDO);

      expect(creada.idTipoIncidencia).toBe('tipo-1');
      expect(creada.descripcion).toBe('Sensor de temperatura fuera de rango');
      expect(creada.gradoSeveridad).toBe(4);
      expect(creada.idEstadoIncidencia).toBe('estado-abierta');
      expect(creada.idUsuario).toBe('user-42');
      expect(creada.fechaHora).toBeInstanceOf(Date);
      expect(creada.codigo).toMatch(/^INC-\d{4}-\d{4}$/);
    });

    it('rechaza severidad fuera de 1..5', async () => {
      await expect(
        useCase.ejecutar({ ...COMANDO_VALIDO, gradoSeveridad: 9 }),
      ).rejects.toThrow('El grado de severidad debe ser un entero entre 1 y 5');
    });

    it('rechaza operación que no está activa', async () => {
      await expect(
        useCase.ejecutar({ ...COMANDO_VALIDO, idOperacion: 'op-inactiva' }),
      ).rejects.toThrow('La operación no está activa');
    });

    it('rechaza si no hay estados configurados', async () => {
      const vacio = new IncidenciasEnMemoriaAdapter();
      vacio.sembrarTipo('tipo-1');
      vacio.sembrarOperacionActiva('op-99');
      const caso = new RegistrarIncidenciaUseCase(vacio);

      await expect(caso.ejecutar(COMANDO_VALIDO)).rejects.toThrow(
        'No hay estados de incidencia configurados',
      );
    });
  });
}

/** Misma prueba de dominio con los dos adaptadores del puerto. */
suiteDominio('adaptador en memoria', () => prepararMemoria());
suiteDominio('adaptador TypeORM (stub)', () => prepararTypeormStub());

describe('RegistrarIncidenciaUseCase — notificación a supervisores (E3)', () => {
  it('notifica a supervisores cuando la severidad es crítica (5)', async () => {
    const adaptador = prepararMemoria();
    const useCase = new RegistrarIncidenciaUseCase(adaptador);

    await useCase.ejecutar({ ...COMANDO_VALIDO, gradoSeveridad: 5 });

    expect(adaptador.listarNotificacionesSupervisores()).toHaveLength(1);
    expect(adaptador.listarNotificacionesSupervisores()[0].gradoSeveridad).toBe(5);
  });

  it('no notifica cuando la severidad no es crítica', async () => {
    const adaptador = prepararMemoria();
    const useCase = new RegistrarIncidenciaUseCase(adaptador);

    await useCase.ejecutar({ ...COMANDO_VALIDO, gradoSeveridad: 4 });

    expect(adaptador.listarNotificacionesSupervisores()).toHaveLength(0);
  });
});

describe('RegistrarIncidenciaUseCase — largo de la descripción (acta A8)', () => {
  const ejecutar = (descripcion: string) =>
    new RegistrarIncidenciaUseCase(prepararMemoria()).ejecutar({
      ...COMANDO_VALIDO,
      descripcion,
    });

  it('A8: acepta exactamente 1000 caracteres', async () => {
    const creada = await ejecutar('x'.repeat(1000));
    expect(creada.descripcion).toHaveLength(1000);
  });

  it('A8: rechaza 1001 caracteres con VALIDACION en descripcion', async () => {
    await expect(ejecutar('x'.repeat(1001))).rejects.toMatchObject({
      codigo: 'VALIDACION',
      campo: 'descripcion',
    });
  });

  it('A8: mide después de recortar: 1000 caracteres más espacios se aceptan y se guardan recortados', async () => {
    const creada = await ejecutar(`   ${'x'.repeat(1000)}   `);
    expect(creada.descripcion).toBe('x'.repeat(1000));
  });
});
