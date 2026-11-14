# Etapa base
FROM docker.io/library/node:22-alpine AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app

# Etapa 1: construir (dependencias antes que el código)
FROM base AS build
COPY src/repo/app/pnpm-lock.yaml src/repo/app/pnpm-workspace.yaml src/repo/app/package.json ./
COPY src/repo/app/backend/package.json ./backend/
RUN pnpm install --frozen-lockfile --filter backend
COPY src/repo/app/backend ./backend
COPY src/repo/app/package.json src/repo/app/pnpm-workspace.yaml src/repo/app/pnpm-lock.yaml ./
RUN pnpm --filter backend build
RUN pnpm --filter backend deploy --prod /out && cp -r backend/dist /out/dist

# Etapa 2: ejecutar (imagen mínima)
FROM base AS runtime
ENV NODE_ENV=production
COPY --from=build /out /app
WORKDIR /app
EXPOSE 3001
CMD ["node", "dist/main"]
