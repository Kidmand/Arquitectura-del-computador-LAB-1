    .text
    .org 0x0000

// ------------------ EJ 2.A ------------------- //

// Con la menor cantidad de registros e instrucciones, inicializar con el valor de su
// índice las primeras N posiciones de memoria (comenzando en la dirección “0”).

    // Inicialización del contador
    ADD x9, x30, x30    // x9 = 30 + 30 = 60
    ADD x9, x9, x4      // x9 = 60 + 4 = 64
    
    ADD x10, XZR, XZR   // x10 = 0 Variable para la dirección de memoria
    ADD X11, XZR, XZR   // x11 = 0 Variable para el valor a guardar

loop:
    STUR x11, [x10]     // Guardar el valor de x11 en la dirección x10
    ADD x10, x10, x8    // Avanzar la dirección en 8 bytes
    ADD x11, x11, x1    // Incrementar el valor de x11
    SUB x9, x9, x1      // Decrementar el contador
    CBZ  x9, end        // Revisar si el contador es 0, si es así, terminamos
    CBZ  XZR, loop      // Sino volvemos al inicio del bucle

end: CBZ XZR, end        // Bucle infinito

// ------------------- FIN -------------------- //

// ------------------ EJ 2.B ------------------- //

// Realizar la sumatoria de las primeras N posiciones de memoria y guardar el
// resultado en la posición N+1.

    // Inicialización
    SUB x10, x10, x10         // Establecer x10 en 0 (base de memoria)
    SUB x13, x13, x13         // Establecer x13 en 0 (acumulador)
    ADD x12, x10, x15         // Establecer x12 en N (número de elementos)

    CBZ x12, end              // Si x12 es 0, saltar a End (resultado final)
loop:
    LDUR x14, [x10]           // Cargar el valor desde la dirección base en x14
    ADD  x13, x13, x14        // Sumar el valor en x14 al acumulador x13
    ADD  x10, x10, X8         // Avanzar la dirección base en 8 bytes
    SUB  x12, x12, X1         // Decrementar el contador N
    
    CBZ  x12, end             // Verificar de nuevo si x12 es 0, si es así, saltar a End
    CBZ  XZR, loop            // Volver al inicio del bucle si x12 no es 0 (xzr siempre es 0, así que esto siempre regresa al bucle)

end:
    STUR  x13, [x10]          // Almacenar el resultado acumulado en la posición N+1
end1: CBZ XZR, end1           // Bucle infinito

// ------------------- FIN -------------------- //

// ------------------ EJ 2.C ------------------- //

// Realizar la multiplicación de dos registros: X16 y X17 y
// guardar el resultado en la posición “0” de la memoria.

    SUB X14, X14, X14      // Inicializar X14 (temporal) a 0 (Acumulador para el resultado)
    ADD X15, X17, XZR      // Inicializar X15 (temporal) a X17 (Para llevar el conteo de iteraciones)

    CBZ X15, end           // Si X15 es 0, saltar a "end"
loop:  
    ADD X14, X14, X16      // Sumar X16 a X14 (Resultado acumulado)
    SUB X15, X15, X1       // Decrementar el contador
    CBZ  x15, end          // Verificar de nuevo si x15 es 0, si es así, saltar a End
    CBZ  XZR, loop         // Volver al inicio del bucle si x15 no es 0 (xzr siempre es 0, así que esto siempre regresa al bucle)

end: 
    STUR X14, [XZR]        // Guardar el resultado en la dirección 0 de memoria

end1: CBZ XZR, end1        // Bucle infinito

// ------------------- FIN -------------------- //
