import { ServiceUnavailableException } from '@nestjs/common';
import { VmDemoController } from './vm-demo.controller';
import { DependenciaNoDisponibleError } from '../../shared/resiliencia/dependencia-no-disponible.error';

describe('VmDemoController · respuesta con el circuito abierto', () => {
  const vmService = {
    getTemperaturaContenedor: jest.fn(),
    estadoCircuitos: jest.fn(),
  };
  const sensoresService = {
    syncLecturasToVictoriaMetrics: jest.fn(),
  };
  const controller = new VmDemoController(
    vmService as never,
    sensoresService as never,
  );

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('lectura: responde 200 con serie vacía y bandera de degradación', async () => {
    vmService.getTemperaturaContenedor.mockResolvedValue({
      points: [],
      degradado: true,
      motivo: 'circuito_abierto',
      reintentarEnMs: 15_000,
    });

    await expect(controller.getTemperatura('C-1')).resolves.toEqual({
      contenedorId: 'C-1',
      points: [],
      degradado: true,
      motivo: 'circuito_abierto',
      reintentarEnMs: 15_000,
    });
  });

  it('escritura: traduce el error de dependencia a 503 con reintento', async () => {
    sensoresService.syncLecturasToVictoriaMetrics.mockRejectedValue(
      new DependenciaNoDisponibleError(
        'victoriametrics',
        'circuito_abierto',
        15_000,
        'VictoriaMetrics no está disponible: el circuito está abierto.',
      ),
    );

    await expect(controller.syncLecturasSensor('S-1')).rejects.toBeInstanceOf(
      ServiceUnavailableException,
    );

    await expect(controller.syncLecturasSensor('S-1')).rejects.toMatchObject({
      response: {
        statusCode: 503,
        codigo: 'DEPENDENCIA_NO_DISPONIBLE',
        dependencia: 'victoriametrics',
        motivo: 'circuito_abierto',
        reintentarEnMs: 15_000,
      },
    });
  });
});
