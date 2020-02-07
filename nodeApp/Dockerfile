FROM node:10-alpine

WORKDIR /usr/app

COPY package.json .
RUN npm install --quiet

COPY . .

EXPOSE 3001

CMD ["node", "app.js"]