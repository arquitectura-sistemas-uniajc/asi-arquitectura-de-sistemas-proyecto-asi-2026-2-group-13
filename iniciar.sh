#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "$0")"
if ! command -v docker >/dev/null || ! docker compose version >/dev/null 2>&1; then
  echo "Instale Docker Desktop con Docker Compose y vuelva a ejecutar este archivo."
  exit 1
fi
if ! docker info >/dev/null 2>&1; then
  echo "Abra Docker Desktop y espere a que el motor esté listo."
  exit 1
fi
if [ ! -f .env ]; then
  clave=$(od -An -N24 -tx1 /dev/urandom | tr -d ' \n')
  (umask 077; printf 'DB_PASSWORD=%s\nPUERTO_WEB=8080\n' "$clave" > .env)
fi
docker compose up -d --build --wait --wait-timeout 180
echo "TiendaLocal está lista. Abra http://localhost:8080 (o el PUERTO_WEB de su .env)."
