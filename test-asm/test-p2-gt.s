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
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 7 ------------------------------------------------------------------
    // Test de B.GT
    SUB X29, X1, X2 // = -1
    SUB X28, X1, X3 // = -2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X28 // -1 > -2 (true)

    B.GT t7_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF9 (si falla) else 0x0
t7_GT:
    STUR X21, [x20, #8]     // MEM: 0x7
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 8 ------------------------------------------------------------------
    // Test de B.GT
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, #-2 // -1 > -2 (true)

    B.GT t8_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF8 (si falla) else 0x0
t8_GT:
    STUR X21, [x20, #8]     // MEM: 0x8
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 9 --------------------------------------------------------------------
    // Test de B.GT
    SUB X29, X1, X2 // = -1
    SUB X28, X1, X3 // = -2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X28, X29 // -2 > -1 (false)

    B.GT t9_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0x9
    CBZ XZR, t9_GT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t9_GT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF7 (si falla) else 0x0
t9_GT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 10 --------------------------------------------------------------------
    // Test de B.GT
    SUB X29, X1, X3 // = -2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, #-1 // -2 > -1 (false)

    B.GT t10_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0xA
    CBZ XZR, t10_GT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t10_GT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF6 (si falla) else 0x0
t10_GT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 11 --------------------------------------------------------------------
    // Test de B.GT // caso de salto
    SUBS X28, X4, XZR      // x28= 4 - 0 => 4 > 0 => true

    B.GT t11_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF5 (si falla) else 0x0
t11_GT:
    STUR X21, [x20, #8]     // MEM: 0xB
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 12 --------------------------------------------------------------------
    // Test de B.GT // caso de no salto
     SUBS X28, XZR, X4      // x28= 0 - 4 => 0 > 4 => false

    B.GT t12_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x21, [x20, #8]     // MEM: 0xC
    CBZ XZR, t12_GT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t12_GT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF4 (si falla) else 0x0
t12_GT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 13 --------------------------------------------------------------------
    // Test de B.GT // caso de no salto
     SUBS X28, XZR, XZR      // x28= 0 - 0 => 0 > 0 => false

    B.GT t13_GT                
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR x21, [x20, #8]     // MEM: 0xD
    CBZ XZR, t13_GT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t13_GT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFFF3 (si falla) else 0x0
t13_GT_end:
// --------------------------------------------------------------------

endloop:
    CBZ XZR, endloop
/*
Salida en memdump:
Memoria RAM de Arm:
Address Data
0 0000000000000000
1 0000000000000001
2 0000000000000000
3 0000000000000002
4 0000000000000000
5 0000000000000003
6 0000000000000000
7 0000000000000004
8 0000000000000000
9 0000000000000005
10 0000000000000000
11 0000000000000006
12 0000000000000000
13 0000000000000007
14 0000000000000000
15 0000000000000008
16 0000000000000000
17 0000000000000009
18 0000000000000000
19 000000000000000A
20 0000000000000000
21 000000000000000B
22 0000000000000000
23 000000000000000C
24 0000000000000000
25 000000000000000D
26 0000000000000000
27 0000000000000000
28 0000000000000000
29 0000000000000000
30 0000000000000000
31 0000000000000000
32 0000000000000000
33 0000000000000000
34 0000000000000000
35 0000000000000000
36 0000000000000000
37 0000000000000000
38 0000000000000000
39 0000000000000000
40 0000000000000000
41 0000000000000000
42 0000000000000000
43 0000000000000000
44 0000000000000000
45 0000000000000000
46 0000000000000000
47 0000000000000000
48 0000000000000000
49 0000000000000000
50 0000000000000000
51 0000000000000000
52 0000000000000000
53 0000000000000000
54 0000000000000000
55 0000000000000000
56 0000000000000000
57 0000000000000000
58 0000000000000000
59 0000000000000000
60 0000000000000000
61 0000000000000000
62 0000000000000000
63 0000000000000000
Finalizado para archivo: test-p2-gt.s
===============================================
*/
