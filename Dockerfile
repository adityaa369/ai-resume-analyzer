FROM python:3.11-slim

WORKDIR /app

# System deps (VERY IMPORTANT for opencv, whisper, pdf, audio/video)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 7860

CMD ["gunicorn", "main:app", "--bind", "0.0.0.0:7860", "--workers", "1", "--timeout", "300"]
