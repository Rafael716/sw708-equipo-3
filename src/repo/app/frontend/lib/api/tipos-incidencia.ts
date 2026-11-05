import { apiRequest } from "./client";

export interface TipoIncidencia {
  id_tipo_incidencia: string;
  nombre: string;
}

export const tiposIncidenciaAPI = {
  getTipos: () => apiRequest<TipoIncidencia[]>("/gestion-maritima/tipos-incidencia"),
};