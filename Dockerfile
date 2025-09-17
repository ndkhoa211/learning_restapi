# Use Python 3.12 slim base image
FROM python:3.12-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Set environment variables
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy dependency files first (for better caching)
COPY pyproject.toml uv.lock* ./

# Install dependencies
RUN uv sync --frozen --no-cache --no-dev

# Copy application code
COPY . .

# Set Flask environment variables
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# Run the Flask application
CMD ["uv", "run", "gunicorn", "--bind", "0.0.0.0:80", "app:create_app()"]