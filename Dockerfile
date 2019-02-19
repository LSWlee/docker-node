FROM node

MAINTAINER LI

ADD . /app/

WORKDIR /app

RUN npm install
RUN npm rebuild node-sass --force

ENV HOST 0.0.0.0
ENV PORT 8000

EXPOSE 8000

CMD ["npm","start"]

