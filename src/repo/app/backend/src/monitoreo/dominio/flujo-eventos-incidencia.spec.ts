import { AlertaOperativaPorIncidenciaConsumer } from '../../gestion_maritima/consumidores/alerta-operativa-por-incidencia.consumer';
import { IncidenciasEnMemoriaAdapter } from '../infraestructura/incidencias-en-memoria.adapter';
import { PublicadorEventosEnMemoria } from '../infraestructura/publicador-eventos-en-memoria.adapter';
import { RegistrarIncidenciaUseCase } from './registrar-incidencia.use-case';

/**
 * Paso 6: extremo a extremo sin broker.
 * Caso de uso → evento IncidenciaRegistrada → consumidor de gestión marítima.
 */
describe('Flujo por eventos: IncidenciaRegistrada → alerta operativa', () => {
  const COMANDO = {
    idTipoIncidencia: 'tipo-1',
    descripcion: 'Pérdida total de refrigeración',
    gradoSeveridad: 5,
    idOperacion: 'op-99',
    idUsuario: 'user-42',
  };

  function armarFlujo() {
    const incidencias = new IncidenciasEnMemoriaAdapter();
    incidencias.sembrarTipo('tipo-1');
    incidencias.sembrarEstadoInicial('estado-abierta');
    incidencias.sembrarOperacionActiva('op-99');

    const publicador = new PublicadorEventosEnMemoria();
    const consumidor = new AlertaOperativaPorIncidenciaConsumer();
    publicador.suscribir((evento) => consumidor.manejar(evento));

    const useCase = new RegistrarIncidenciaUseCase(incidencias, publicador);
    return { useCase, incidencias, consumidor, publicador };
  }

  it('al registrar una incidencia crítica, el consumidor de gestión marítima crea una alerta', async () => {
    const { useCase, incidencias, consumidor } = armarFlujo();

    const creada = await useCase.ejecutar(COMANDO);

    expect(incidencias.listar()).toHaveLength(1);
    expect(consumidor.listarAlertas()).toEqual([
      expect.objectContaining({
        idIncidencia: creada.idIncidencia,
        codigoIncidencia: creada.codigo,
        idOperacion: 'op-99',
        gradoSeveridad: 5,
      }),
    ]);
  });

  it('una incidencia no crítica no genera alerta operativa en el otro módulo', async () => {
    const { useCase, consumidor } = armarFlujo();

    await useCase.ejecutar({ ...COMANDO, gradoSeveridad: 4 });

    expect(consumidor.listarAlertas()).toHaveLength(0);
  });

  it('si el consumidor falla, la incidencia igual queda registrada', async () => {
    const incidencias = new IncidenciasEnMemoriaAdapter();
    incidencias.sembrarTipo('tipo-1');
    incidencias.sembrarEstadoInicial('estado-abierta');
    incidencias.sembrarOperacionActiva('op-99');

    const publicador = new PublicadorEventosEnMemoria();
    publicador.suscribir(async () => {
      throw new Error('Consumidor de gestión marítima caído');
    });

    const useCase = new RegistrarIncidenciaUseCase(incidencias, publicador);
    const creada = await useCase.ejecutar(COMANDO);

    expect(creada.gradoSeveridad).toBe(5);
    expect(incidencias.listar()).toHaveLength(1);
  });
});
