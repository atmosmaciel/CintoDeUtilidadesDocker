#!/bin/bash

echo Define Your Environment

echo "Informe o caminho para a instalacao do Laravel"
read _environment

echo "Defina o nome do Projeto"
read _name_your_project

echo Change path to $_environment
cd $_environment

echo Start a Laravel Project
composer create-project --prefer-dist laravel/laravel $_name_your_project

echo "Copiando arquivos do docker para seu projeto"
cp -a docker-run.sh docker-compose.yml $_environment/$_name_your_project

echo "Fim :)"
