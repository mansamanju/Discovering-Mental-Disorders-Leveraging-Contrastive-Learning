Mental Health Disorder Detection using Contrastive Learning from Speech Audio
============================================================================

This project is a full-stack web application for a final year engineering project titled **“Mental Health Disorder Detection using Contrastive Learning from Speech Audio.”**

The system allows users to:
- Upload a short speech audio sample.
- Enter basic demographic information (name and age).
- Send the audio to a backend ML service for analysis.
- View detected emotion probabilities and model metrics (Accuracy, Macro Avg, Weighted Avg).
- Download a PDF report containing the results and suggested mental health tips.

The app is built with:
- **Frontend**: React.js + Vite + TailwindCSS
- **Backend**: FastAPI (Python)
- **Audio / ML**: `librosa` for feature extraction and a pluggable model loader so you can connect your trained contrastive learning model from Google Colab.

Project Structure
-----------------

```text
frontend/      # React + Tailwind single-page app (landing, upload, results, report)
backend/       # FastAPI backend (API, audio processing, model, PDF reports)
models/        # Saved ML model files (exported from Google Colab)
api/           # (Optional) Shared API description / schemas
components/    # (Optional) Shared design system or documentation
```

Backend Overview (FastAPI)
--------------------------

The backend exposes three main endpoints:

- `POST /upload-audio`  
  Accepts an audio file (`.wav`, `.mp3`) via multipart form-data, stores it temporarily on the server, and returns a `file_id` that the frontend can use for subsequent requests.

- `POST /predict`  
  Uses the stored audio (by `file_id`), runs audio feature extraction (via `librosa`), forwards features to the ML model, and returns:
  - Emotion probabilities (`Angry`, `Disgust`, `Fear`, `Happy`, `Neutral`, `Sad`)
  - Possible mental health indicators (`Depression`, `Anxiety`)
  - Model metrics: `accuracy`, `macro_avg`, `weighted_avg`

- `POST /generate-report`  
  Generates a downloadable PDF report that includes:
  - User details: name, age
  - Detected emotion and probabilities
  - Model metrics (Accuracy, Macro Avg, Weighted Avg)
  - Helpful suggestions for mental health self-care

The backend is structured into modules:

- `backend/main.py` – FastAPI app, routing, and CORS configuration
- `backend/schemas.py` – Pydantic models for request/response payloads
- `backend/audio_processing.py` – Audio loading and feature extraction helpers
- `backend/model.py` – Model loading and prediction logic (connect your Colab model here)
- `backend/reporting.py` – PDF report generation utilities

Frontend Overview (React + Tailwind)
------------------------------------

The frontend is a single-page React application styled with TailwindCSS. It uses a calm, mental-health themed palette (lavender, pastel blue, white, and soft gradients) and is designed to be:

- Modern and minimal
- Accessible and responsive
- Smoothly animated with soft shadows and rounded cards

Key UI sections:

- **Landing Page**  
  Shows the project title, a short description of the system, and a prominent **“Start Analysis”** button.

- **Audio Upload Page**  
  Drag-and-drop card for uploading `.wav` or `.mp3` audio files with a **“Submit Audio”** button.

- **User Information Form**  
  After a file is selected, the user enters:
  - Name
  - Age  
  The form includes basic validation and clear error states.

- **Results Dashboard**  
  Displays:
  - Detected dominant emotion
  - Emotion probability chart (bar chart)
  - Model metrics (Accuracy, Macro Avg, Weighted Avg)
  - Possible mental health indicators (Depression / Anxiety)
  - Button to download the PDF report

How to Run the Backend
----------------------

1. Create and activate a virtual environment (recommended).

   ```bash
   cd backend
   python -m venv .venv
   .venv\Scripts\activate   # On Windows
   # source .venv/bin/activate  # On macOS / Linux
   ```

2. Install backend dependencies.

   ```bash
   pip install -r requirements.txt
   ```

3. Start the FastAPI server with Uvicorn.

   ```bash
   uvicorn main:app --reload --port 8000
   ```

4. Once running, the API docs are available at:
   - Swagger UI: `http://localhost:8000/docs`
   - ReDoc: `http://localhost:8000/redoc`

How to Run the Frontend
-----------------------

1. Install frontend dependencies.

   ```bash
   cd frontend
   npm install
   ```

2. Start the Vite dev server.

   ```bash
   npm run dev
   ```

3. Open the printed `http://localhost:5173` URL in your browser.  
   Make sure the backend is also running on `http://localhost:8000` so that API calls succeed.

Connecting Your Trained Contrastive Learning Model
--------------------------------------------------

1. Export your trained model from Google Colab:
   - For example, save as a `.pt`, `.pth`, or `.pkl` file (depending on your framework).
   - Download the file to your local machine.

2. Place the exported file into the `models/` folder at the project root.

3. Open `backend/model.py` and update:
   - The `MODEL_PATH` constant so it points to your actual model file.
   - The `load_model()` function to load your model (e.g. using PyTorch, TensorFlow, or scikit-learn).
   - The `predict_emotions()` function to:
     - Accept an audio feature vector (e.g. mel-spectrogram, MFCC, or embedding).
     - Produce probabilities for each emotion class and any disorder indicators.

4. You can log intermediate outputs or print model summaries in `model.py` for debugging and documentation in your report.

Notes for Final Year Project Report
-----------------------------------

- **Architecture diagrams**: Show how the React frontend, FastAPI backend, audio processing layer, and ML model interact.
- **Dataset and training details**: Document the dataset used, preprocessing steps, model architecture, training procedure, and evaluation metrics.
- **Ethical considerations**: Emphasize that this tool is not a substitute for professional diagnosis and is meant as a decision-support or awareness tool.
- **Limitations**: Discuss dataset bias, generalization issues, background noise sensitivity, and privacy of voice data.

You can use the clean separation between `frontend/`, `backend/`, and `models/` to structure your report chapters (UI, API, ML model) and include code snippets directly.