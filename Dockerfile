# Dockerfile
FROM node:18-alpine

WORKDIR /opt
ADD . /opt
RUN npm install

EXPOSE 3000
CMD ["node", "src/index.js"]
