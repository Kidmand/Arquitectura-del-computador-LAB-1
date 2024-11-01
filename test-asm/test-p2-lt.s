    .text
    .org 0x0000

    // TEST de B.LT (<)   negative !== overflow

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
// 1 --------------------------------------------------------------------
    // Test de B.LT
    SUBS X28, X2, X3 // 2 < 3 (true)

    B.LT t1_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFF (si falla) else 0x0
t1_LT:
    STUR X21, [x20, #8]     // MEM: 0x1
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 2 --------------------------------------------------------------------
    // Test de B.LT
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X1       // -1 < 1 (true)

    B.LT t2_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFE (si falla) else 0x0
t2_LT:
    STUR X21, [x20, #8]     // MEM: 0x2
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 3 --------------------------------------------------------------------
    // Test de B.LT
    SUBS X28, X3, X2 // 3 < 2 (false)

    B.LT t3_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x3
    CBZ XZR, t3_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t3_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFD (si falla) else 0x0
t3_LT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 4 --------------------------------------------------------------------
    // Test de B.LT
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X1, X29       // 1 < -1 (false)

    B.LT t4_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x4
    CBZ XZR, t4_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t4_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFE (si falla) else 0x0
t4_LT_end:
// --------------------------------------------------------------------

endloop:
    CBZ XZR, endloop
