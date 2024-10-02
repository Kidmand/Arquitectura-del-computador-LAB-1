    .text
    .org 0x0000

// ------------------ EJ 2.A ------------------- //
/* 
// Con la menor cantidad de registros e instrucciones, inicializar con el valor de su
// índice las primeras N posiciones de memoria (comenzando en la dirección “0”).

    // Inicialización del contador
    ADD x9, x30, x30    // x9 = 30 + 30 = 60
    ADD x9, x9, x4      // x9 = 60 + 4 = 64
    
    ADD x10, XZR, XZR   // x10 = 0 Variable para la dirección de memoria
    ADD X11, XZR, XZR   // x11 = 0 Variable para el valor a guardar

loop2A:
    STUR x11, [x10]     // Guardar el valor de x11 en la dirección x10
    ADD x10, x10, x8    // Avanzar la dirección en 8 bytes
    ADD x11, x11, x1    // Incrementar el valor de x11
    SUB x9, x9, x1      // Decrementar el contador
    CBZ  x9, end2A      // Revisar si el contador es 0, si es así, terminamos
    CBZ  XZR, loop2A    // Sino volvemos al inicio del bucle

end2A:

// ------------------- FIN -------------------- //

// ------------------ EJ 2.B ------------------- //

// Realizar la sumatoria de las primeras N posiciones de memoria y guardar el
// resultado en la posición N+1.

    // Inicialización
    SUB x10, x10, x10         // Establecer x10 en 0 (base de memoria)
    SUB x13, x13, x13         // Establecer x13 en 0 (acumulador)
    ADD x12, x10, x15         // Establecer x12 en N (número de elementos)

    CBZ x12, end2B            // Si x12 es 0, saltar a End (resultado final)
loop2B:
    LDUR x14, [x10]           // Cargar el valor desde la dirección base en x14
    ADD  x13, x13, x14        // Sumar el valor en x14 al acumulador x13
    ADD  x10, x10, X8         // Avanzar la dirección base en 8 bytes
    SUB  x12, x12, X1         // Decrementar el contador N
    
    CBZ  x12, end2B           // Verificar de nuevo si x12 es 0, si es así, saltar a End
    CBZ  XZR, loop2B          // Volver al inicio del bucle si x12 no es 0 (xzr siempre es 0, así que esto siempre regresa al bucle)

end2B:
    STUR  x13, [x10]          // Almacenar el resultado acumulado en la posición N+1

// ------------------- FIN -------------------- //

// ------------------ EJ 2.C ------------------- //

// Realizar la multiplicación de dos registros: X16 y X17 y
// guardar el resultado en la posición “0” de la memoria.

    SUB X14, X14, X14      // Inicializar X14 (temporal) a 0 (Acumulador para el resultado)
    ADD X15, X17, XZR      // Inicializar X15 (temporal) a X17 (Para llevar el conteo de iteraciones)

    CBZ X15, end2C         // Si X15 es 0, saltar a "end"
loop2C:  
    ADD X14, X14, X16      // Sumar X16 a X14 (Resultado acumulado)
    SUB X15, X15, X1       // Decrementar el contador
    CBZ  x15, end2C        // Verificar de nuevo si x15 es 0, si es así, saltar a End
    CBZ  XZR, loop2C       // Volver al inicio del bucle si x15 no es 0 (xzr siempre es 0, así que esto siempre regresa al bucle)

end2C: 
    STUR x14, [x0]         // Guardar el resultado en la dirección 0 de memoria

// ------------------- FIN -------------------- //

endloop: CBZ XZR, endloop  // Bucle infinito


*/


STUR X1, [X0, #0] // MEM 0:0x1
STUR X2, [X0, #8] // MEM 1:0x2
STUR X3, [X16, #0] // MEM 2:0x3
ADD X3, X4, X5
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X3, [X0, #24] // MEM 3:0x9
SUB X3, X4, X5
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X3, [X0, #32] // MEM 4:0xFFFFFFFFFFFFFFFF
SUB X4, XZR, X10
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X4, [X0, #40] // MEM 5:0xFFFFFFFFFFFFFFF6
ADD X4, X3, X4
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X4, [X0, #48] // MEM 6:0xFFFFFFFFFFFFFFF5
SUB X5, X1, X3
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X5, [X0, #56] // MEM 7:0x2
AND X5, X10, XZR
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X5, [X0, #64] // MEM 8:0x0
AND X5, X10, X3
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X5, [X0, #72] // MEM 9:0xA
AND X20, X20, X20
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X20, [X0, #80] // MEM 10:0x14
ORR X6, X11, XZR
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X6, [X0, #88] // MEM 11:0xB
ORR X6, X11, X3
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X6, [X0, #96] // MEM 12:0xFFFFFFFFFFFFFFFF
LDUR X12, [X0, #0]
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
ADD X7, X12, XZR
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X7, [X0, #104] // MEM 13:0x1
STUR X12, [X0, #112] // MEM 14:0x1
ADD XZR, X13, X14
STUR XZR, [X0, #120] // MEM 15:0x0
CBZ X0, L1
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X21, [X0, #128] // MEM 16:0x0(si falla CBZ =21)
L1: STUR X21, [X0, #136] // MEM 17:0x15
ADD X2, XZR, X1
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
L2: SUB X2, X2, X1
ADD X24, XZR, X1
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X24, [X0, #144] // MEM 18:0x1 y MEM 19=0x1
ADD X0, X0, X8
CBZ X2, L2
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X30, [X0, #144] // MEM 20:0x1E
ADD X30, X30, X30
SUB X21, XZR, X21
ADD XZR, XZR, XZR  // NOP
ADD X30, X30, X20
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
LDUR X25, [X30, #-8]
ADD X30, X30, X30
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
ADD X30, X30, X16
ADD XZR, XZR, XZR  // NOP
ADD XZR, XZR, XZR  // NOP
STUR X25, [X30, #-8] // MEM 21:0xA (= MEM 9)
finloop: CBZ XZR, finloop


