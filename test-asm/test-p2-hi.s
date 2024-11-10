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

    // [x] caso ADDIS de    salto B.HI:  (Z=0 & C=1)  unsigned   ID = 1
    // [x] caso ADDIS de no salto B.HI:  (Z=1 & C=1)  unsigned   ID = 2
    // [x] caso ADDIS de no salto B.HI:  (Z=0 & C=0)  unsigned   ID = 3

// ----------------------------HI----------------------------
    // caso ADDIS de    salto B.HI:  (Z=0 & C=1)  unsigned   ID = 1
            SUB X29, X1, X2 // X29 = -1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, #-2 // => Z=0, C=1

            B.HI t1_HI
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si falla MEM: 0xFFFFFFFFFFFFFFFF
            CBZ XZR, t1_HI_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t1_HI:
            ADD X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si anda MEM: 0x1
        t1_HI_end:
    
    // --------------------------------------------------------
    // caso ADDIS de no salto B.HI:  (Z=0 & C=1)  unsigned   ID = 2
            SUB X29, X1, X2 // X29 = -1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, #1 // => Z=1, C=1

            B.HI t2_HI
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si anda MEM: 0x2
            CBZ XZR, t2_HI_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t2_HI:    
            ADD X30, X0, #-2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si falla MEM: 0xFFFFFFFFFFFFFFFE
        t2_HI_end:

    // --------------------------------------------------------
    // caso ADDIS de no salto B.HI:  (Z=0 & C=0)  unsigned   ID = 3
            SUB X29, X1, X2 // X29 = -1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, X29 // => Z=0, C=0

            B.HI t3_HI
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si anda MEM: 0x3
            CBZ XZR, t3_HI_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t3_HI:    
            ADD X30, X0, #-3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si falla MEM: 0xFFFFFFFFFFFFFFFD
        t3_HI_end:

endloop:
    CBZ XZR, endloop

/*
Salida en memdump:
Memoria RAM de Arm:
Address Data
0 0000000000000001
1 0000000000000002
2 0000000000000003
3 0000000000000000
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
Finalizado para archivo: test-p2-hi.s
===============================================
*/
