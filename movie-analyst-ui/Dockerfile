FROM node:alpine3.15

COPY . .

EXPOSE 8000

ENV BACKEND_URL $BACKEND_URL

ENV BACK_END_URL $BACK_END_URL

RUN npm install

CMD ["npm","start"]


