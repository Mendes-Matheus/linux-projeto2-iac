#!/bin/bash

echo "Atualizando o servidor..."

# Atualizando pacotes e sistema
apt-get update && apt-get upgrade -y

# Instalando pacotes necessários
echo "Instalando pacotes necessários..."
apt-get install apache2 unzip -y

# Verificando se o Apache está ativo e iniciando o serviço
if service apache2 status > /dev/null; then
    echo "Apache já está em execução."
else
    echo "Iniciando o Apache..."
    service apache2 start
    echo "Apache iniciado."
fi

# Garantindo que o Apache será iniciado automaticamente no boot
update-rc.d apache2 defaults

echo "Baixando e copiando os arquivos da aplicação..."

# Download e extração
cd /tmp || exit
wget -q https://github.com/Mendes-Matheus/Projeto-Web/archive/refs/heads/main.zip

if [ -f "main.zip" ]; then
    echo "Arquivo baixado com sucesso."
    unzip -o main.zip
    cd Projeto-Web-main || exit

    # Limpando diretório de destino antes de copiar
    rm -rf /var/www/html/*
    cp -R * /var/www/html/

    echo "Arquivos copiados para o diretório do Apache."

    # Limpando arquivos temporários
    cd /tmp || exit
    rm -rf main.zip Projeto-Web-main
else
    echo "Falha ao baixar o arquivo. Verifique o link."
    exit 1
fi

echo "Scri

