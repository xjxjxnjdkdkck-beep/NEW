FROM node:22-bookworm-slim
WORKDIR /app
RUN corepack enable && corepack install --global pnpm@10.18.0
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm --version && CI=1 pnpm install --frozen-lockfile --reporter=append-only
COPY . .
RUN pnpm build
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000
CMD ["node", "dist/index.js"]
