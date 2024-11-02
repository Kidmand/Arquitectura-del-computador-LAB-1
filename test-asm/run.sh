#!/bin/bash

if [ -z "$1" ]; then
    echo "Usa: ./run.sh <test-file>"
    exit 1
fi

TEST_FILE=$1
FILE_NAME=$(basename "$1" .s)

echo "..............................................."

./compile.sh "$TEST_FILE" -i

echo "..............................................."

echo "Corriendo la simulación RTL para el proyecto ..."
./quartus-cli.sh --rtl --no-gui >/dev/null

echo "..............................................."

echo "Salida en memdump:"
./get_memdump.sh
