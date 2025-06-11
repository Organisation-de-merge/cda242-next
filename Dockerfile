FROM node:24.2-alpine3.21

LABEL org.opencontainers.image.source=https://github.com/organisation-de-merge/cda242-next

ADD . /app/

WORKDIR /app

RUN npm install
RUN npm run build

EXPOSE 3000

COPY docker/next/entrypoint /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

ENTRYPOINT [ "entrypoint" ]
CMD npm run start