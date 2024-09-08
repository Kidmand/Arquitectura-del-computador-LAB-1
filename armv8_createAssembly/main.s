    .text
    .org 0x0000

// ------------------ EJ 2.A ------------------- //

// Con la menor cantidad de registros e instrucciones, inicializar con el valor de su
// índice las primeras N posiciones de memoria (comenzando en la dirección “0”).

    ADD x9, x30, x30 
    ADD x9, x9, x4
    ADD x10, xzr, xzr
    ADD X11, xzr, xzr

loop:
    STUR x11, [x10]
    ADD x10, x10, x8
    ADD x11, x11, x1
    SUB x9, x9, x1
    CBZ  x9, finloop 
    CBZ  xzr, loop

finloop: CBZ XZR, finloop

// ------------------- FIN -------------------- //

// ------------------ EJ 2.B ------------------- //

// Realizar la sumatoria de las primeras N posiciones de memoria y guardar el
// resultado en la posición N+1.


    // Definir la constante
    .equ CONST_N, 10

    // Inicialización
    SUB x0, x0, x0          // Establecer x0 en 0 (base de memoria)
    SUB x3, x3, x3          // Establecer x3 en 0 (acumulador)
    ADD x1, x0, CONST_N     // Establecer x1 en N (número de elementos)

	CBZ x1, End             // Si x1 es 0, saltar a End (resultado final)
loop:
    LDUR x2, [x0]            // Cargar el valor desde la dirección base en x2
    ADD  x3, x3, x2          // Sumar el valor en x2 al acumulador x3
    ADD  x0, x0, #8          // Avanzar la dirección base en 8 bytes
    SUB  x1, x1, #1          // Decrementar el contador N
    
    CBZ  x1, end             // Verificar de nuevo si x1 es 0, si es así, saltar a End
    CBZ  xzr, loop           // Volver al inicio del bucle si x1 no es 0 (xzr siempre es 0, así que esto siempre regresa al bucle)

end:
    STUR  x3, [x0]            // Almacenar el resultado acumulado en la posición N+1


// ------------------- FIN -------------------- //

// ------------------ EJ 2.C ------------------- //

// Realizar la multiplicación de dos registros: X16 y X17 y
// guardar el resultado en la posición “0” de la memoria.

    SUB X14, X14, X14      // Inicializar X14 (temporal) a 0 (Acumulador para el resultado)
	ADD X15, X17, #0       // Inicializar X15 (temporal) a X17 (Para llevar el conteo de iteraciones)

loop:  
	CBZ X15, end           // Si X15 es 0, saltar a "end"
    ADD X14, X14, X16      // Sumar X16 a X14 (Resultado acumulado)
    SUB X15, X15, #1       // Decrementar el contador
    B loop                 // Repetir el bucle

end: 
	SUB X13, X13, X13      // Inicializar X13 (temporal) a 0
    STUR X14, [X13, #0]    // Guardar el resultado en la dirección 0 de memoria

// ------------------- FIN -------------------- //
