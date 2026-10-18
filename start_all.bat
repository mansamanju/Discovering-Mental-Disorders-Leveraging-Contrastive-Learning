@echo off
setlocal

REM Starts backend and frontend in separate command windows.
cd /d "%~dp0"

echo Starting backend and frontend...
start "Backend (FastAPI)" cmd /k "%~dp0start_backend.bat"
start "Frontend (React/Vite)" cmd /k "%~dp0start_frontend.bat"

echo Done. Keep both windows open.
endlocal

