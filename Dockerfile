
FROM nginx:alpine

WORKDIR /usr/src/app

COPY package*.json ./

COPY . .

CMD [ "npm", "run" "start" ]
