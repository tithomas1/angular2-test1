FROM node:4.4.4-slim

WORKDIR /app

ADD ./package.json /app/package.json
ADD ./typings.json /app/typings.json

# Account for the Cisco proxy (typings can get it from rc file in project directory)
ADD ./.typingsrc /app/.typingsrc

RUN npm config set proxy http://proxy.esl.cisco.com:8080 && npm config set https-proxy http://proxy.esl.cisco.com:8080

# Install dependencies
RUN npm install --unsafe-perm=true && npm install -g typings

# Add the rest of the sources
ADD . /app

ENV HTTP_PROXY "http://proxy.esl.cisco.com:8080"

# lite-server defaults to port 3000, browser-sync UI to 3001
EXPOSE 3000-3001

CMD ["npm","start"]