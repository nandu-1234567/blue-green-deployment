FROM node:20

WORKDIR /app

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=1337

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

EXPOSE 1337

CMD ["npm", "run", "start"]