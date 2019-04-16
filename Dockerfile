FROM node:8-alpine

ADD yarn.lock /yarn.lock
ADD package.json /package.json

ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin

RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++ \
    && yarn \
    && apk del .gyp

WORKDIR /app
ADD . /app

EXPOSE 3000
EXPOSE 35729

ENTRYPOINT ["sh", "/app/run.sh"]
CMD ["start"]
