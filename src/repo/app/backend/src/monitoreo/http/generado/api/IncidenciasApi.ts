import { Injectable } from '@nestjs/common';
import { Observable } from 'rxjs';
import { CrearIncidenciaRequest, Incidencia,  } from '../models';


@Injectable()
export abstract class IncidenciasApi {

  abstract crearIncidencia(crearIncidenciaRequest: CrearIncidenciaRequest,  request: Request): Incidencia | Promise<Incidencia> | Observable<Incidencia>;

} 