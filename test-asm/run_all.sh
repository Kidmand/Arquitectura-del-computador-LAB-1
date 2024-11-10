#!/bin/bash
FILES=(

    "test-p2-vc.s" 

)

for TEST_FILE in "${FILES[@]}"; do
    echo "Ejecutando para archivo: $TEST_FILE"
    echo "..............................................."

    ./compile.sh "$TEST_FILE" -i

    echo "..............................................."
    echo "Corriendo la simulación RTL para el proyecto ..."
    ./quartus-cli.sh --rtl --no-gui >/dev/null

    echo "..............................................."

    # Agrega la salida de memdump al archivo de prueba .s, entre /* y */
    echo "/*" >> "$TEST_FILE"
    echo "Salida en memdump:" >> "$TEST_FILE"
    ./get_memdump.sh >> "$TEST_FILE"
    echo "Finalizado para archivo: $TEST_FILE" >> "$TEST_FILE"
    echo "===============================================" >> "$TEST_FILE"
    echo "*/" >> "$TEST_FILE"

    echo "Finalizado para archivo: $TEST_FILE"
    echo "Salida agregada en $TEST_FILE"
    echo "==============================================="
done
