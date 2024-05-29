#!/bin/bash

from_base64() {
    # Recebe o hash em base64 como argumento
    base64_hash="$1"

    # Decodifica o hash em base64 para binário
    binary_hash=$(echo "$base64_hash" | base64 -d)

    # Converte o hash binário para hexadecimal
    hex_hash=$(echo -n "$binary_hash" | xxd -p | tr -d '\n')

    # Exibe o hash em hexadecimal
    echo "$hex_hash"
}

help() {
    echo "Usage: certificateHexFromBase64.sh <base64_hash>"
    echo "Converts a base64 hash to hexadecimal."
    echo ""
    echo "Options:"
    echo "  --help, -h     Show this help message and exit."
}

if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    help
    exit 0
else
    from_base64 "$1"
fi