$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Instale Docker Desktop y vuelva a ejecutar este archivo."
}
docker compose version
if ($LASTEXITCODE -ne 0) { throw "Docker Compose no esta disponible." }
docker info *> $null
if ($LASTEXITCODE -ne 0) { throw "Abra Docker Desktop y espere a que el motor este listo." }
if (-not (Test-Path .env)) {
    $clave = [Guid]::NewGuid().ToString("N") + [Guid]::NewGuid().ToString("N")
    "DB_PASSWORD=$clave`nPUERTO_WEB=8080" | Set-Content .env -Encoding ascii
}
docker compose up -d --build --wait --wait-timeout 180
if ($LASTEXITCODE -ne 0) { throw "No se pudo iniciar. Consulte docker compose logs --tail=80." }
Write-Host "TiendaLocal esta lista. Abra http://localhost:8080 (o el PUERTO_WEB de su .env)."
