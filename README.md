## Create-React-App With Docker

From https://www.peterbe.com/plog/how-to-create-react-app-with-docker.
This example is a modification of sample code above. Please read the reference first.

## Requirements
- Docker
- Global yarn


## Detail
- Modified Dockerfile:
```
# Use alpine instead
FROM node:8-alpine

ADD yarn.lock /yarn.lock
ADD package.json /package.json

ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin

# Install missing libs in alpine https://github.com/nodejs/docker-node/issues/282
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
```

- Build image:
`$ docker image build -t create-react-app:dev .`

- Run container and happy hacking!
`$ docker container run -it -p 3000:3000 -p 35729:35729 -v $(pwd):/app create-react-app:dev`
