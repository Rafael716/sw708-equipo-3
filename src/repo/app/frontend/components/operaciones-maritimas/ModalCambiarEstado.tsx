"use client";

import React, { useState, useEffect } from "react";
import { conciliacionAPI, type EstadoOperacionItem } from "@/lib/api/conciliacion";

interface ModalCambiarEstadoProps {
  idOperacion: string | null;
  codigoOperacion: string | null;
  estadoActual: string | null;
  isOpen: boolean;
  onClose: () => void;
  onEstadoActualizado: () => void;
}

const DESCRIPCIONES_ESTADO: Record<string, { desc: string; icon: string; color: string }> = {
  Programada: {
    desc: "Operación planificada que aún no ha iniciado zarpe.",
    icon: "📅",
    color: "border-indigo-200 bg-indigo-50/50 text-indigo-900",
  },
  "En Curso": {
    desc: "Operación en ejecución activa y navegación por mar.",
    icon: "🚢",
    color: "border-sky-200 bg-sky-50/50 text-sky-900",
  },
  "En Espera": {
    desc: "Operación pausada temporalmente por espera de muelle o clima.",
    icon: "⏳",
    color: "border-amber-200 bg-amber-50/50 text-amber-900",
  },
  Completada: {
    desc: "Operación culminada con éxito. Se registrará la fecha y hora de fin.",
    icon: "✅",
    color: "border-emerald-200 bg-emerald-50/50 text-emerald-900",
  },
  Cancelada: {
    desc: "Operación anulada o interrumpida definitivamente.",
    icon: "⛔",
    color: "border-red-200 bg-red-50/50 text-red-900",
  },
};

export function ModalCambiarEstado({
  idOperacion,
  codigoOperacion,
  estadoActual,
  isOpen,
  onClose,
  onEstadoActualizado,
}: ModalCambiarEstadoProps) {
  const [estados, setEstados] = useState<EstadoOperacionItem[]>([]);
  const [selectedEstadoId, setSelectedEstadoId] = useState<string>("");
  const [loadingEstados, setLoadingEstados] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [successMsg, setSuccessMsg] = useState<string | null>(null);

  useEffect(() => {
    if (isOpen) {
      cargarEstados();
      setSuccessMsg(null);
      setError(null);
    }
  }, [isOpen]);

  const cargarEstados = async () => {
    try {
      setLoadingEstados(true);
      const lista = await conciliacionAPI.getEstados();
      setEstados(lista);

      // Preseleccionar el estado actual si coincide
      if (estadoActual) {
        const matching = lista.find(
          (e) => e.nombre.toLowerCase() === estadoActual.toLowerCase()
        );
        if (matching) {
          setSelectedEstadoId(matching.id_estado_operacion);
        } else if (lista.length > 0) {
          setSelectedEstadoId(lista[0].id_estado_operacion);
        }
      }
    } catch (err) {
      console.error("Error al cargar estados:", err);
      // Fallback a lista estática
      const fallbackList: EstadoOperacionItem[] = [
        { id_estado_operacion: "892d1064-7a42-4560-aff5-0e9853c9a521", nombre: "Programada" },
        { id_estado_operacion: "d4e68441-e00c-4fe5-a0c9-fe6bbb2e70a4", nombre: "En Curso" },
        { id_estado_operacion: "a20ef0aa-bed9-4826-b331-5e001106271a", nombre: "En Espera" },
        { id_estado_operacion: "54dd56b9-659a-41c9-8e71-19677a6f00d6", nombre: "Completada" },
        { id_estado_operacion: "64ec10c1-5030-4e55-a14a-7038843228c0", nombre: "Cancelada" },
      ];
      setEstados(fallbackList);
      if (estadoActual) {
        const matching = fallbackList.find(
          (e) => e.nombre.toLowerCase() === estadoActual.toLowerCase()
        );
        if (matching) setSelectedEstadoId(matching.id_estado_operacion);
      }
    } finally {
      setLoadingEstados(false);
    }
  };

  if (!isOpen || !idOperacion) return null;

  const selectedEstadoObj = estados.find((e) => e.id_estado_operacion === selectedEstadoId);
  const esMismoEstado =
    selectedEstadoObj &&
    estadoActual &&
    selectedEstadoObj.nombre.toLowerCase() === estadoActual.toLowerCase();

  const handleGuardar = async () => {
    if (!selectedEstadoId) return;

    try {
      setSaving(true);
      setError(null);
      await conciliacionAPI.actualizarEstado(
        idOperacion,
        selectedEstadoId,
        selectedEstadoObj?.nombre
      );
      setSuccessMsg(
        `Estado actualizado exitosamente a "${selectedEstadoObj?.nombre}".`
      );
      setTimeout(() => {
        onEstadoActualizado();
        onClose();
      }, 1000);
    } catch (err: any) {
      console.error("Error al actualizar estado:", err);
      setError(err?.message || "No se pudo actualizar el estado de la operación.");
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center overflow-y-auto bg-black/60 p-4 backdrop-blur-sm animate-in fade-in duration-200">
      <div
        className="relative w-full max-w-lg rounded-2xl bg-white shadow-2xl overflow-hidden flex flex-col"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="flex items-start justify-between border-b border-gray-100 bg-gradient-to-r from-gray-50 to-white px-6 py-5">
          <div className="flex items-center gap-3">
            <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-sky-100 text-xl text-sky-600">
              🔄
            </span>
            <div>
              <h2 className="text-lg font-bold text-gray-900">
                Cambiar Estado de Operación
              </h2>
              <p className="text-xs text-gray-500 font-mono">
                {codigoOperacion || idOperacion}
              </p>
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

        {/* Body */}
        <div className="p-6 space-y-4">
          {/* Estado actual */}
          <div className="flex items-center justify-between rounded-xl bg-gray-50 p-3.5 border border-gray-100">
            <span className="text-xs font-medium text-gray-500">Estado Actual:</span>
            <span className="inline-flex rounded-full bg-gray-200 px-3 py-1 text-xs font-bold text-gray-800">
              {estadoActual || "No definido"}
            </span>
          </div>

          {/* Selector de estados */}
          <div>
            <label className="block text-xs font-bold uppercase tracking-wider text-gray-600 mb-2">
              Seleccionar Nuevo Estado
            </label>

            {loadingEstados ? (
              <div className="flex items-center justify-center py-6 text-sm text-gray-500">
                <div className="h-5 w-5 animate-spin rounded-full border-2 border-[#e54c2a] border-t-transparent mr-2" />
                Cargando estados disponibles...
              </div>
            ) : (
              <div className="space-y-2">
                {estados.map((est) => {
                  const isSelected = selectedEstadoId === est.id_estado_operacion;
                  const info = DESCRIPCIONES_ESTADO[est.nombre] || {
                    desc: "Estado de la operación.",
                    icon: "📍",
                    color: "border-gray-200 bg-gray-50 text-gray-800",
                  };

                  return (
                    <div
                      key={est.id_estado_operacion}
                      onClick={() => setSelectedEstadoId(est.id_estado_operacion)}
                      className={`cursor-pointer rounded-xl border-2 p-3.5 transition flex items-start gap-3 ${
                        isSelected
                          ? "border-[#e54c2a] bg-orange-50/40 shadow-sm"
                          : "border-gray-200 hover:border-gray-300 hover:bg-gray-50/60"
                      }`}
                    >
                      <input
                        type="radio"
                        name="estadoOperacion"
                        checked={isSelected}
                        onChange={() => setSelectedEstadoId(est.id_estado_operacion)}
                        className="mt-1 h-4 w-4 text-[#e54c2a] focus:ring-[#e54c2a]"
                      />
                      <div className="flex-1">
                        <div className="flex items-center gap-2">
                          <span>{info.icon}</span>
                          <span className="font-bold text-sm text-gray-900">{est.nombre}</span>
                          {est.nombre.toLowerCase() === estadoActual?.toLowerCase() && (
                            <span className="text-[10px] bg-gray-100 text-gray-500 px-2 py-0.5 rounded font-semibold">
                              (Actual)
                            </span>
                          )}
                        </div>
                        <p className="text-xs text-gray-600 mt-1">{info.desc}</p>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </div>

          {/* Mensajes de éxito o error */}
          {error && (
            <div className="rounded-xl border border-red-200 bg-red-50 p-3 text-xs text-red-700">
              {error}
            </div>
          )}

          {successMsg && (
            <div className="rounded-xl border border-emerald-200 bg-emerald-50 p-3 text-xs text-emerald-800 flex items-center gap-2">
              <span>✅</span>
              <span>{successMsg}</span>
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 border-t border-gray-100 bg-gray-50 px-6 py-4">
          <button
            type="button"
            onClick={onClose}
            disabled={saving}
            className="rounded-lg border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm hover:bg-gray-100 transition disabled:opacity-50"
          >
            Cancelar
          </button>
          <button
            type="button"
            onClick={handleGuardar}
            disabled={saving || !selectedEstadoId || Boolean(esMismoEstado)}
            className="inline-flex items-center gap-2 rounded-lg bg-[#e54c2a] px-5 py-2 text-sm font-semibold text-white shadow-sm hover:bg-[#c94122] transition disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {saving ? (
              <>
                <div className="h-4 w-4 animate-spin rounded-full border-2 border-white border-t-transparent" />
                <span>Guardando...</span>
              </>
            ) : (
              <span>Confirmar Cambio</span>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}
