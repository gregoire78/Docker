FROM node:8

USER node
RUN mkdir /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
RUN npm install -g @angular/cli
#RUN npm install -g --unsafe

WORKDIR /home/node/app

EXPOSE 4200