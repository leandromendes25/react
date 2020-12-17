from node:latest AS build
WORKDIR /usr/src/app

COPY package-lock.json /usr/src/app
COPY package.json /usr/src/app
COPY node_modules /usr/src/app

#Faz instalar o dockerize que evite que o node seja inicializado antes do banco, basicamente verifica se mysql está pronto, executado dentro do node.
RUN apt-get update && apt-get install -y && npm install create-react-app -g && \
npm install --save node-sass-chokidar && npm install react-router 
ENTRYPOINT  ["time","yarn", "install"]


ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz



from node:alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app .
RUN apk update && apk add bash
RUN npm install react-router-dom --save
EXPOSE 3000