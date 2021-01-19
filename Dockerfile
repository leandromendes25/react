from node:latest AS build
WORKDIR /usr/src

RUN apt-get update && apt-get install -y 
RUN npm init -y && npm update && npm install typescript@latest
RUN touch /home/node/.bashrc | echo "PS1='\w\$ '" >> /home/node/.bashrc
RUN usermod -u 1000 node
#Faz instalar o dockerize que evite que o node seja inicializado antes do banco, basicamente verifica se mysql está pronto, executado dentro do node.
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz



from node:alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src .
RUN apk update && apk add bash
USER node
EXPOSE 3000