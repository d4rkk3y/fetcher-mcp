# Build stage
FROM --platform=$BUILDPLATFORM node:22-slim AS builder

RUN useradd -ms /bin/bash mcp

WORKDIR /app

# Copy dependency files first to leverage caching
COPY package*.json ./

RUN npm ci

# Copy source code and configuration files
COPY tsconfig.json ./
COPY src/ ./src/

# Build the project
RUN npm run build

# Runtime stage
FROM --platform=$TARGETPLATFORM node:22-slim AS runner

# Install system dependencies required for runtime
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only production dependencies
COPY --from=builder /app/build ./build
COPY package*.json ./
RUN npm ci --only=production

RUN mkdir -p /app/.cache/uv && chown -R mcp:mcp /app
ENV XDG_CACHE_HOME="/app/.cache"
# Install Playwright browsers (ensure headless shell is installed)
RUN npx playwright install --with-deps chromium

USER mcp
RUN curl -fsSL https://bun.sh/install | bash
ENV BUN_INSTALL="/home/mcp/.bun"
ENV PATH="${BUN_INSTALL}/bin:${PATH}"
