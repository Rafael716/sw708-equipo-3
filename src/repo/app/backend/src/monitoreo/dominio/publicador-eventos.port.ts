import { IncidenciaRegistrada } from './incidencia-registrada.evento';

/**
 * Puerto de salida: publicar eventos de dominio sin acoplar a un broker.
 * Un adaptador en memoria basta; cambiar a Rabbit/Kafka es cambiar el adaptador.
 */
export interface PublicadorEventos {
  publicar(evento: IncidenciaRegistrada): Promise<void>;
}

export const PUBLICADOR_EVENTOS = 'PUBLICADOR_EVENTOS';
