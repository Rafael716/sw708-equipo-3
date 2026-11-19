import {
  Controller,
  Get,
  Param,
  Post,
  Query,
  ServiceUnavailableException,
} from '@nestjs/common';
import { VictoriaMetricsService } from '../services/victoriametrics.service';
import { SensoresService } from '../services/sensores.service';
import { DependenciaNoDisponibleError } from '../../shared/resiliencia/dependencia-no-disponible.error';

@Controller('monitoreo/vm')
export class VmDemoController {
  constructor(
    private readonly vmService: VictoriaMetricsService,
    private readonly sensoresService: SensoresService,
  ) {}

  @Get('temperatura/:contenedorId')
  async getTemperatura(@Param('contenedorId') contenedorId: string) {
    // Si el circuito está abierto responde 200 con points: [] y degradado: true,
    // porque una lectura sin datos no debe romper el panel de monitoreo.
    const resultado =
      await this.vmService.getTemperaturaContenedor(contenedorId);
    return {
      contenedorId,
      ...resultado,
    };
  }

  @Post('sync-lecturas/sensor/:sensorId')
  async syncLecturasSensor(
    @Param('sensorId') sensorId: string,
    @Query('limite') limite?: string,
  ) {
    const max = limite ? parseInt(limite, 10) || 100 : 100;
    try {
      return await this.sensoresService.syncLecturasToVictoriaMetrics(
        sensorId,
        max,
      );
    } catch (error) {
      if (error instanceof DependenciaNoDisponibleError) {
        // Una escritura no se puede fingir: el cliente debe saber que no se
        // sincronizó y cuándo reintentar.
        throw new ServiceUnavailableException({
          statusCode: 503,
          codigo: error.codigo,
          dependencia: error.dependencia,
          motivo: error.motivo,
          mensaje: error.message,
          reintentarEnMs: error.reintentarEnMs,
        });
      }
      throw error;
    }
  }

  @Get('estado-circuitos')
  estadoCircuitos() {
    return this.vmService.estadoCircuitos();
  }
}
