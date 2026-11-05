# Backend NestJS - build multi-etapa con pnpm workspace
# Contexto de build: raíz del workspace (app/)

# ---------- Base ----------
FROM node:22-alpine AS base
ENV PNPM_HOME="/pnpm" PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app

# ---------- Build ----------
FROM base AS build
COPY pnpm-lock.yaml pnpm-workspace.yaml package.json ./
COPY backend/package.json ./backend/
RUN pnpm install --frozen-lockfile --filter backend
COPY . .
RUN pnpm --filter backend build
RUN pnpm --filter backend deploy --prod /out && cp -r backend/dist /out/dist

# ---------- Runtime ----------
FROM base AS runtime
ENV NODE_ENV=production
COPY --from=build /out /app
WORKDIR /app
EXPOSE 3001
CMD ["node", "dist/main"]