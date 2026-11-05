#!/usr/bin/env bash
# ============================================================
# Seed de la base de datos del Sistema Marítimo Integrado.
#
# 1. Genera los CSVs (Python + Faker) en codigo_python/datos_csv_consolidado
# 2. Los carga con psql \copy (cliente) usando el loader consolidado.sql
#    (seed.sh sustituye el placeholder :csvdir por la ruta real).
#
# Uso:
#   seed.sh [--ddl]
#
# --ddl  Ejecuta primero el DDL (scripts/ddl/tablas/consolidado.sql).
#        OJO: es DESTRUCTIVO (DROP SCHEMA ... CASCADE). Solo para recrear.
#
# Destino de la BD (por orden de prioridad):
#   - $DATABASE_URL            -> psql directo (local o remota)
#   - docker compose en app/   -> contenedor postgres (red app_default)
#     (override: SEED_DB_NETWORK, SEED_DB_HOST, POSTGRES_USER, ...)
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"   # carpeta scripts/
PY_DIR="$SCRIPT_DIR/codigo_python"
SQL_LOADER="$SCRIPT_DIR/scriptSQL/consolidado.sql"
SQL_DDL="$SCRIPT_DIR/../ddl/tablas/consolidado.sql"
RUN_SQL="$SCRIPT_DIR/scriptSQL/consolidado.run.sql"
trap 'rm -f "$RUN_SQL"' EXIT

# --- 1. Dependencias Python (Faker) en venv aislado -----------------
if [ ! -x "$PY_DIR/.venv/bin/python" ]; then
  echo "==> Creando venv de Python..."
  python3 -m venv "$PY_DIR/.venv"
fi
# shellcheck disable=SC1091
source "$PY_DIR/.venv/bin/activate"
pip install -q -r "$SCRIPT_DIR/requirements.txt"

# --- 2. Generar CSVs -------------------------------------------------
echo "==> Generando CSVs..."
cd "$PY_DIR"
python consolidado.py

# --- Destino de la BD ------------------------------------------------
if [ -n "${DATABASE_URL:-}" ]; then
  PSQL=(psql "$DATABASE_URL")
  CSVDIR_REAL="$PY_DIR/datos_csv_consolidado"
  RUN_SQL_TARGET="$RUN_SQL"
  DDL_TARGET="$SQL_DDL"
elif command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
  NET="${SEED_DB_NETWORK:-app_default}"
  DB_HOST="${SEED_DB_HOST:-db}"
  DB_USER="${POSTGRES_USER:-postgres}"
  DB_PASS="${POSTGRES_PASSWORD:-postgres}"
  DB_NAME="${POSTGRES_DB:-bd252}"
  echo "==> Destino: contenedor docker en red '$NET' ($DB_HOST/$DB_NAME)"
  PSQL=(docker run --rm --network "$NET" -e "PGPASSWORD=$DB_PASS" \
    -v "$SCRIPT_ROOT":/scripts:ro \
    postgres:16-alpine psql "postgresql://$DB_USER@$DB_HOST:5432/$DB_NAME")
  CSVDIR_REAL="/scripts/poblamiento_datos/codigo_python/datos_csv_consolidado"
  RUN_SQL_TARGET="/scripts/poblamiento_datos/scriptSQL/consolidado.run.sql"
  DDL_TARGET="/scripts/ddl/tablas/consolidado.sql"
else
  echo "ERROR: define DATABASE_URL o asegúrate de que docker compose esté disponible." >&2
  exit 1
fi

# --- 3. Resolver ruta real de los CSVs en el loader -------------------
sed "s#:csvdir#$CSVDIR_REAL#g" "$SQL_LOADER" > "$RUN_SQL"

# --- 4. (Opcional) DDL ------------------------------------------------
if [ "${1:-}" = "--ddl" ]; then
  echo "==> Ejecutando DDL (destructivo)..."
  "${PSQL[@]}" -f "$DDL_TARGET"
fi

# --- 5. Cargar datos ---------------------------------------------------
echo "==> Cargando datos desde $CSVDIR_REAL ..."
"${PSQL[@]}" -f "$RUN_SQL_TARGET"

echo "==> Seed completado."