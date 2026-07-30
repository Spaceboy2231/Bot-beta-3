FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for Docker layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all bot files
COPY fix.py .
COPY sites.txt .
COPY proxy.txt .

# Create data directory for SQLite and runtime files
RUN mkdir -p /app/data

# Environment variable defaults (overridden by Koyeb env vars)
ENV PYTHONUNBUFFERED=1
ENV TZ=Asia/Dhaka

# Run the bot
CMD ["python", "fix.py"]
