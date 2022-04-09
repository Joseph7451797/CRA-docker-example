FROM node:16-alpine

ADD yarn.lock /yarn.lock
ADD package.json /package.json

ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin

RUN set -xe \
    &&  apk add --no-cache --virtual .gyp \
            python3 \
            make \
            g++ \
        && yarn \
        && apk del .gyp

WORKDIR /app

ADD ./run.sh /app/run.sh
ADD ./public /app/public
ADD ./src /app/src

EXPOSE 3000
EXPOSE 35729

ENTRYPOINT ["sh", "/app/run.sh"]
CMD ["start"]
