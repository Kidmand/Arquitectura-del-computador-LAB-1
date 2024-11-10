    .text
    .org 0x0000
    // Los tests pasan si las señales de ID, Z, C, V en wave corresponden y
    // sea T el ID-esimo test, entonces
    // MEM: < (ID-1)*8 > = 0x< ID > si pasa, else 0x< -ID >

    // registos reservados
    // X30 = mensajes
    // X29 = auxiliar
    // X28 = resultado auxiliar
    // X0 = 0
    // X1 = 1
    // X2 = 2
    // NOTE: X17 = 0x7FFFFFFFFFFFFFFF
    //       X18 = 0x8000000000000000

    // [x] caso SUBIS de    salto mayor positivo B.VC:  V=0  signed and unsigned   ID = 1
    // [x] caso ADDIS de    salto mayor negativo B.VC:  V=0  signed and unsigned   ID = 2
    // [x] caso SUBIS de no salto mayor positivo B.VC:  V=1  signed and unsigned   ID = 3
    // [x] caso ADDIS de no salto mayor negativo B.VC:  V=1  signed and unsigned   ID = 4

// ----------------------------VC----------------------------
    // caso SUBIS de    salto mayor positivo B.VC:  V=0  signed and unsigned   ID = 1
            ADDS X28, X17, #0 // => V=0

            B.VC t1_VC
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si falla MEM: 0xFFFFFFFFFFFFFFFF
            CBZ XZR, t1_VC_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t1_VC:
            ADD X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si anda MEM: 0x1
        t1_VC_end:

    // --------------------------------------------------------
    // caso ADDIS de    salto mayor negativo B.VC:  V=0  signed and unsigned   ID = 2
            SUBS X28, X18, #0 // => V=0

            B.VC t2_VC
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si falla MEM: 0xFFFFFFFFFFFFFFFE
            CBZ XZR, t2_VC_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t2_VC:
            ADD X30, X0, #2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si anda MEM: 0x2
        t2_VC_end:

    // --------------------------------------------------------
    // caso SUBIS de no salto mayor positivo B.VC:  V=1  signed and unsigned   ID = 3
            ADDS X28, X17, #1 // => V=1

            B.VC t3_VC
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si anda MEM: 0x3
            CBZ XZR, t3_VC_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t3_VC:    
            ADD X30, X0, #-3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si falla MEM: 0xFFFFFFFFFFFFFFFD
        t3_VC_end:

    // --------------------------------------------------------
    // caso SUBIS de no salto mayor negativo B.VC:  V=1  signed and unsigned   ID = 4
            SUBS X28, X18, #1 // => V=1

            B.VC t4_VC
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #4
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #24] // Si anda MEM: 0x4
            CBZ XZR, t4_VC_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t4_VC:    
            ADD X30, X0, #-4
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #24] // Si falla MEM: 0xFFFFFFFFFFFFFFFC
        t4_VC_end:
endloop:
    CBZ XZR, endloop

/*
Salida en memdump:
Memoria RAM de Arm:
Address Data
0 0000000000000001
1 0000000000000002
2 0000000000000003
3 0000000000000004
4 0000000000000000
5 0000000000000000
6 0000000000000000
7 0000000000000000
8 0000000000000000
9 0000000000000000
10 0000000000000000
11 0000000000000000
12 0000000000000000
13 0000000000000000
14 0000000000000000
15 0000000000000000
16 0000000000000000
17 0000000000000000
18 0000000000000000
19 0000000000000000
20 0000000000000000
21 0000000000000000
22 0000000000000000
23 0000000000000000
24 0000000000000000
25 0000000000000000
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
Finalizado para archivo: test-p2-vc.s
===============================================
*/
