#!/bin/bash

# Estapas para o Deployment do Projeto Laravel em producao
# 1 - create a .env file => APP_ENV=production
# 2 - php artisan key:generate
# 3 - composer install --optimize-autoloader --no-dev
# 4 - php artisan config:cache
# 5 - php artisan route:cache
# 6 - chmod -R o+w project/storage
# 7 - chgrp -R www-data storage bootstrap/cache
# 8 - chmod -R ug+rwx storage bootstrap/cache

echo "Atribuindo permissao para a pasta Storage..."
chmod -R o+w ./storage

echo "Criando diretorio bootstrap/cache..."
mkdir bootstrap/cache

echo "Criando diretorios nescessarios dentro de bootstrap/cache: sessions, views, cache..."
mkdir storage/framework
mkdir storage/framework/sessions
mkdir storage/framework/views
mkdir storage/framework/cache

echo "Atribuindo permissoes para bootstrap/cache..."
chgrp -R www-data bootstrap/cache
chmod -R ug+rwx bootstrap/cache

echo "Copiando .env.example .env ..."
cp .env.example .env

echo "Editando configuracao do .env para producao via sed..."
sed -i 's/local/production/' .env

echo "configurando .env para conexão com o banco de dados..."
sed -i 's/DB_CONNECTION=/DB_CONNECTION=DRIVER/' .env
sed -i 's/DB_HOST=/DB_HOST=hostname/' .env
sed -i 's/DB_PORT=/DB_PORT=IP_PORT/' .env
sed -i 's/DB_DATABASE=/DB_DATABASE=DB_NAME/' .env
sed -i 's/DB_USERNAME=/DB_USERNAME=USERNAME/' .env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=YOUR_PASSWORD/' .env

echo "Instalando dependencias..."
composer install --optimize-autoloader --no-dev

echo "Criando chave do projeto..."
php artisan key:generate

echo "Configurando cache do projeto..."
php artisan config:cache

echo "Criando cache para rotas..."
php artisan route:cache

echo "Finalizando configuracoes..."
