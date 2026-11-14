import { ConfigService } from '@nestjs/config';
import { VictoriaMetricsService } from './victoriametrics.service';
import {
  DependenciaNoDisponibleError,
  ErrorRespuestaDependencia,
} from '../../shared/resiliencia/dependencia-no-disponible.error';

function configuracionCon(valores: Record<string, string>): ConfigService {
  return {
    get: (clave: string) => valores[clave],
  } as unknown as ConfigService;
}

function respuestaJson(cuerpo: unknown, status = 200) {
  return {
    ok: status >= 200 && status < 300,
    status,
    text: () => Promise.resolve(JSON.stringify(cuerpo)),
  };
}

describe('VictoriaMetricsService · resiliencia', () => {
  const base: Record<string, string> = {
    VICTORIA_METRICS_TIMEOUT_MS: '1000',
    VICTORIA_METRICS_CIRCUIT_ERROR_PERCENTAGE: '50',
    VICTORIA_METRICS_CIRCUIT_MIN_CALLS: '2',
    VICTORIA_METRICS_CIRCUIT_WINDOW_MS: '60000',
    VICTORIA_METRICS_CIRCUIT_RESET_MS: '60000',
  };

  let fetchMock: jest.Mock;
  let servicio: VictoriaMetricsService | undefined;

  beforeEach(() => {
    fetchMock = jest.fn();
    global.fetch = fetchMock;
  });

  afterEach(() => {
    servicio?.apagarCircuitos();
    servicio = undefined;
    jest.restoreAllMocks();
  });

  it('devuelve la serie cuando VictoriaMetrics responde', async () => {
    fetchMock.mockResolvedValue(
      respuestaJson({
        status: 'success',
        data: {
          resultType: 'matrix',
          result: [
            {
              metric: {},
              values: [
                [1_700_000_000, '25.5'],
                [1_700_003_600, '26.1'],
              ],
            },
          ],
        },
      }),
    );
    servicio = new VictoriaMetricsService(configuracionCon(base));

    const resultado = await servicio.getTemperaturaContenedor('C-1');

    expect(resultado).toEqual({
      points: [
        { timestamp: 1_700_000_000, value: 25.5 },
        { timestamp: 1_700_003_600, value: 26.1 },
      ],
      degradado: false,
    });
    expect(servicio.estadoCircuitos().circuitos.consulta.estado).toBe(
      'cerrado',
    );
  });

  it('abre el circuito y responde sin volver a llamar a la dependencia', async () => {
    fetchMock.mockRejectedValue(new Error('ECONNREFUSED'));
    servicio = new VictoriaMetricsService(configuracionCon(base));

    const primera = await servicio.getTemperaturaContenedor('C-1');
    expect(primera.degradado).toBe(true);
    expect(primera.motivo).toBe('error_dependencia');

    await servicio.getTemperaturaContenedor('C-1');
    expect(servicio.estadoCircuitos().circuitos.consulta.estado).toBe(
      'abierto',
    );

    const mientrasEstaAbierto = await servicio.getTemperaturaContenedor('C-1');
    expect(fetchMock).toHaveBeenCalledTimes(2);
    expect(mientrasEstaAbierto).toEqual({
      points: [],
      degradado: true,
      motivo: 'circuito_abierto',
      reintentarEnMs: 60_000,
    });
  });

  it('responde 503 lógico en escritura cuando el circuito está abierto', async () => {
    fetchMock.mockRejectedValue(new Error('ECONNREFUSED'));
    servicio = new VictoriaMetricsService(configuracionCon(base));

    await expect(servicio.writeLines('metrica 1 1')).rejects.toMatchObject({
      name: 'DependenciaNoDisponibleError',
      motivo: 'error_dependencia',
    });
    await expect(servicio.writeLines('metrica 1 2')).rejects.toBeInstanceOf(
      DependenciaNoDisponibleError,
    );

    await expect(servicio.writeLines('metrica 1 3')).rejects.toMatchObject({
      name: 'DependenciaNoDisponibleError',
      motivo: 'circuito_abierto',
      reintentarEnMs: 60_000,
    });
    expect(fetchMock).toHaveBeenCalledTimes(2);
  });

  it('degrada con motivo tiempo_agotado cuando la dependencia no responde', async () => {
    fetchMock.mockImplementation(
      (_url: string, init: { signal?: AbortSignal }) =>
        new Promise((_resolver, rechazar) => {
          init.signal?.addEventListener('abort', () => {
            const error = new Error('The operation was aborted due to timeout');
            error.name = 'TimeoutError';
            rechazar(error);
          });
        }),
    );
    servicio = new VictoriaMetricsService(
      configuracionCon({ ...base, VICTORIA_METRICS_TIMEOUT_MS: '25' }),
    );

    const resultado = await servicio.getTemperaturaContenedor('C-1');

    expect(resultado.degradado).toBe(true);
    expect(resultado.motivo).toBe('tiempo_agotado');
    expect(resultado.points).toEqual([]);
  });

  it('un 4xx es un error de nuestra petición: no abre el circuito', async () => {
    fetchMock.mockResolvedValue(
      respuestaJson({ status: 'error', error: 'bad query' }, 400),
    );
    servicio = new VictoriaMetricsService(configuracionCon(base));

    await expect(
      servicio.getTemperaturaContenedor('C-1'),
    ).rejects.toBeInstanceOf(ErrorRespuestaDependencia);
    await expect(
      servicio.getTemperaturaContenedor('C-1'),
    ).rejects.toBeInstanceOf(ErrorRespuestaDependencia);

    expect(servicio.estadoCircuitos().circuitos.consulta.estado).toBe(
      'cerrado',
    );
    expect(servicio.estadoCircuitos().circuitos.consulta.metricas.fallos).toBe(
      0,
    );
  });
});
