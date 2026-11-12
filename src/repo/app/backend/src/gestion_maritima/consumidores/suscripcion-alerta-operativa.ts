import { Injectable, OnModuleInit } from '@nestjs/common';
import { PublicadorEventosEnMemoria } from '../../monitoreo/infraestructura/publicador-eventos-en-memoria.adapter';
import { AlertaOperativaPorIncidenciaConsumer } from './alerta-operativa-por-incidencia.consumer';

/**
 * Engancha el consumidor de gestión marítima al bus en memoria al arrancar.
 * El caso de uso de monitoreo no importa este módulo.
 */
@Injectable()
export class SuscripcionAlertaOperativa implements OnModuleInit {
  constructor(
    private readonly bus: PublicadorEventosEnMemoria,
    private readonly consumidor: AlertaOperativaPorIncidenciaConsumer,
  ) {}

  onModuleInit(): void {
    this.bus.suscribir((evento) => this.consumidor.manejar(evento));
  }
}
