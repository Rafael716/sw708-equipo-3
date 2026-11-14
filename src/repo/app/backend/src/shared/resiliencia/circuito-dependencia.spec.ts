import { CircuitoDependencia } from './circuito-dependencia';

describe('CircuitoDependencia (opossum)', () => {
  const configuracion = {
    nombre: 'prueba',
    tiempoMaximoMs: 1_000,
    porcentajeErrores: 50,
    minimoLlamadas: 3,
    ventanaMs: 1_000,
    esperaAntesDeProbarMs: 100,
  };

  afterEach(() => {
    jest.useRealTimers();
  });

  it('no abre el circuito antes del mínimo de llamadas', async () => {
    const accion = jest.fn().mockRejectedValue(new Error('caída'));
    const respaldo = jest.fn().mockReturnValue('respaldo');
    const circuito = new CircuitoDependencia<[], string>(
      configuracion,
      accion,
      respaldo,
    );

    await expect(circuito.ejecutar()).resolves.toBe('respaldo');
    await expect(circuito.ejecutar()).resolves.toBe('respaldo');

    expect(accion).toHaveBeenCalledTimes(2);
    expect(circuito.estado).toBe('cerrado');
    circuito.apagar();
  });

  it('abre al superar el porcentaje de errores y deja de llamar a la dependencia', async () => {
    const accion = jest.fn().mockRejectedValue(new Error('caída'));
    const respaldo = jest.fn().mockReturnValue('respaldo');
    const circuito = new CircuitoDependencia<[], string>(
      configuracion,
      accion,
      respaldo,
    );

    await circuito.ejecutar();
    await circuito.ejecutar();
    await circuito.ejecutar();

    expect(circuito.estado).toBe('abierto');
    expect(accion).toHaveBeenCalledTimes(3);

    // Con el circuito abierto, opossum falla rápido y usa el respaldo.
    await expect(circuito.ejecutar()).resolves.toBe('respaldo');
    expect(accion).toHaveBeenCalledTimes(3);
    expect(circuito.metricas().rechazosPorCircuitoAbierto).toBe(1);

    circuito.apagar();
  });

  it('pasa a media apertura tras la espera y cierra si la prueba sale bien', async () => {
    jest.useFakeTimers();

    const accion = jest.fn().mockRejectedValue(new Error('caída'));
    const circuito = new CircuitoDependencia<[], string>(
      configuracion,
      accion,
      () => 'respaldo',
    );

    await circuito.ejecutar();
    await circuito.ejecutar();
    // La tercera llamada ya encuentra el circuito abierto (mínimo = 3):
    // la acción falla, abre y el respaldo responde.
    await circuito.ejecutar();
    expect(circuito.estado).toBe('abierto');

    jest.advanceTimersByTime(configuracion.esperaAntesDeProbarMs + 10);
    expect(circuito.estado).toBe('medio_abierto');

    accion.mockResolvedValue('ok');
    await expect(circuito.ejecutar()).resolves.toBe('ok');
    expect(circuito.estado).toBe('cerrado');

    circuito.apagar();
  });

  it('ignora los errores filtrados: no cuentan ni abren el circuito', async () => {
    class ErrorDePeticion extends Error {}

    const accion = jest
      .fn()
      .mockRejectedValue(new ErrorDePeticion('400 de nuestra petición'));
    const circuito = new CircuitoDependencia<[], string>(
      {
        ...configuracion,
        minimoLlamadas: 2,
        ignorarError: (error) => error instanceof ErrorDePeticion,
      },
      accion,
      () => 'no debería usarse',
    );

    await expect(circuito.ejecutar()).rejects.toBeInstanceOf(ErrorDePeticion);
    await expect(circuito.ejecutar()).rejects.toBeInstanceOf(ErrorDePeticion);

    expect(circuito.estado).toBe('cerrado');
    expect(circuito.metricas().fallos).toBe(0);
    circuito.apagar();
  });

  it('usa el respaldo cuando la acción supera el timeout', async () => {
    const circuito = new CircuitoDependencia<[], string>(
      { ...configuracion, tiempoMaximoMs: 25 },
      () => new Promise<string>(() => undefined),
      () => 'respaldo por timeout',
    );

    await expect(circuito.ejecutar()).resolves.toBe('respaldo por timeout');
    expect(circuito.metricas().timeouts).toBe(1);
    circuito.apagar();
  });
});
