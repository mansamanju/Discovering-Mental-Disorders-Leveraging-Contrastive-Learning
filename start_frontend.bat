@echo off
setlocal

REM Start React (Vite) frontend (prints the local URL)
cd /d "%~dp0\frontend"

echo [Frontend] Installing dependencies...
call npm install

echo [Frontend] Starting dev server...
call npm run dev

endlocal

