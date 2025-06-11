FROM node:24.2-alpine3.21

LABEL org.opencontainers.image.source=https://github.com/organisation-de-merge/cda242-next

ADD . /app/

WORKDIR /app

RUN npm install
RUN npm run build

EXPOSE 3000

COPY docker/next/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint" ]
CMD npm run start