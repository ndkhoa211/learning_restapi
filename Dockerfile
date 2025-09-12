FROM python:3.12-slim

EXPOSE 5000

WORKDIR /app

# Install curl so we can fetch uv
RUN apt-get update && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv (Rust-based package manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# make sure uv is on PATH (cover both locations)
ENV PATH="/root/.local/bin:/root/.cargo/bin:${PATH}"

COPY pyproject.toml uv.lock ./

RUN uv sync --frozen

COPY . .

CMD [ "uv", "run", "flask", "run", "--host", "0.0.0.0" ]