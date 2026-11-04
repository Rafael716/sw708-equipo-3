import { apiRequest } from "./client";

export interface CreateIncidencia {
  codigo_operacion: string;
  descripcion: string;
  grado_severidad: number;
  id_tipo_incidencia: string;
}

export const incidenciasAPI = {
  create: (data: CreateIncidencia, token: string) =>
    apiRequest("/gestion-maritima/incidencias", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify(data),
    }),
};