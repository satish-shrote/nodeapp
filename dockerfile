FROM node:lts-alpine
RUN mkdir /app
WORKDIR /app
COPY . /app
ENV NEW_RELIC_NO_CONFIG_FILE=true
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true \
NEW_RELIC_LOG=stdout
RUN npm install
RUN npm install -g npm@9.8.1
RUN npx nx run nft-bridge:lint
ENV HOST=0.0.0.0
ENV PORT=3001
RUN npx nx build nft-bridge
ENTRYPOINT ["node"]
CMD ["./dist/apps/nft-bridge/main.js"]
