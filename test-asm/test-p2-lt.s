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
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 13 --------------------------------------------------------------------
    // Test de B.LT
    SUBS X28, XZR, X1     // 0 < 1 (true)

    B.LT t13_LT               
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF3 (si falla) else 0x0
t13_LT:
    STUR X21, [x20, #8]     // MEM: 0xD
t13_LT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 14 --------------------------------------------------------------------
    // Test de B.LT
    SUB X29, X1, X2 // = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, XZR, X29       // 0 < -1 (false)

    B.LT t14_LT              
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0xE
    CBZ XZR, t14_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t14_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF2 (si falla) else 0x0
t14_LT_end:
// --------------------------------------------------------------------
    ADD x20, x20, #16 // i += 16
    ADD x21, x21, #1
    SUB x22, x22, #1
// 15 --------------------------------------------------------------------
    // Test de B.LT
    SUBS X28, XZR, XZR       // 0 < 0 (false)

    B.LT t15_LT              
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [x20, #8]     // MEM: 0xF
    CBZ XZR, t15_LT_end
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
t15_LT:
    STUR X22, [x20, #0]     // MEM: 0xFFFFFFFFFFFFFF1 (si falla) else 0x0
t15_LT_end:
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
27 000000000000000E
28 0000000000000000
29 000000000000000F
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
Finalizado para archivo: test-p2-lt.s
===============================================
*/
