#!/bin/bash

from_hex() {
    # Recebe o hex em formato de string como parâmetro
    hex_string="$1"
    # Converte o hex para base64
    base64_string=$(echo -n "$hex_string" | xxd -r -p | base64)
    # Imprime o resultado
    echo "$base64_string"
}

help() {
    echo "Usage: $0 <hex_string>"
    echo "Converts a hexadecimal string to base64."
    echo "example: $0 12c4ffer5943ac90dc445123"
    echo "Options:"
    echo "  --help, -h    Show this help message and exit."
}

if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    help
    exit 0
else
    from_hex "$1"
fi