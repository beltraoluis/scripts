#!/bin/bash

get_intermediary_certificate() {
    # Obtém a URL fornecida como parâmetro
    url=$1

    # Define o nome do arquivo de certificado
    cert_file="${url//[:\/]/_}_1.pem"

    # Faz o download dos certificados
    openssl s_client -showcerts -connect "$url:443" </dev/null 2>/dev/null | \
        awk '/-----BEGIN CERTIFICATE-----/{n++} n==2' | \
        openssl x509 -outform PEM > "$cert_file"

    # Verifica se o download foi bem-sucedido
    if [ $? -eq 0 ]; then
        echo "Certificado baixado com sucesso. Arquivo: $cert_file"
    else
        echo "Ocorreu um erro ao baixar o certificado."
    fi
}

# Função de ajuda
help() {
    echo "Uso: $0 <URL>"
    echo "Descrição: Este script faz o download do certificado intermediário de um site."
    echo "Parâmetros:"
    echo "  <URL> - A URL do site para obter o certificado intermediário."
    echo "Exemplo: $0 www.example.com"
}

# Verifica se foi fornecida uma opção de ajuda como parâmetro
if [ $# -eq 0 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    help
    exit 0
else
    get_intermediary_certificate "$1"
fi