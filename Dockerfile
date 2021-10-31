FROM node:16-alpine

COPY . /app
WORKDIR /app
RUN npm ci
RUN npm run build
CMD npm start