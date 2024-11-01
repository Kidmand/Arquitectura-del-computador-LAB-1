    .text
    .org 0x0000

    // TEST de GT (>) 

    // registos reservados
    // X29 = auxiliar
    // X28 = auxiliar
    // x20 = iterador de memoria
    // x21 = iterador del mensaje de exito
    // x22 = iterador del mensaje de fallo
    // X0 = 0
    // X1 = 1
    // X2 = 2

// --------------------------------------------------------------------
    ADD x20, x0, x0 // Inicializa iterador de memoria
    ADD x21, x0, #1 // Inicializa iterador del mensaje de exito
    ADD x22, x0, #-1 // Inicializa iterador del mensaje de fallo
// 1 ------------------------------------------------------------------
    // Test de B.GT
    SUBS X28, X4, X3 // 4 > 3 (true)

    B.GT t1_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFF (si falla) else 0x0
t1_GT:
    STUR X21, [x20, #8]     // MEM: 0x1
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 2 ------------------------------------------------------------------
    // Test de B.GT
    SUBS X28, X4, X4 // 4 > 4 (false)

    B.GT t2_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x2
    CBZ XZR, t2_GT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t2_GT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFE (si falla) else 0x0
t2_GT_end:

// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 3 ------------------------------------------------------------------
    // Test de B.GT
    SUBS X28, X4, #3 // 4 > 3 (true)

    B.GT t3_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFD (si falla) else 0x0
t3_GT:
    STUR X21, [x20, #8]     // MEM: 0x3
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 4 ------------------------------------------------------------------
    // Test de B.GT
    SUBS X28, X4, #4 // 4 > 4 (false)

    B.GT t4_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x4
    CBZ XZR, t4_GT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t4_GT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFC (si falla) else 0x0
t4_GT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 5 --------------------------------------------------------------------
    // Test de B.GT
    SUBS X28, X2, X3 // 2 > 3 (false)

    B.GT t5_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x5
    CBZ XZR, t5_GT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t5_GT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFB (si falla) else 0x0
t5_GT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 6 --------------------------------------------------------------------
    // Test de B.GT
    SUBS X28, X2, #3 // 2 > 3 (false)

    B.GT t6_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x6
    CBZ XZR, t6_GT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t6_GT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFA (si falla) else 0x0
t6_GT_end:
// --------------------------------------------------------------------

endloop:
    CBZ XZR, endloop
