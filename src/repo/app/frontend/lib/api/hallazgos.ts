import { apiRequest } from "./client";

export interface TipoHallazgo {
  id_tipo_hallazgo: string;
  nombre: string;
}

export interface Inspeccion {
  id: string;
  type: string;
  date: string;
  time: string;
  priority: string;
  operationCode: string;
  inspectionCode: string;
  status: string;
}

export const hallazgosAPI = {
  getInspecciones: () => apiRequest<Inspeccion[]>("/gestion-maritima/hallazgos/inspecciones"),
  getTiposHallazgo: () => apiRequest<TipoHallazgo[]>("/gestion-maritima/hallazgos/tipos"),
  createHallazgo: (data: {
    id_tipo_hallazgo: string;
    nivel_gravedad: number;
    descripcion: string;
    accion_sugerida?: string;
    id_inspeccion: string;
  }) =>
    apiRequest("/gestion-maritima/hallazgos", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    }),
};