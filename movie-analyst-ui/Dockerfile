FROM node:alpine3.15

COPY . .

EXPOSE 8000

ENV BACKEND_URL $BACKEND_URL

RUN npm install

CMD ["npm","start"]


