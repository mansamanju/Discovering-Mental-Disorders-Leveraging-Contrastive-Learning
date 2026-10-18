# Start backend + frontend dev servers, then open the site in your default browser.
# Run from project root:  .\start.ps1
# Or double-click:        start.bat

$ErrorActionPreference = "Stop"
$projectRoot = $PSScriptRoot
Set-Location $projectRoot

$venvActivate = Join-Path $projectRoot "backend\.venv\Scripts\Activate.ps1"
if (-not (Test-Path $venvActivate)) {
    Write-Host "Missing venv at backend\.venv — create it and install requirements first." -ForegroundColor Red
    exit 1
}

$backendCmd = @"
Set-Location '$projectRoot'
& '$venvActivate'
uvicorn backend.main:app --reload --host 127.0.0.1 --port 8000
"@

$frontendCmd = @"
Set-Location '$projectRoot\frontend'
npm run dev
"@

Start-Process powershell -ArgumentList @("-NoExit", "-Command", $backendCmd)
Start-Sleep -Seconds 1
Start-Process powershell -ArgumentList @("-NoExit", "-Command", $frontendCmd)

# Give Vite time to bind before opening the browser
Start-Sleep -Seconds 4
Start-Process "http://localhost:5173"

Write-Host "Opened http://localhost:5173 — backend :8000, frontend :5173 (two extra windows)." -ForegroundColor Green
