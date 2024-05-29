#!/bin/bash

get_certificate_at() {
    # Obtém a URL fornecida como primeiro parâmetro
    local url=$1

    # Obtém o valor de n fornecido como segundo parâmetro
    local n=$2

    # Define o nome do arquivo de certificado
    local cert_file="${url//[:\/]/_}_${n}.pem"

    # Faz o download dos certificados
    openssl s_client -showcerts -connect "$url:443" </dev/null 2>/dev/null | \
        awk '/-----BEGIN CERTIFICATE-----/{n++} n=='"$((n+1))"'' | \
        openssl x509 -outform PEM > "$cert_file"

    # Verifica se o download foi bem-sucedido
    if [ $? -eq 0 ]; then
        echo "Certificado baixado com sucesso. Arquivo: $cert_file"
    else
        echo "Ocorreu um erro ao baixar o certificado."
    fi
}

help() {
    echo "Este script faz o download de certificados SSL de uma URL específica."
    echo "Uso: $0 <URL> <posição>"
    echo "Exemplo: $0 www.example.com 0"
    echo "Onde:"
    echo "  <URL> é a URL do servidor SSL"
    echo "  <posição> é a posição do certificado na cadeia de certificados do servidor"
}


# Verifica se foram fornecidos dois parâmetros
if [ $# -lt 2 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Por favor, forneça uma URL e a posição do certificado como parâmetros."
    exit 0
else
    get_certificate_at "$@"
fi