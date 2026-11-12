import { IncidenciaRegistrada } from '../dominio/incidencia-registrada.evento';
import { PublicadorEventos } from '../dominio/publicador-eventos.port';

export type ManejadorIncidenciaRegistrada = (
  evento: IncidenciaRegistrada,
) => Promise<void> | void;

/**
 * Adaptador en memoria del puerto de eventos.
 * Los consumidores se suscriben; el caso de uso solo llama a `publicar`.
 */
export class PublicadorEventosEnMemoria implements PublicadorEventos {
  private readonly manejadores: ManejadorIncidenciaRegistrada[] = [];

  suscribir(manejador: ManejadorIncidenciaRegistrada): void {
    this.manejadores.push(manejador);
  }

  async publicar(evento: IncidenciaRegistrada): Promise<void> {
    for (const manejador of this.manejadores) {
      await manejador(evento);
    }
  }
}
