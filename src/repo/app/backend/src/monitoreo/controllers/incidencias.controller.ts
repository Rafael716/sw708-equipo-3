import {
  Controller,
  Get,
  Put,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
} from '@nestjs/common';
import { IncidenciasService } from '../services/incidencias.service';
import type { UpdateIncidenciaDto } from '../services/incidencias.service';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

@Controller('monitoreo/incidencias')
export class IncidenciasController {
  // El alta de incidencias está en POST /v1/incidencias (http/incidencias-v1.controller.ts),
  // según el contrato semana-10/docs/api/openapi.yaml.
  constructor(private readonly incidenciasService: IncidenciasService) {}

  @Get()
  findAll(@Query() filtros: any) {
    return this.incidenciasService.findAll(filtros);
  }

  @Get('estadisticas')
  getEstadisticas() {
    return this.incidenciasService.getEstadisticas();
  }

  @Get('tipos')
  getTiposIncidencia() {
    return this.incidenciasService.getTiposIncidencia();
  }

  @Get('estados')
  getEstadosIncidencia() {
    return this.incidenciasService.getEstadosIncidencia();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.incidenciasService.findOne(id);
  }

  @Put(':id')
  @UseGuards(JwtAuthGuard)
  update(@Param('id') id: string, @Body() data: UpdateIncidenciaDto) {
    return this.incidenciasService.update(id, data);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  remove(@Param('id') id: string) {
    return this.incidenciasService.remove(id);
  }
}
