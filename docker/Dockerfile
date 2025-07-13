FROM node:20-alpine

RUN apk add --no-cache git

WORKDIR /app

RUN npm install -g create-medusa-app

COPY docker/entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
