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
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFC (si falla) else 0x0
t4_LT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 5 --------------------------------------------------------------------
    // Test de B.LT
    SUBS X28, X2, #3 // 2 < 3 (true)

    B.LT t5_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFB (si falla) else 0x0
t5_LT:
    STUR X21, [x20, #8]     // MEM: 0x5
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 6 --------------------------------------------------------------------
    // Test de B.LT
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, #1       // -1 < 1 (true)

    B.LT t6_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFA (si falla) else 0x0
t6_LT:
    STUR X21, [x20, #8]     // MEM: 0x6
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 7 --------------------------------------------------------------------
    // Test de B.LT
    SUBS X28, X3, #2 // 3 < 2 (false)

    B.LT t7_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x7
    CBZ XZR, t7_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t7_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF9 (si falla) else 0x0
t7_LT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 8 --------------------------------------------------------------------
    // Test de B.LT
    SUBS X28, X1, #-1       // 1 < -1 (false)

    B.LT t8_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x8
    CBZ XZR, t8_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t8_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF8 (si falla) else 0x0
t8_LT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 9 --------------------------------------------------------------------
    // Test de B.LT
    SUBS X28, X1, X1       // 1 < 1 (false)

    B.LT t9_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x9
    CBZ XZR, t9_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t9_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF7 (si falla) else 0x0
t9_LT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 10 --------------------------------------------------------------------
    // Test de B.LT
    SUBS X28, x2, #2       // 2 < 2 (false)

    B.LT t10_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0xA
    CBZ XZR, t10_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t10_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF6 (si falla) else 0x0
t10_LT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 11 --------------------------------------------------------------------
    // Test de B.LT
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X29      // -1 < -1 (false)

    B.LT t11_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0xB
    CBZ XZR, t11_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t11_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF5 (si falla) else 0x0
t11_LT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 12 --------------------------------------------------------------------
    // Test de B.LT
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, #-1      // -1 < -1 (false)

    B.LT t12_LT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0xC
    CBZ XZR, t12_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t12_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF4 (si falla) else 0x0
t12_LT_end:
// --------------------------------------------------------------------

endloop:
    CBZ XZR, endloop
