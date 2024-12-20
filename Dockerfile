# Use Python runtime
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV FLASK_APP=api/index.py
ENV FLASK_ENV=production

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc \
    && apt-get clean

# Copy requirements file
COPY requirements.txt requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Command to run the application
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "api.index:app"]
