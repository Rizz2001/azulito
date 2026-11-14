# Script de arranque rápido para servidor de previsualización en vivo (puerto 8080)
param(
    [int]$Port = 8080
)

# Inyectar ruta absoluta de Flutter en caso de ejecutarse en una shell sin PATH recargado
if ($env:Path -notlike '*C:\flutter\bin*') {
    $env:Path = "C:\flutter\bin;$env:Path"
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   AZULITO POS - Servidor de Live Browser Preview ($Port)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

if (Get-Command flutter -ErrorAction SilentlyContinue) {
    Write-Host "[+] Flutter detectado: $(flutter --version | Select-Object -First 1)" -ForegroundColor Green
    Write-Host "[+] Iniciando servidor web en http://localhost:$Port..." -ForegroundColor Cyan
    flutter run -d web-server --web-port $Port
} else {
    Write-Host "[!] 'flutter' no encontrado en C:\flutter\bin ni en PATH." -ForegroundColor Red
}
