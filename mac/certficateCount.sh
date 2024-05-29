#!/bin/bash

count_certificates() {
    url=$1

    # Obtém a cadeia de certificados da URL
    cert_chain=$(openssl s_client -showcerts -connect $url:443 </dev/null 2>/dev/null)

    # Conta o número de certificados na cadeia
    cert_count=$(echo "$cert_chain" | grep -c "BEGIN CERTIFICATE")

    echo "Certificados de $url: $cert_count"
}

help() {
    echo "Uso: $0 <URL>"
    echo "Descrição: Este script conta o número de certificados na cadeia de certificados de uma URL."
    echo "Exemplo: $0 www.example.com"
}

# Verifica se o argumento foi fornecido
if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    help
    exit 0
else
    count_certificates "$1"
fi
