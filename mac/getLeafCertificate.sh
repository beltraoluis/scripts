#!/bin/bash

getLeafCertificate() {
    # Obtém a URL fornecida como parâmetro
    url=$1

    # Define o nome do arquivo de certificado
    cert_file="${url//[:\/]/_}_0.pem"

    # Faz o download dos certificados
    openssl s_client -showcerts -connect "$url:443" </dev/null 2>/dev/null | \
        openssl x509 -outform PEM > "$cert_file"

    # Verifica se o download foi bem-sucedido
    if [ $? -eq 0 ]; then
        echo "Certificado baixado com sucesso. Arquivo: $cert_file"
    else
        echo "Ocorreu um erro ao baixar o certificado."
    fi
}

help() {
    echo "Uso: $0 <URL>"
    echo "Descrição: Este script faz o download do certificado de folha de uma URL fornecida como parâmetro."
    echo "Exemplo: $0 www.example.com"
}


# Verifica se foi fornecida uma URL como parâmetro
if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    help
    exit 0
else
    getLeafCertificate "$@"
fi