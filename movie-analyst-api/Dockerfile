FROM node:alpine3.15

COPY . .

ENV DB_HOST $DB_HOST

ENV DB_USER $DB_USER

ENV DB_PASS $DB_PASS

ENV DB_NAME $DB_NAME

EXPOSE 3000

RUN npm install

RUN ls

CMD ["npm","start"]


