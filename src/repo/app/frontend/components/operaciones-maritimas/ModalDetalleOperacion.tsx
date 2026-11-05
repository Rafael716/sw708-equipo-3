"use client";

import React, { useState, useEffect } from "react";
import { conciliacionAPI, type DetalleOperacionMaritima } from "@/lib/api/conciliacion";

interface ModalDetalleOperacionProps {
  idOperacion: string | null;
  isOpen: boolean;
  onClose: () => void;
  onAbrirCambiarEstado: (id: string, codigo: string, estadoActual: string) => void;
}

export function ModalDetalleOperacion({
  idOperacion,
  isOpen,
  onClose,
  onAbrirCambiarEstado,
}: ModalDetalleOperacionProps) {
  const [detalle, setDetalle] = useState<DetalleOperacionMaritima | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState<"general" | "ruta" | "contenedores" | "tripulacion" | "incidencias">("general");

  useEffect(() => {
    if (isOpen && idOperacion) {
      cargarDetalle(idOperacion);
    } else {
      setDetalle(null);
      setError(null);
      setActiveTab("general");
    }
  }, [isOpen, idOperacion]);

  const cargarDetalle = async (id: string) => {
    try {
      setLoading(true);
      setError(null);
      const data = await conciliacionAPI.getOperacionDetalle(id);
      setDetalle(data);
    } catch (err: any) {
      console.error("Error al obtener detalle de la operación:", err);
      setError("No se pudo cargar la información detallada de la operación.");
    } finally {
      setLoading(false);
    }
  };

  if (!isOpen) return null;

  const getEstadoBadgeClass = (estado: string) => {
    switch (estado.toLowerCase()) {
      case "en curso":
        return "bg-sky-100 text-sky-800 border-sky-200";
      case "completada":
        return "bg-emerald-100 text-emerald-800 border-emerald-200";
      case "programada":
        return "bg-indigo-100 text-indigo-800 border-indigo-200";
      case "en espera":
        return "bg-amber-100 text-amber-800 border-amber-200";
      case "cancelada":
        return "bg-red-100 text-red-800 border-red-200";
      default:
        return "bg-gray-100 text-gray-800 border-gray-200";
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center overflow-y-auto bg-black/60 p-4 backdrop-blur-sm animate-in fade-in duration-200">
      <div
        className="relative w-full max-w-4xl rounded-2xl bg-white shadow-2xl overflow-hidden flex flex-col max-h-[90vh]"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="flex items-start justify-between border-b border-gray-100 bg-gradient-to-r from-gray-50 to-white px-6 py-5">
          <div>
            <div className="flex items-center gap-3">
              <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-100 text-xl text-[#e54c2a]">
                🚢
              </span>
              <div>
                <div className="flex items-center gap-2">
                  <h2 className="text-xl font-bold text-gray-900">
                    {detalle?.codigo_operacion || "Cargando operación..."}
                  </h2>
                  {detalle?.codigo_maritimo && (
                    <span className="rounded bg-gray-100 px-2 py-0.5 text-xs font-mono text-gray-600">
                      {detalle.codigo_maritimo}
                    </span>
                  )}
                  {detalle?.estado && (
                    <span
                      className={`inline-flex rounded-full border px-2.5 py-0.5 text-xs font-semibold ${getEstadoBadgeClass(
                        detalle.estado
                      )}`}
                    >
                      {detalle.estado}
                    </span>
                  )}
                </div>
                <p className="text-xs text-gray-500 mt-0.5">
                  ID Operación: {idOperacion}
                </p>
              </div>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="flex h-8 w-8 items-center justify-center rounded-lg text-gray-400 hover:bg-gray-100 hover:text-gray-700 transition"
          >
            ✕
          </button>
        </div>

        {/* Barra de Progreso */}
        {detalle && (
          <div className="bg-sky-50/60 border-b border-sky-100 px-6 py-3 flex items-center justify-between text-xs">
            <div className="flex items-center gap-2">
              <span className="font-medium text-sky-900">Estatus:</span>
              <span className="inline-flex rounded-md bg-white border border-sky-200 px-2 py-0.5 font-semibold text-sky-700">
                {detalle.estatus_navegacion || "En Puerto"}
              </span>
            </div>
            <div className="flex items-center gap-3 w-1/2 max-w-xs">
              <span className="text-gray-600 font-medium whitespace-nowrap">
                Trayecto: {detalle.porcentaje_trayecto.toFixed(0)}%
              </span>
              <div className="h-2.5 w-full rounded-full bg-sky-200/60 overflow-hidden">
                <div
                  className="h-full rounded-full bg-[#e54c2a] transition-all duration-500"
                  style={{ width: `${detalle.porcentaje_trayecto}%` }}
                />
              </div>
            </div>
          </div>
        )}

        {/* Tabs de Navegación */}
        <div className="flex border-b border-gray-200 bg-gray-50/50 px-6 text-sm font-medium text-gray-600">
          <button
            type="button"
            onClick={() => setActiveTab("general")}
            className={`border-b-2 py-3 px-4 transition ${
              activeTab === "general"
                ? "border-[#e54c2a] text-[#e54c2a] font-semibold"
                : "border-transparent hover:text-gray-900"
            }`}
          >
            General & Buque
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("ruta")}
            className={`border-b-2 py-3 px-4 transition ${
              activeTab === "ruta"
                ? "border-[#e54c2a] text-[#e54c2a] font-semibold"
                : "border-transparent hover:text-gray-900"
            }`}
          >
            Ruta Marítima
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("contenedores")}
            className={`border-b-2 py-3 px-4 transition flex items-center gap-1.5 ${
              activeTab === "contenedores"
                ? "border-[#e54c2a] text-[#e54c2a] font-semibold"
                : "border-transparent hover:text-gray-900"
            }`}
          >
            <span>Contenedores</span>
            {detalle?.contenedores && (
              <span className="rounded-full bg-gray-200 px-1.5 py-0.2 text-xs font-bold text-gray-700">
                {detalle.contenedores.length}
              </span>
            )}
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("tripulacion")}
            className={`border-b-2 py-3 px-4 transition flex items-center gap-1.5 ${
              activeTab === "tripulacion"
                ? "border-[#e54c2a] text-[#e54c2a] font-semibold"
                : "border-transparent hover:text-gray-900"
            }`}
          >
            <span>Tripulación</span>
            {detalle?.tripulacion && (
              <span className="rounded-full bg-gray-200 px-1.5 py-0.2 text-xs font-bold text-gray-700">
                {detalle.tripulacion.length}
              </span>
            )}
          </button>
          <button
            type="button"
            onClick={() => setActiveTab("incidencias")}
            className={`border-b-2 py-3 px-4 transition flex items-center gap-1.5 ${
              activeTab === "incidencias"
                ? "border-[#e54c2a] text-[#e54c2a] font-semibold"
                : "border-transparent hover:text-gray-900"
            }`}
          >
            <span>Incidencias & Auditoría</span>
            {detalle && (detalle.incidencias?.length > 0 || detalle.correccion) && (
              <span className="rounded-full bg-amber-200 px-1.5 py-0.2 text-xs font-bold text-amber-800">
                {detalle.incidencias?.length || 1}
              </span>
            )}
          </button>
        </div>

        {/* Content Body */}
        <div className="flex-1 overflow-y-auto p-6">
          {loading && (
            <div className="flex flex-col items-center justify-center py-12">
              <div className="h-10 w-10 animate-spin rounded-full border-4 border-[#e54c2a] border-t-transparent" />
              <p className="mt-3 text-sm text-gray-500">Cargando detalles de la operación...</p>
            </div>
          )}

          {error && !loading && (
            <div className="rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">
              <p className="font-semibold">Error al cargar:</p>
              <p>{error}</p>
              <button
                type="button"
                onClick={() => idOperacion && cargarDetalle(idOperacion)}
                className="mt-2 font-semibold text-red-800 underline hover:text-red-900"
              >
                Reintentar
              </button>
            </div>
          )}

          {detalle && !loading && (
            <>
              {/* Tab 1: General & Buque */}
              {activeTab === "general" && (
                <div className="space-y-6">
                  {/* Cronograma */}
                  <div>
                    <h3 className="text-sm font-bold uppercase tracking-wider text-gray-500 mb-3">
                      Cronograma y Estado
                    </h3>
                    <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                      <div className="rounded-xl border border-gray-100 bg-gray-50/70 p-3.5">
                        <span className="text-xs text-gray-500">Fecha de Inicio</span>
                        <p className="mt-1 font-semibold text-gray-900">
                          {detalle.fecha_inicio ? new Date(detalle.fecha_inicio).toLocaleString("es-ES") : "-"}
                        </p>
                      </div>
                      <div className="rounded-xl border border-gray-100 bg-gray-50/70 p-3.5">
                        <span className="text-xs text-gray-500">Fecha de Fin</span>
                        <p className="mt-1 font-semibold text-gray-900">
                          {detalle.fecha_fin
                            ? new Date(detalle.fecha_fin).toLocaleString("es-ES")
                            : "En curso / Sin finalizar"}
                        </p>
                      </div>
                      <div className="rounded-xl border border-gray-100 bg-gray-50/70 p-3.5">
                        <span className="text-xs text-gray-500">Estado Actual</span>
                        <div className="mt-1 flex items-center gap-2">
                          <span
                            className={`inline-flex rounded-full border px-2.5 py-0.5 text-xs font-semibold ${getEstadoBadgeClass(
                              detalle.estado
                            )}`}
                          >
                            {detalle.estado}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>

                  {/* Buque */}
                  <div>
                    <h3 className="text-sm font-bold uppercase tracking-wider text-gray-500 mb-3">
                      Información del Buque Asignado
                    </h3>
                    {detalle.buque ? (
                      <div className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm">
                        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 border-b border-gray-100 pb-3">
                          <div>
                            <h4 className="text-base font-bold text-gray-900">
                              {detalle.buque.nombre}
                            </h4>
                            <p className="text-xs text-gray-500 font-mono">
                              Matrícula: {detalle.buque.matricula}
                            </p>
                          </div>
                          {detalle.buque.estado && (
                            <span className="inline-flex rounded-full bg-emerald-100 px-3 py-1 text-xs font-medium text-emerald-800 self-start">
                              {detalle.buque.estado}
                            </span>
                          )}
                        </div>
                        <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mt-3 text-xs">
                          <div>
                            <span className="text-gray-500">Capacidad (TEU):</span>
                            <p className="font-semibold text-gray-800 text-sm">
                              {detalle.buque.capacidad || "N/A"}
                            </p>
                          </div>
                          <div>
                            <span className="text-gray-500">Peso Bruto:</span>
                            <p className="font-semibold text-gray-800 text-sm">
                              {detalle.buque.peso ? `${detalle.buque.peso.toLocaleString()} kg` : "N/A"}
                            </p>
                          </div>
                          <div className="col-span-2">
                            <span className="text-gray-500">Ubicación Actual:</span>
                            <p className="font-semibold text-gray-800 text-sm">
                              {detalle.buque.ubicacion_actual || "En navegación programada"}
                            </p>
                          </div>
                        </div>
                      </div>
                    ) : (
                      <p className="text-sm text-gray-500">No hay información del buque disponible.</p>
                    )}
                  </div>
                </div>
              )}

              {/* Tab 2: Ruta Marítima */}
              {activeTab === "ruta" && (
                <div className="space-y-6">
                  {detalle.ruta ? (
                    <div>
                      <div className="rounded-xl border border-gray-200 bg-white p-5 shadow-sm">
                        <div className="flex items-center justify-between border-b border-gray-100 pb-3 mb-4">
                          <div>
                            <span className="text-xs font-semibold text-[#e54c2a]">CÓDIGO DE RUTA</span>
                            <p className="text-lg font-bold text-gray-900">{detalle.ruta.codigo}</p>
                          </div>
                          <div className="text-right">
                            <span className="text-xs text-gray-500">Distancia Náutica</span>
                            <p className="text-base font-bold text-gray-900">
                              {detalle.ruta.distancia} MN
                            </p>
                          </div>
                        </div>

                        {/* Origen vs Destino visual */}
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 relative">
                          {/* Origen */}
                          <div className="rounded-xl border border-sky-100 bg-sky-50/50 p-4">
                            <div className="flex items-center gap-2 mb-2">
                              <span className="flex h-6 w-6 items-center justify-center rounded-full bg-sky-500 text-xs font-bold text-white">
                                A
                              </span>
                              <span className="text-xs font-bold uppercase tracking-wider text-sky-800">
                                Puerto de Origen
                              </span>
                            </div>
                            <h4 className="text-base font-bold text-gray-900">
                              {detalle.ruta.origen?.puerto || "Puerto de Origen"}
                            </h4>
                            <p className="text-xs text-gray-600 mt-0.5">
                              País: {detalle.ruta.origen?.pais || "N/A"}
                            </p>
                            {detalle.ruta.origen?.muelle && (
                              <p className="text-xs text-gray-500 mt-2 bg-white/80 rounded p-1.5 inline-block">
                                ⚓ Muelle: {detalle.ruta.origen.muelle}
                              </p>
                            )}
                          </div>

                          {/* Destino */}
                          <div className="rounded-xl border border-emerald-100 bg-emerald-50/50 p-4">
                            <div className="flex items-center gap-2 mb-2">
                              <span className="flex h-6 w-6 items-center justify-center rounded-full bg-emerald-500 text-xs font-bold text-white">
                                B
                              </span>
                              <span className="text-xs font-bold uppercase tracking-wider text-emerald-800">
                                Puerto de Destino
                              </span>
                            </div>
                            <h4 className="text-base font-bold text-gray-900">
                              {detalle.ruta.destino?.puerto || "Puerto de Destino"}
                            </h4>
                            <p className="text-xs text-gray-600 mt-0.5">
                              País: {detalle.ruta.destino?.pais || "N/A"}
                            </p>
                            {detalle.ruta.destino?.muelle && (
                              <p className="text-xs text-gray-500 mt-2 bg-white/80 rounded p-1.5 inline-block">
                                ⚓ Muelle: {detalle.ruta.destino.muelle}
                              </p>
                            )}
                          </div>
                        </div>
                      </div>
                    </div>
                  ) : (
                    <div className="rounded-xl border border-dashed border-gray-300 p-8 text-center text-gray-500">
                      <span className="text-3xl">🗺️</span>
                      <p className="mt-2 font-medium">No se asoció una ruta marítima detallada a esta operación.</p>
                    </div>
                  )}
                </div>
              )}

              {/* Tab 3: Contenedores */}
              {activeTab === "contenedores" && (
                <div>
                  <div className="flex items-center justify-between mb-4">
                    <h3 className="text-sm font-bold uppercase tracking-wider text-gray-500">
                      Contenedores en Operación ({detalle.contenedores.length})
                    </h3>
                  </div>

                  {detalle.contenedores.length > 0 ? (
                    <div className="overflow-hidden rounded-xl border border-gray-200">
                      <table className="w-full text-left text-xs">
                        <thead className="bg-gray-50 font-semibold text-gray-600 uppercase border-b border-gray-200">
                          <tr>
                            <th className="px-4 py-3">Código</th>
                            <th className="px-4 py-3">Tipo</th>
                            <th className="px-4 py-3">Estado</th>
                            <th className="px-4 py-3">Peso</th>
                            <th className="px-4 py-3">Capacidad</th>
                            <th className="px-4 py-3">Dimensiones</th>
                          </tr>
                        </thead>
                        <tbody className="divide-y divide-gray-100 bg-white">
                          {detalle.contenedores.map((c, index) => (
                            <tr key={c.id_contenedor || index} className="hover:bg-gray-50">
                              <td className="px-4 py-2.5 font-mono font-bold text-gray-900">
                                {c.codigo}
                              </td>
                              <td className="px-4 py-2.5 text-gray-700">{c.tipo || "Estándar"}</td>
                              <td className="px-4 py-2.5">
                                <span className="inline-flex rounded-full bg-sky-50 px-2 py-0.5 text-xs text-sky-700 border border-sky-200">
                                  {c.estado || "En Tránsito"}
                                </span>
                              </td>
                              <td className="px-4 py-2.5 text-gray-600">
                                {c.peso ? `${c.peso.toLocaleString()} kg` : "-"}
                              </td>
                              <td className="px-4 py-2.5 text-gray-600">
                                {c.capacidad ? `${c.capacidad} m³` : "-"}
                              </td>
                              <td className="px-4 py-2.5 text-gray-600">{c.dimensiones || "-"}</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  ) : (
                    <div className="rounded-xl border border-dashed border-gray-300 p-8 text-center text-gray-500">
                      <span className="text-3xl">📦</span>
                      <p className="mt-2 font-medium">No hay contenedores registrados en esta operación.</p>
                    </div>
                  )}
                </div>
              )}

              {/* Tab 4: Tripulación */}
              {activeTab === "tripulacion" && (
                <div>
                  <div className="flex items-center justify-between mb-4">
                    <h3 className="text-sm font-bold uppercase tracking-wider text-gray-500">
                      Tripulación Asignada ({detalle.tripulacion.length})
                    </h3>
                  </div>

                  {detalle.tripulacion.length > 0 ? (
                    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
                      {detalle.tripulacion.map((t, index) => (
                        <div
                          key={t.id_empleado || index}
                          className="rounded-xl border border-gray-200 bg-white p-3.5 shadow-sm flex items-start gap-3"
                        >
                          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-orange-100 font-bold text-[#e54c2a]">
                            {t.nombre.charAt(0)}
                            {t.apellido?.charAt(0) || ""}
                          </div>
                          <div className="min-w-0 flex-1">
                            <h4 className="font-semibold text-sm text-gray-900 truncate">
                              {t.nombre} {t.apellido}
                            </h4>
                            <p className="text-xs text-gray-500 font-mono">
                              Código: {t.codigo || "EMP"}
                            </p>
                            <div className="mt-1 flex items-center gap-2 text-xs text-gray-600">
                              <span>🌍 {t.nacionalidad}</span>
                              {t.dni && <span>• DNI: {t.dni}</span>}
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <div className="rounded-xl border border-dashed border-gray-300 p-8 text-center text-gray-500">
                      <span className="text-3xl">👨‍✈️</span>
                      <p className="mt-2 font-medium">No hay tripulantes asignados formalmente a esta operación.</p>
                    </div>
                  )}
                </div>
              )}

              {/* Tab 5: Incidencias & Auditoría */}
              {activeTab === "incidencias" && (
                <div className="space-y-6">
                  {/* Incidencias */}
                  <div>
                    <h3 className="text-sm font-bold uppercase tracking-wider text-gray-500 mb-3">
                      Incidencias Registradas ({detalle.incidencias.length})
                    </h3>
                    {detalle.incidencias.length > 0 ? (
                      <div className="space-y-2">
                        {detalle.incidencias.map((inc) => (
                          <div
                            key={inc.id_incidencia}
                            className={`rounded-xl border p-4 shadow-sm ${
                              (inc.grado_severidad ?? 0) >= 4
                                ? "border-red-200 bg-red-50/50"
                                : "border-amber-200 bg-amber-50/40"
                            }`}
                          >
                            <div className="flex items-start justify-between gap-4">
                              <div>
                                <div className="flex items-center gap-2">
                                  <span className="font-bold text-sm text-gray-900">
                                    {inc.codigo}
                                  </span>
                                  <span className="rounded bg-white px-2 py-0.5 text-xs font-semibold text-gray-700 border">
                                    Severidad: {inc.grado_severidad ?? 0}/5
                                  </span>
                                  <span className="text-xs text-gray-500">
                                    {inc.tipo}
                                  </span>
                                </div>
                                <p className="mt-1 text-sm text-gray-700">
                                  {inc.descripcion}
                                </p>
                              </div>
                              <span className="text-xs text-gray-500 whitespace-nowrap">
                                {inc.fecha_hora ? new Date(inc.fecha_hora).toLocaleDateString("es-ES") : "-"}
                              </span>
                            </div>
                          </div>
                        ))}
                      </div>
                    ) : (
                      <div className="rounded-xl border border-dashed border-gray-200 p-4 text-center text-xs text-gray-500">
                        No se han reportado incidencias para esta operación marítima.
                      </div>
                    )}
                  </div>

                  {/* Auditoría / Conciliación */}
                  <div>
                    <h3 className="text-sm font-bold uppercase tracking-wider text-gray-500 mb-3">
                      Registro de Conciliación Nocturna
                    </h3>
                    {detalle.correccion ? (
                      <div className="rounded-xl border border-amber-200 bg-amber-50/60 p-4">
                        <div className="flex items-center gap-2 text-amber-900 font-semibold text-sm mb-1">
                          <span>✓</span>
                          <span>Corrección Automática Aplicada por Batch</span>
                        </div>
                        <p className="text-xs text-amber-800">
                          Tipo: <strong className="uppercase">{detalle.correccion.tipo_correccion}</strong>
                        </p>
                        {detalle.correccion.descripcion_correccion && (
                          <p className="text-xs text-gray-700 mt-1">
                            {detalle.correccion.descripcion_correccion}
                          </p>
                        )}
                        <p className="text-[11px] text-gray-500 mt-2">
                          Fecha de conciliación:{" "}
                          {detalle.correccion.fecha_correccion
                            ? new Date(detalle.correccion.fecha_correccion).toLocaleString("es-ES")
                            : "Reciente"}
                        </p>
                      </div>
                    ) : (
                      <p className="text-xs text-gray-500">
                        Esta operación no ha requerido correcciones ni conciliaciones automáticas hasta la fecha.
                      </p>
                    )}
                  </div>
                </div>
              )}
            </>
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-between border-t border-gray-200 bg-gray-50 px-6 py-4">
          <button
            type="button"
            onClick={() => {
              if (detalle && idOperacion) {
                onAbrirCambiarEstado(idOperacion, detalle.codigo_operacion, detalle.estado);
              }
            }}
            disabled={!detalle}
            className="inline-flex items-center gap-2 rounded-lg bg-sky-600 px-4 py-2 text-sm font-semibold text-white shadow-sm hover:bg-sky-700 transition disabled:opacity-50"
          >
            <span>🔄</span>
            <span>Cambiar Estado</span>
          </button>
          <button
            type="button"
            onClick={onClose}
            className="rounded-lg border border-gray-300 bg-white px-5 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-100 transition"
          >
            Cerrar
          </button>
        </div>
      </div>
    </div>
  );
}
