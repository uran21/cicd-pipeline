# Dockerfile
FROM node:18-alpine # Или node:20-alpine для еще более новой версии

WORKDIR /opt
ADD . /opt
RUN npm install

EXPOSE 3000
CMD ["node", "src/index.js"]
