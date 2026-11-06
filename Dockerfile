FROM node:22-bookworm-slim
WORKDIR /app
RUN corepack enable && corepack install --global pnpm@10.18.0
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
# تقليل استهلاك الذاكرة أثناء التثبيت
RUN NODE_OPTIONS="--max-old-space-size=460" pnpm install --no-frozen-lockfile --child-concurrency=1 --network-concurrency=1
COPY . .
# تقليل استهلاك الذاكرة أثناء البناء
RUN NODE_OPTIONS="--max-old-space-size=460" pnpm build
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000
CMD ["node", "dist/index.js"]
