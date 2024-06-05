# Use uma imagem base leve do Node.js
FROM node:alpine

# Atualizar pacotes e instalar dependências do sistema
RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash

# Criar um diretório de trabalho para a aplicação
WORKDIR /usr/src/app

# Copiar os arquivos necessários e instalar as dependências da aplicação
COPY package*.json ./
RUN npm install --production

# Copiar o código da aplicação
COPY . .

# Criar um usuário não privilegiado para executar a aplicação
RUN addgroup -g 1001 nodejs && \
    adduser -D -u 1001 -G nodejs nodejs
USER nodejs

# Expor a porta da aplicação
EXPOSE 8090

# Comando para iniciar a aplicação
CMD ["node", "app.js"]