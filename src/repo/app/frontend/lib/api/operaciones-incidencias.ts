import { apiRequest } from "./client";
import type { PaginatedResponse } from "./operaciones-maritimas";

export interface Incidencia {
  id_incidencia: string;
  codigo: string;
  tipo_incidencia: string;
  grado_severidad: number;
  fecha_hora: string;
  descripcion: string;
  estado: string;
  usuario: string;
}

export interface OperacionConIncidencias {
  codigo_operacion: string;
  tipo_operacion: string;
  buque: string;
  incidencias: Incidencia[];
}

export const operacionesIncidenciasAPI = {
  getOperacionesConIncidencias: (
    page: number,
    limit: number,
    search?: string,
    severidadMin?: number,
  ) => {
    const params = new URLSearchParams({ page: String(page), limit: String(limit) });
    if (search) params.set("search", search);
    if (severidadMin !== undefined) params.set("severidadMin", String(severidadMin));
    return apiRequest<PaginatedResponse<OperacionConIncidencias>>(
      `/gestion-maritima/operaciones-incidencias?${params.toString()}`,
    );
  },
};