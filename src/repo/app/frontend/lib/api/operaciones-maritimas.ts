import { apiRequest } from "./client";

export interface OperacionMaritima {
  code: string;
  containers: number;
  status: string;
  progress: number;
  ship: string;
  merchandise: string;
  correctionNote: string | null;
}

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  limit: number;
  totalPages: number;
}

export const operacionesAPI = {
  getOperaciones: (page: number, limit: number) =>
    apiRequest<PaginatedResponse<OperacionMaritima>>(
      `/gestion-maritima/operaciones-maritimas?page=${page}&limit=${limit}`,
    ),
};