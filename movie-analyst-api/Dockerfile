FROM node:alpine3.15

COPY . .

ENV DB_HOST $DB_HOST

ENV DB_USER=root

ENV DB_PASS=laralara

ENV DB_NAME=movie_db

EXPOSE 3000

RUN npm install

RUN ls

CMD ["npm","start"]


