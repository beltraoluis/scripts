#!/bin/bash

get_certificate_hash() {
    # Obtém o hash do certificado em base64
   hex_hash=$(openssl x509 -noout -pubkey -in "$1" | \
                    openssl pkey -pubin -outform der | \
                    openssl dgst -sha256 -binary | \
                    xxd -p | tr -d '\n')

    # Obtém o hash do certificado em base64
    base64_hash=$(openssl x509 -noout -pubkey -in "$1" | \
                    openssl pkey -pubin -outform der | \
                    openssl dgst -sha256 -binary | \
                    openssl enc -base64)

    # Obtém o fingerprint do certificado em SHA-1
    sha1_fingerprint=$(openssl x509 -noout -fingerprint -sha1 -in "$1" | awk -F'=' '{print $2}' | tr -d ':')

    # Obtém o fingerprint do certificado em SHA-256
    sha256_fingerprint=$(openssl x509 -noout -fingerprint -sha256 -in "$1" | awk -F'=' '{print $2}' | tr -d ':')
    
    echo
    cat "$1"
    echo
    echo "Fingerprint SHA-1: $sha1_fingerprint"
    echo "Fingerprint SHA-256: $sha256_fingerprint"
    echo "Hash em hex: $hex_hash"
    echo "Hash em b64: $base64_hash"
}

# Função para exibir a ajuda do script
help() {
    echo "Uso: $0 <arquivo.pem>"
    echo "Este script obtém o hash de um certificado em hexadecimal e base64."
    echo "Exemplo de uso: $0 cert.pem"
}

# Verifica se o arquivo PEM foi fornecido como argumento
if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    help
    exit 0
else
    get_certificate_hash "$1"
fi