#!/bin/bash

# Função para obter e salvar a cadeia de certificados
function get_cert_chain() {
    url=$1

    # Obtém a cadeia de certificados da URL
    cert_chain=$(openssl s_client -showcerts -connect $url:443 </dev/null 2>/dev/null)

    # Conta o número de certificados na cadeia
    cert_count=$(echo "$cert_chain" | grep -c "BEGIN CERTIFICATE")

    # Define o nome do arquivo de certificado
    cert_file="${url//[:\/]/_}_$cert_count.pem"

    # Faz o download dos certificados
    cert_chain=$(echo "$cert_chain" | awk "/-----BEGIN CERTIFICATE-----/{n++} n==$cert_count")
    echo "$cert_chain" | openssl x509 -outform PEM > "$cert_file"
}

# Função para exibir a mensagem de ajuda
function help() {
    echo "Uso: $0 <URL>"
    echo "Descrição: Este script obtém a cadeia de certificados de uma URL e salva o certificado raiz em um arquivo PEM."
    echo "Argumentos:"
    echo "  <URL> - A URL da qual obter a cadeia de certificados"
    echo "Exemplo: $0 www.example.com"
}

# Verifica se o argumento foi fornecido
if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    help
    exit 0
else
    get_cert_chain "$1"
fi
