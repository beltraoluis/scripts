#!/bin/bash

get_certificate_chain() {

    # Extrai o nome do arquivo do URL
    filename="${url//[:\/]/_}.chain.pem"

    # Faz o download dos certificados
    openssl s_client -showcerts -connect "$1" </dev/null 2>/dev/null | \
        awk '/-----BEGIN CERTIFICATE-----/, /-----END CERTIFICATE-----/' > "$filename"

    # Verifica se o download foi bem-sucedido
    if [ $? -eq 0 ]; then
        echo "Os certificados foram baixados com sucesso. Arquivo: $filename"
    else
        echo "Ocorreu um erro ao baixar o certificado."
    fi
}

help() {
    echo "Este script faz o download da cadeia de certificados de um URL."
    echo "Uso: $0 <URL>"
    echo "Exemplo: $0 www.example.com"
}

# Verifica se o parâmetro foi fornecido
if [ -z "$1" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    help
    exit 0
else
    # Chama a função com a URL desejada
    get_certificate_chain "$1"
fi