FROM node:lts-alpine
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN npm install -g npm@9.8.1
RUN npm install
RUN npx nx run nft-bridge:lint
ENV HOST=0.0.0.0
ENV PORT=3001
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true \
NEW_RELIC_LOG=stdout
RUN npx nx build nft-bridge
ENTRYPOINT ["node"]
CMD ["./dist/apps/nft-bridge/main.js"]
