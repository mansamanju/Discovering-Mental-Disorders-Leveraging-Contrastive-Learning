# Run the FastAPI backend (must be run from project root).
# Frontend runs with: cd frontend; npm run dev
$projectRoot = $PSScriptRoot
Set-Location $projectRoot
& "$projectRoot\backend\.venv\Scripts\Activate.ps1"
uvicorn backend.main:app --reload --port 8000
