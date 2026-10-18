@echo off
setlocal

REM Start FastAPI backend on http://127.0.0.1:8000
cd /d "%~dp0"

if not exist "backend\.venv\Scripts\python.exe" (
  echo [Backend] Creating virtual environment...
  python -m venv "backend\.venv"
)

echo [Backend] Activating venv...
call "backend\.venv\Scripts\activate.bat"

echo [Backend] Installing requirements...
pip install -r "backend\requirements.txt"

echo [Backend] Starting server...
uvicorn backend.main:app --reload --port 8000

endlocal

