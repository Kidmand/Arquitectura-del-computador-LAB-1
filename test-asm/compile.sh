#!/bin/bash

if [ -z "$1" ]; then
    echo "Usa: ./compile.sh <test-file> [-r output-file]"
    exit 1
fi

TEST_FILE=$1
FILE_NAME=$(basename "$1" .s)
OUTPUT_FILE=""

if [ "$2" == "-i" ]; then
    OUTPUT_FILE="../modulos/imem.txt"
fi

echo "..............................................."

make -C ../armv8_createAssembly ASM_SRC="../test-asm/$TEST_FILE"

if [ $? -ne 0 ]; then
    echo "Fallo la compilacion."
    exit 1
fi

echo "..............................................."
echo "Se compilo correctamente !!"
echo "..............................................."
echo "Salida en hexadecimal:"

LONG=$(cat $FILE_NAME.list | grep -oP '\t[0-9a-f]{8}' | wc -l)

HEX_OUTPUT=$(cat $FILE_NAME.list | grep -oP '\t[0-9a-f]{8}' | awk -v awkvar="$LONG" '{if (NR==1) {print $1} else { if (NR==awkvar){print $1} else {print $1}}}')

if [ -n "$OUTPUT_FILE" ]; then
    echo "$HEX_OUTPUT"
    echo "$HEX_OUTPUT" >"$OUTPUT_FILE"
    echo "Salida escrita en $OUTPUT_FILE"
else
    echo "$HEX_OUTPUT"
fi

echo "..............................................."

./clean.sh
