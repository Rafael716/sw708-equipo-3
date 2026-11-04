# Frontend Next.js - build multi-etapa con pnpm workspace
# Contexto de build: raíz del workspace (app/)

# ---------- Base ----------
FROM node:22-alpine AS base
ENV PNPM_HOME="/pnpm" PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app

# ---------- Build ----------
FROM base AS build
ARG NEXT_PUBLIC_API_URL=http://localhost:3001
ENV NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL
ENV NEXT_OUTPUT_STANDALONE=true
COPY pnpm-lock.yaml pnpm-workspace.yaml package.json ./
COPY frontend/package.json ./frontend/
RUN pnpm install --frozen-lockfile --filter frontend
COPY . .
RUN pnpm --filter frontend build

# ---------- Runtime ----------
FROM base AS runtime
ENV NODE_ENV=production
COPY --from=build /app/frontend/.next/standalone /app
COPY --from=build /app/frontend/.next/static /app/frontend/.next/static
COPY --from=build /app/frontend/public /app/frontend/public
WORKDIR /app/frontend
EXPOSE 3000
CMD ["node", "server.js"]