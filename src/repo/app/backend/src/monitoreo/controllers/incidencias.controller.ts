import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
  Request,
  BadRequestException,
} from '@nestjs/common';
import { IncidenciasService } from '../services/incidencias.service';
import type { CreateIncidenciaDto, UpdateIncidenciaDto } from '../services/incidencias.service';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { RegistrarIncidenciaUseCase } from '../dominio/registrar-incidencia.use-case';

@Controller('monitoreo/incidencias')
export class IncidenciasController {
  constructor(
    private readonly incidenciasService: IncidenciasService,
    private readonly registrarIncidenciaUseCase: RegistrarIncidenciaUseCase,
  ) {}

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

  @Post()
  @UseGuards(JwtAuthGuard)
  async create(@Request() req, @Body() data: CreateIncidenciaDto) {
    const id_usuario = req.user?.id_usuario;
    try {
      const creada = await this.registrarIncidenciaUseCase.ejecutar({
        idTipoIncidencia: data.id_tipo_incidencia,
        descripcion: data.descripcion,
        gradoSeveridad: data.grado_severidad,
        idOperacion: data.id_operacion,
        idUsuario: id_usuario,
      });
      return this.incidenciasService.findOne(creada.idIncidencia);
    } catch (error: any) {
      throw new BadRequestException(error.message);
    }
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
