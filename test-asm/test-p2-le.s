    .text
    .org 0x0000

    // TEST de B.LE (<=)   (negative !== 0) && (negative !== overflow)

    // registos reservados
    // X29 = auxiliar
    // X28 = auxiliar
    // x20 = iterador de memoria
    // x21 = iterador del mensaje de exito
    // x22 = iterador del mensaje de fallo
    // X0 = 0
    // X1 = 1
    // X2 = 2
    
//B.GT (>)         (negative === 0) && (negative === overflow)

// --------------------------------------------------------------------
    ADD x20, x0, x0 // Inicializa iterador de memoria
    ADD x21, x0, #1 // Inicializa iterador del mensaje de exito
    ADD x22, x0, #-1 // Inicializa iterador del mensaje de fallo
// 1 --------------------------------------------------------------------
    // Test de B.LE
    SUBS X28, X2, X3 // 2 <= 3 (true)

    B.LE t1_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFF (si falla) else 0x0
t1_LE:
    STUR X21, [x20, #8]     // MEM: 0x1
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 2 --------------------------------------------------------------------
    // Test de B.LE
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X1       // -1 <= 1 (true)

    B.LE t2_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFE (si falla) else 0x0
t2_LE:
    STUR X21, [x20, #8]     // MEM: 0x2
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 3 --------------------------------------------------------------------
    // Test de B.LE
    SUBS X28, X3, X2 // 3 <= 2 (false)

    B.LE t3_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x3
    CBZ XZR, t3_LE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t3_LE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFD (si falla) else 0x0
t3_LE_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 4 --------------------------------------------------------------------
    // Test de B.LE
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X1, X29       // 1 <= -1 (false)

    B.LE t4_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x4
    CBZ XZR, t4_LE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t4_LE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFC (si falla) else 0x0
t4_LE_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 5 --------------------------------------------------------------------
    // Test de B.LE
    SUBS X28, X2, #3 // 2 <= 3 (true)

    B.LE t5_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFB (si falla) else 0x0
t5_LE:
    STUR X21, [x20, #8]     // MEM: 0x5
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 6 --------------------------------------------------------------------
    // Test de B.LE
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, #1       // -1 <= 1 (true)

    B.LE t6_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFA (si falla) else 0x0
t6_LE:
    STUR X21, [x20, #8]     // MEM: 0x6
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 7 --------------------------------------------------------------------
    // Test de B.LE
    SUBS X28, X3, #2 // 3 <= 2 (false)

    B.LE t7_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x7
    CBZ XZR, t7_LE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t7_LE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF9 (si falla) else 0x0
t7_LE_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 8 --------------------------------------------------------------------
    // Test de B.LE
    SUBS X28, X1, #-1       // 1 <= -1 (false)

    B.LE t8_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x8
    CBZ XZR, t8_LE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t8_LE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF8 (si falla) else 0x0
t8_LE_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 9 --------------------------------------------------------------------
    // Test de B.LE
    SUBS X28, X1, X1       // 1 <= 1 (true)

    B.LE t9_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF7 (si falla) else 0x0
t9_LE:
    STUR X21, [x20, #8]     // MEM: 0x9
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 10 --------------------------------------------------------------------
    // Test de B.LE
    SUBS X28, x2, #2       // 2 < 2 (true)

    B.LE t10_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF6 (si falla) else 0x0
t10_LE:
    STUR X21, [x20, #8]     // MEM: 0xA
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 11 --------------------------------------------------------------------
    // Test de B.LE
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X29      // -1 < -1 (true)

    B.LE t11_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF5 (si falla) else 0x0
t11_LE:
    STUR X21, [x20, #8]     // MEM: 0xB
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 12 --------------------------------------------------------------------
    // Test de B.LE
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, #-1      // -1 < -1 (true)

    B.LE t12_LE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF4 (si falla) else 0x0
t12_LE:
    STUR X21, [x20, #8]     // MEM: 0xC
t12_LE_end:
// --------------------------------------------------------------------

endloop:
    CBZ XZR, endloop
