    .text
    .org 0x0000
    // registos reservados
    // X30 = mensajes
    // X29 = auxiliar
    // X28 = resultado auxiliar
    // X0 = 0
    // X1 = 1
    // X2 = 2

// ----------------------------------------------------------
// ----------------------------EQ----------------------------
    // Test de B.EQ signado // caso de salto
    SUB X29, X1, X2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X29 // => Z=1

    B.EQ t1_EQ
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADD X30, X0, #-1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #0] // MEM: 0xFFFFFFFFFFFFFFFF (si falla) else 0x0
t1_EQ:
    ADD X30, X0, #1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #8] // MEM: 0x1
// --------------------------------------------------------
    // Test de B.EQ signado // caso de no salto
    SUB X29, X0, X2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X1  // => Z=0

    B.EQ t2_EQ
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADD X30, X0, #2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #16] // MEM: 0x2 
    CBZ XZR, t2_EQ_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t2_EQ:    
    ADD X30, X0, #-2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #24] // MEM: 0xFFFFFFFFFFFFFFFE (si falla) else 0x0
t2_EQ_end:
// --------------------------------------------------------
    // Test de B.EQ no signado // caso de salto
    ADD X29, X1, X2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X29 // => Z=1

    B.EQ t3_EQ
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADD X30, X0, #-3
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #32] // MEM: 0xFFFFFFFFFFFFFFFD (si falla) else 0x0
t3_EQ:
    ADD X30, X0, #3
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #40] // MEM: 0x3 
// --------------------------------------------------------
    // Test de B.EQ no signado // caso de no salto
    ADD X29, X1, X1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X1  // => Z=0

    B.EQ t4_EQ
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADD X30, X0, #4
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #48] // MEM: 0x4 
    CBZ XZR, t4_EQ_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t4_EQ:
    ADD X30, X0, #-4
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #56] // MEM: 0xFFFFFFFFFFFFFFFC (si falla) else 0x0
t4_EQ_end:
// --------------------------------------------------------

endloop:
    CBZ XZR, endloop

