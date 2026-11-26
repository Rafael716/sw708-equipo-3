/**
 * Escenario de carga — E2 Fiabilidad (última posición GPS).
 * Hipótesis: semana-12/docs/mediciones/hipotesis.md
 *
 * Carga: 50 VU × 5 min (hipótesis).
 * Umbral: p95(http_req_duration) < 300 ms.
 *
 * Correr (API en 3001):
 *   k6 run -e BASE=http://localhost:3001 carga/escenario.js
 *   k6 run -e BASE=http://localhost:3001 -e CONTENEDOR_ID=<uuid> carga/escenario.js
 *
 * Docker (sin instalar k6):
 *   docker run --rm -i -e BASE=http://host.docker.internal:3001 grafana/k6 run - < carga/escenario.js
 */
import http from "k6/http";
import { check, sleep } from "k6";

const BASE = __ENV.BASE || "http://localhost:3001";

export const options = {
  // Carga que dice la hipótesis (escenario semana 2 / E2)
  vus: 50,
  duration: "5m",
  thresholds: {
    // Umbral del escenario: p95 por debajo de 300 ms
    http_req_duration: ["p(95)<300"],
    checks: ["rate>0.99"],
  },
};

/**
 * Resuelve un id_contenedor real: CONTENEDOR_ID o el primero de
 * GET /monitoreo/gps/contenedores (evita hardcodear UUIDs del seed).
 */
export function setup() {
  if (__ENV.CONTENEDOR_ID) {
    return { contenedorId: __ENV.CONTENEDOR_ID };
  }

  const res = http.get(`${BASE}/monitoreo/gps/contenedores`);
  if (res.status !== 200) {
    throw new Error(
      `setup: no pude listar contenedores (HTTP ${res.status}). ` +
        `¿API arriba en ${BASE}? O pase -e CONTENEDOR_ID=<uuid>.`,
    );
  }

  let rows;
  try {
    rows = res.json();
  } catch (_) {
    throw new Error("setup: respuesta de /monitoreo/gps/contenedores no es JSON");
  }

  const id =
    Array.isArray(rows) && rows.length > 0 ? rows[0].id_contenedor : null;
  if (!id) {
    throw new Error(
      "setup: no hay posiciones/contenedores en BD. Poblar datos o pase CONTENEDOR_ID.",
    );
  }

  return { contenedorId: id };
}

export default function (data) {
  const url = `${BASE}/monitoreo/gps/contenedores/${data.contenedorId}/ultima`;
  const r = http.get(url);
  check(r, {
    "responde 200": (x) => x.status === 200,
  });
  // Con sleep(1), 50 VU ⇒ ≤ 50 req/s; no es la capacidad máxima del sistema.
  sleep(1);
}
