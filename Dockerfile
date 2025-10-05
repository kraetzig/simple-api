# Dockerfile
FROM node:18-alpine
WORKDIR /app

# instalar dependências
COPY package*.json ./
RUN npm ci --only=production

# copiar código
COPY . .

EXPOSE 3000
ENV NODE_ENV=production
CMD ["npm", "run", "start"]
