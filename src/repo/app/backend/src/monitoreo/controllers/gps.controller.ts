import { Controller, Get, Param, Query } from '@nestjs/common';
import { GpsService } from '../services/gps.service';

@Controller('monitoreo/gps')
export class GpsController {
  constructor(private readonly gpsService: GpsService) {}

  @Get('posiciones')
  getAllPosiciones() {
    return this.gpsService.getAllPosiciones();
  }

  @Get('contenedores')
  getPosicionesContenedores(
    @Query('limit') limit?: string,
    @Query('offset') offset?: string,
  ) {
    return this.gpsService.getPosicionesContenedores(
      limit ? parseInt(limit, 10) : 50,
      offset ? parseInt(offset, 10) : 0,
    );
  }

  @Get('contenedores/:id/ultima')
  getUltimaPosicionContenedor(@Param('id') id: string) {
    return this.gpsService.getUltimaPosicionContenedor(id);
  }

  @Get('contenedores/:id/historial')
  getHistorialPosicionesContenedor(
    @Param('id') id: string,
    @Query('limit') limit?: string,
  ) {
    return this.gpsService.getHistorialPosicionesContenedor(
      id,
      limit ? parseInt(limit, 10) : 50,
    );
  }
}
