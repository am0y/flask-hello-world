# Use Python runtime
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV FLASK_APP=api/index.py
ENV FLASK_ENV=production
ENV PATH="/app/.local/bin:${PATH}"

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc \
    && apt-get clean

# Copy requirements file
COPY requirements.txt requirements.txt

# Install Python dependencies
RUN pip install --user --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Make sure gunicorn is executable
RUN chmod +x /app/.local/bin/gunicorn

# Command to run the application
CMD ["python", "-m", "gunicorn", "--bind", "0.0.0.0:$PORT", "api.index:app"]
