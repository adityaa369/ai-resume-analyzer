FROM python:3.10

WORKDIR /app

RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1 \
    libglib2.0-0 \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip setuptools wheel

# CRITICAL FIX for HF + Whisper
RUN pip install --no-build-isolation openai-whisper==20231117

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 7860

CMD ["gunicorn", "-b", "0.0.0.0:7860", "main:app", "--timeout", "300"]
