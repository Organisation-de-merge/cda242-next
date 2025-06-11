FROM node:24.2-alpine3.21 as builder

LABEL org.opencontainers.image.source=https://github.com/organisation-de-merge/cda242-next

ADD . /app/

WORKDIR /app

RUN npm install
RUN npm run build

 # Execution
FROM node:24.2-alpine3.21 as next

COPY --from=builder /app/package.json /app/package.json
COPY --from=builder /app/.next /app/.next
COPY --from=builder /app/node_modules /app/node_modules

WORKDIR /app

EXPOSE 3000

 # On copie le script d'entrée dans le conteneur et on retire le .sh pour pas avoir à le remettre à chaque fois
COPY docker/next/entrypoint.sh /usr/local/bin/entrypoint
 # On donne les droits d'exécution au script
RUN chmod +x /usr/local/bin/entrypoint

ENTRYPOINT [ "entrypoint" ]
CMD ["npm", "run", "start" ]