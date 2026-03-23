FROM python:3.9-slim

WORKDIR /app

# Install system deps for h5py/numpy
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc g++ libhdf5-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# HuggingFace Spaces expects port 7860
EXPOSE 7860

CMD ["uvicorn", "backend:app", "--host", "0.0.0.0", "--port", "7860"]
