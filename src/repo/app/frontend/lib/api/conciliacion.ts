import { apiRequest } from "./client";

export interface DashboardKpis {
  total_operaciones: number;
  operaciones_activas: number;
  operaciones_finalizadas: number;
  total_incidencias: number;
  incidencias_criticas: number;
  correcciones_recientes: number;
  intervencion_manual: number;
}

export interface DashboardMetricas {
  kpis: DashboardKpis;
  tendencia_correcciones: {
    fecha: string;
    cantidad_correcciones: string;
  }[];
  distribucion_correcciones: {
    tipo_correccion: string;
    cantidad: string;
  }[];
}

export interface OperacionMaritima {
  id_operacion: string;
  codigo_operacion: string;
  fecha_inicio: string;
  fecha_fin: string | null;
  estado: string;
  buque: string;
  matricula: string;
  porcentaje_trayecto: number;
  total_incidencias: number;
  incidencias_criticas: number;
  fue_corregida: boolean;
  tipo_correccion: string | null;
  descripcion_correccion: string | null;
  fecha_correccion: string | null;
}

export interface EstadoOperacionItem {
  id_estado_operacion: string;
  nombre: string;
}

export interface DetalleOperacionMaritima {
  id_operacion: string;
  id_operacion_maritima?: string;
  codigo_operacion: string;
  codigo_maritimo?: string;
  fecha_inicio: string;
  fecha_fin: string | null;
  id_estado_operacion?: string;
  estado: string;
  porcentaje_trayecto: number;
  estatus_navegacion?: string;
  cantidad_contenedores?: number;
  buque?: {
    id_buque?: string;
    nombre: string;
    matricula: string;
    capacidad?: number;
    peso?: number;
    ubicacion_actual?: string;
    estado?: string;
  };
  ruta?: {
    id_ruta_maritima?: string;
    codigo?: string;
    distancia?: number;
    origen?: {
      puerto?: string;
      pais?: string;
      muelle?: string | null;
    };
    destino?: {
      puerto?: string;
      pais?: string;
      muelle?: string | null;
    };
  } | null;
  contenedores: {
    id_contenedor?: string;
    codigo: string;
    tipo?: string;
    peso?: number;
    capacidad?: number;
    dimensiones?: string;
    estado?: string;
    fecha_asignacion?: string;
  }[];
  tripulacion: {
    id_empleado?: string;
    nombre: string;
    apellido?: string;
    codigo?: string;
    dni?: string;
    nacionalidad?: string;
    disponibilidad?: boolean;
    fecha_asignacion?: string;
  }[];
  incidencias: {
    id_incidencia?: string;
    codigo?: string;
    descripcion?: string;
    grado_severidad?: number;
    fecha_hora?: string;
    tipo?: string;
    estado?: string;
  }[];
  correccion?: {
    tipo_correccion?: string;
    descripcion_correccion?: string;
    fecha_correccion?: string;
    correccion_aplicada?: boolean;
    requiere_intervencion_manual?: boolean;
    duracion_real_horas?: number;
  } | null;
}

export const conciliacionAPI = {
  getMetricas: () => apiRequest<DashboardMetricas>("/gestion-maritima/dashboard/metricas"),
  getOperaciones: () => apiRequest<OperacionMaritima[]>("/gestion-maritima/operaciones"),
  ejecutarBatch: () =>
    apiRequest<{ message: string; fecha_corte: string }>("/gestion-maritima/conciliacion-nocturna", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({}),
    }),
  getEstados: async (): Promise<EstadoOperacionItem[]> => {
    try {
      return await apiRequest<EstadoOperacionItem[]>("/gestion-maritima/operaciones-maritimas/estados");
    } catch {
      return await apiRequest<EstadoOperacionItem[]>("/monitoreo/estados");
    }
  },
  getOperacionDetalle: async (id: string): Promise<DetalleOperacionMaritima> => {
    try {
      return await apiRequest<DetalleOperacionMaritima>(`/gestion-maritima/operaciones-maritimas/${id}`);
    } catch {
      // Fallback a monitoreo
      const baseOp = await apiRequest<any>(`/monitoreo/operaciones/${id}`);
      return {
        id_operacion: baseOp.id_operacion,
        id_operacion_maritima: '',
        codigo_operacion: baseOp.codigo,
        codigo_maritimo: baseOp.codigo ? baseOp.codigo.replace('OP-', 'OPM-') : '',
        fecha_inicio: baseOp.fecha_inicio,
        fecha_fin: baseOp.fecha_fin,
        id_estado_operacion: baseOp.id_estado_operacion,
        estado: baseOp.estado_operacion?.nombre || 'Desconocido',
        porcentaje_trayecto: 0,
        estatus_navegacion: 'En Navegación',
        cantidad_contenedores: baseOp.contenedores?.length || 0,
        buque: baseOp.buque || { nombre: 'N/A', matricula: 'N/A' },
        ruta: null,
        contenedores: baseOp.contenedores || [],
        tripulacion: baseOp.operador
          ? [{ nombre: baseOp.operador.nombre, apellido: '', codigo: 'OPR', dni: '', nacionalidad: 'N/A', disponibilidad: true }]
          : [],
        incidencias: [],
        correccion: null,
      };
    }
  },
  actualizarEstado: async (id: string, id_estado_operacion: string, estado_nombre?: string) => {
    try {
      return await apiRequest<{ message: string; estado_nuevo?: string }>(
        `/gestion-maritima/operaciones-maritimas/${id}/estado`,
        {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ id_estado_operacion, estado_nombre }),
        }
      );
    } catch {
      return await apiRequest<any>(`/monitoreo/operaciones/${id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id_estado_operacion }),
      });
    }
  },
};