    .text
    .org 0x0000

    // TEST de GE (>=) ie N=V con N="negativo" y V="overflow"

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
// NOTE: TEST = "ADDS" - "ADDS" - "ADDS" - "ADDS" - "ADDS" - NOTE:
// --------------------------------------------------------------------
    ADD x20, x0, x0 // Inicializa iterador de memoria
    ADD x21, x0, #1 // Inicializa iterador del mensaje de exito
    ADD x22, x0, #-1 // Inicializa iterador del mensaje de fallo
// 1 --------------------------------------------------------------------
    // Test de B.GE // caso de salto (N=0, V=0)
    ADD X29, X1, X2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADDS X28, X29, X29      // x28=3+3=6 => N=0, V=0 

    B.GE t1_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFF (si falla) else 0x0
t1_GE:
    STUR X21, [x20, #8]     // MEM: 0x1
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 2 --------------------------------------------------------------------
// Test de B.GE // caso salto (N=0, V=0)
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADDS X28, X29, X1       // X28=-1+1=0 => N=0, V=0

    B.GE t2_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFE (si falla) else 0x0
t2_GE:
    STUR X21, [x20, #8]     // MEM: 0x2
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 3 --------------------------------------------------------------------
    // Test de B.GE // caso de no salto (N=1, V=0)
    SUB X29, X0, X2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADDS X28, X29, X1       // X28=-2+1=-1 => N=1, V=0

    B.GE t3_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x3
    CBZ XZR, t3_GE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t3_GE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFD (si falla) else 0x0
t3_GE_end:
// --------------------------------------------------------------------


// --------------------------------------------------------------------
// NOTE: TEST = "ADDIS" - "ADDIS" - "ADDIS" - "ADDIS" - "ADDIS" NOTE:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 4 -------------------------------------------------------------------
    // Test de B.GE // caso de salto (N=0, V=0)
    ADD X29, X1, X2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADDS X28, X29, #3      // x28=3+3=6 => N=0, V=0 

    B.GE t4_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFC (si falla) else 0x0
t4_GE:
    STUR X21, [x20, #8]     // MEM: 0x4
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 5 --------------------------------------------------------------------
// Test de B.GE // caso salto (N=0, V=0)
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADDS X28, X29, #1       // X28=-1+1=0 => N=0, V=0

    B.GE t5_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFB (si falla) else 0x0
t5_GE:
    STUR X21, [x20, #8]     // MEM: 0x5
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 6 --------------------------------------------------------------------
    // Test de B.GE // caso de no salto (N=1, V=0)
    SUB X29, X0, X2 // = -2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADDS X28, X29, #1       // X28=-2+1=-1 => N=1, V=0

    B.GE t6_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x6
    CBZ XZR, t6_GE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t6_GE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFFA (si falla) else 0x0
t6_GE_end:
// --------------------------------------------------------------------


// --------------------------------------------------------------------
// NOTE: TEST = "SUBS" - "SUBS" - "SUBS" - "SUBS" - "SUBS" - NOTE:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 7 -------------------------------------------------------------------
    // Test de B.GE // caso de salto (N=0, V=0)
    ADD X29, X1, X2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X29      // x28=3-3=0 => N=0, V=0 

    B.GE t7_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF9 (si falla) else 0x0
t7_GE:
    STUR X21, [x20, #8]     // MEM: 0x7
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 8 --------------------------------------------------------------------
// Test de B.GE // caso no salto (N=1, V=0)
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X1       // X28=-1-1=-2 => N=1, V=0 -> -1 >= 1 = false

    B.GE t8_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x21, [x20, #8]     // MEM: 0x8
    CBZ XZR, t8_GE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t8_GE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF8 (si falla) else 0x0
t8_GE_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 9 --------------------------------------------------------------------
    // Test de B.GE // caso de no salto
    ADD X29, X1, X2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X1, X29      // x28=1-3=-2 => 1 >= 3 = false

    B.GE t9_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x21, [x20, #8]     // MEM: 0x9
    CBZ XZR, t9_GE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t9_GE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF7 (si falla) else 0x0
t9_GE_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 10 --------------------------------------------------------------------
    // Test de B.GE // caso de no salto
    SUB X29, X0, X4
    SUB X28, X0, X3
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X28      // x28=-4-3=-7 => -4 >= -3 = false

    B.GE t10_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x21, [x20, #8]     // MEM: 0xA
    CBZ XZR, t10_GE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t10_GE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF6 (si falla) else 0x0
t10_GE_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 11 --------------------------------------------------------------------
    // Test de B.GE // caso de salto
    SUB X29, X0, X4
    SUB X28, X0, X3
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X28, x29      // x28=-3-(-4)=1 => -3 >= -4 = true

    B.GE t11_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF5 (si falla) else 0x0
t11_GE:
    STUR X21, [x20, #8]     // MEM: 0xB
// --------------------------------------------------------------------

// --------------------------------------------------------------------
// NOTE: TEST = "SUBIS" - "SUBIS" - "SUBIS" - "SUBIS" - "SUBIS" NOTE:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 12 -------------------------------------------------------------------
    // Test de B.GE // caso de salto (N=0, V=0)
    ADD X29, X1, X2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, #3      // x28=3-3=0 => N=0, V=0 

    B.GE t12_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF4 (si falla) else 0x0
t12_GE:
    STUR X21, [x20, #8]     // MEM: 0xC
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 13 --------------------------------------------------------------------
// Test de B.GE // caso no salto (N=1, V=0)
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, #1       // X28=-1-1=-2 => N=1, V=0 -> -1 >= 1 = false

    B.GE t13_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x21, [x20, #8]     // MEM: 0xD
    CBZ XZR, t13_GE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t13_GE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF3 (si falla) else 0x0
t13_GE_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 14 --------------------------------------------------------------------
    // Test de B.GE // caso de no salto
    SUBS X28, X1, #3      // x28=1-3=-2 => 1 >= 3 = false

    B.GE t14_GE                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x21, [x20, #8]     // MEM: 0xE
    CBZ XZR, t14_GE_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t14_GE:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF2 (si falla) else 0x0
t14_GE_end:
// --------------------------------------------------------------------

endloop:
    CBZ XZR, endloop
