FROM node:20-alpine
WORKDIR /app
RUN corepack enable && corepack install --global pnpm@10.18.0
COPY package.json pnpm-workspace.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000
CMD ["node", "dist/index.js"]
