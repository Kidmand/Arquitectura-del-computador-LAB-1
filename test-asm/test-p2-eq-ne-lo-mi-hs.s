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

    // [x] caso SUBS de    salto signed    B.EQ: Z=1 ID = 1
    // [x] caso SUBS de no salto signed    B.EQ: Z=1 ID = 2
    // [x] caso SUBS de    salto unsigned  B.EQ: Z=1 ID = 3
    // [x] caso SUBS de no salto unsigned  B.EQ: Z=1 ID = 4

    // [x] caso SUBIS de    salto signed   B.EQ: Z=1 ID = 5
    // [x] caso SUBIS de no salto signed   B.EQ: Z=1 ID = 6
    // [x] caso SUBIS de    salto unsigned B.EQ: Z=1 ID = 7
    // [x] caso SUBIS de no salto unsigned B.EQ: Z=1 ID = 8

    // [x] caso ADDS de     salto 0        B.EQ: Z=1  ID = 9
    // [x] caso ADDS de  no salto no 0     B.EQ: Z=1  ID = A

    // [x] caso ADDIS de    salto 0        B.EQ: Z=1 ID = B
    // [x] caso ADDIS de no salto no 0     B.EQ: Z=1 ID = C

    // [x] caso SUBS de    salto signed    B.NE: Z=0  ID = D
    // [x] caso SUBS de no salto signed    B.NE: Z=0  ID = E

    // [x] caso ADDS de    salto unsigned  B.LO: C=0  ID = F
    // [x] caso ADDS de no salto unsigned  B.LO: C=0  ID = 10

    // [x] caso ADDIS de    salto unsigned  B.HS: C=1  ID = 11
    // [x] caso ADDIS de no salto unsigned  B.HS: C=1  ID = 12

    // [x] caso SUBIS de    salto signed and unsigned    B.MI: N=1  ID = 13
    // [x] caso SUBIS de no salto signed and unsigned    B.MI: N=1  ID = 14

// ----------------------------EQ----------------------------
    // caso SUBS de    salto signed    B.EQ: Z=1  ID = 1
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
            STUR X30, [X0, #0] // Si falla MEM: 0xFFFFFFFFFFFFFFFF
            CBZ XZR, t1_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t1_EQ:
            ADD X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si anda MEM: 0x1
        t1_EQ_end:
    
    // --------------------------------------------------------
    // caso SUBS de no salto signed    B.EQ: Z=1 ID = 2
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
            STUR X30, [X0, #8] // Si anda MEM: 0x2
            CBZ XZR, t2_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t2_EQ:    
            ADD X30, X0, #-2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si falla MEM: 0xFFFFFFFFFFFFFFFE
        t2_EQ_end:
    // --------------------------------------------------------
    // caso SUBS de    salto unsigned  B.EQ: Z=1 ID = 3
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
            STUR X30, [X0, #16] // Si falla MEM: 0xFFFFFFFFFFFFFFFD
            CBZ XZR, t3_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t3_EQ:
            ADD X30, X0, #3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si anda MEM: 0x3
        t3_EQ_end:
    // --------------------------------------------------------
    // caso SUBS de no salto unsigned  B.EQ: Z=1 ID = 4
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
            STUR X30, [X0, #24] // Si anda MEM: 0x4
            CBZ XZR, t4_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t4_EQ:
            ADD X30, X0, #-4
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #24] // Si falla MEM: 0xFFFFFFFFFFFFFFFC
        t4_EQ_end:
    // --------------------------------------------------------
    // caso SUBIS de    salto signed    B.EQ: Z=1  ID = 5
            SUB X29, X1, X2 // X29 = -1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, #-1 // => Z=1

            B.EQ t5_EQ
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #32] // Si falla MEM: 0xFFFFFFFFFFFFFFFB
            CBZ XZR, t5_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t5_EQ:
            ADD X30, X0, #5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #32] // Si anda MEM: 0x5
        t5_EQ_end:
    
    // --------------------------------------------------------
    // caso SUBIS de no salto signed    B.EQ: Z=1 ID = 6
            SUB X29, X0, X2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, #1  // => Z=0

            B.EQ t6_EQ
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #6
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #40] // Si anda MEM: 0x6
            CBZ XZR, t6_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t6_EQ:    
            ADD X30, X0, #-6
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #40] // Si falla MEM: 0xFFFFFFFFFFFFFFFA
        t6_EQ_end:
    // --------------------------------------------------------
    // caso SUBIS de    salto unsigned  B.EQ: Z=1 ID = 7
            ADD X29, X1, X2 // X29 = 3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, #3 // => Z=1

            B.EQ t7_EQ
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-7
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #48] // Si falla MEM: 0xFFFFFFFFFFFFFFF9
            CBZ XZR, t7_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t7_EQ:
            ADD X30, X0, #7
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #48] // Si anda MEM: 0x7
        t7_EQ_end:
    // --------------------------------------------------------
    // caso SUBIS de no salto unsigned  B.EQ: Z=1 ID = 8
            ADD X29, X1, X1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, #1  // => Z=0

            B.EQ t8_EQ
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #8
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #56] // Si anda MEM: 0x8
            CBZ XZR, t8_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t8_EQ:
            ADD X30, X0, #-8
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #56] // Si falla MEM: 0xFFFFFFFFFFFFFFF8
        t8_EQ_end:

    // caso ADDS de     salto 0        B.EQ: Z=1  ID = 9
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, XZR, XZR // => Z=1

            B.EQ t9_EQ
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-9
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #64] // Si falla MEM: 0xFFFFFFFFFFFFFFF7
            CBZ XZR, t9_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t9_EQ:
            ADD X30, X0, #9
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #64] // Si anda MEM: 0x9
        t9_EQ_end:
    // caso ADDS de  no salto no 0     B.EQ: Z=1  ID = A
            ADD X29, X1, X1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, X29  // => Z=0

            B.EQ tA_EQ
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #10
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #72] // Si anda MEM: 0xA
            CBZ XZR, tA_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        tA_EQ:
            ADD X30, X0, #-10
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #72] // Si falla MEM: 0xFFFFFFFFFFFFFFF6
        tA_EQ_end:

    // caso ADDIS de    salto 0        B.EQ: Z=1 ID = B
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X0, #0 // => Z=1

            B.EQ tB_EQ
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-11
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #80] // Si falla MEM: 0xFFFFFFFFFFFFFFF5
            CBZ XZR, tB_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        tB_EQ:
            ADD X30, X0, #11
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #80] // Si anda MEM: 0xB
        tB_EQ_end:
    // caso ADDIS de no salto no 0     B.EQ: Z=1 ID = C
            ADD X29, X1, X1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, #2  // => Z=0

            B.EQ tC_EQ
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #12
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #88] // Si anda MEM: 0xC
            CBZ XZR, tC_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        tC_EQ:
            ADD X30, X0, #-12
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #88] // Si falla MEM: 0xFFFFFFFFFFFFFFF4
        tC_EQ_end:

// ------------------------ NE ------------------------
    // caso SUBS de    salto signed    B.NE: Z=0  ID = D
            SUB X29, X1, X2 // X29 = -1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, X1 // => Z=0

            B.NE tD_NE
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-13
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #96] // Si falla MEM: 0xFFFFFFFFFFFFFFF3
            CBZ XZR, tD_NE_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        tD_NE:
            ADD X30, X0, #13
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #96] // Si anda MEM: 0xD
        tD_NE_end:

    // caso SUBS de no salto signed    B.NE: Z=0  ID = E
            SUB X29, X0, X2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, X29  // => Z=1

            B.NE tE_NE
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #14
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #104] // Si anda MEM: 0xE 
            CBZ XZR, tE_NE_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        tE_NE:
            ADD X30, X0, #-14
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #104] // Si falla MEM: 0xFFFFFFFFFFFFFFF2
        tE_NE_end:

// ------------------------ LO ------------------------
    // caso ADDS de    salto unsigned  B.LO: C=0  ID = F
            SUB X29, XZR, X2 // X29 = 0xFFFFFFFFFFFFFFFE
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, X1 // => C=0

            B.LO tF_LO
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-15
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #112] // Si falla MEM: 0xFFFFFFFFFFFFFFF1
            CBZ XZR, tF_LO_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        tF_LO:
            ADD X30, X0, #15
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #112] // Si anda MEM: 0xF
        tF_LO_end:

    // caso ADDS de no salto unsigned  B.LO: C=0  ID = 10
            SUB X29, X1, X2 // X29 = 0xFFFFFFFFFFFFFFFF
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, X1 // => C=1

            B.LO t10_LO
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #16
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #120] // Si anda MEM: 0x10
            CBZ XZR, t10_LO_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t10_LO:
            ADD X30, X0, #-16
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #120] // Si falla MEM: 0xFFFFFFFFFFFFFFF0
        t10_LO_end:

// ------------------------ HS ------------------------
    // caso ADDIS de    salto unsigned  B.HS: C=1  ID = 11
            SUB X29, X1, X2 // X29 = 0xFFFFFFFFFFFFFFFF
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, #1 // => C=1

            B.HS t11_HS
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-17
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #128] // Si falla MEM: 0xFFFFFFFFFFFFFFEF
            CBZ XZR, t11_HS_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t11_HS:
            ADD X30, X0, #17
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #128] // Si anda MEM: 0x11
        t11_HS_end:

    // caso ADDIS de no salto unsigned  B.HS: C=1  ID = 12
            SUB X29, XZR, X2 // X29 = 0xFFFFFFFFFFFFFFFE
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, #1 // => C=0

            B.HS t12_HS
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #18
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #136] // Si anda MEM: 0x12
            CBZ XZR, t12_HS_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t12_HS:
            ADD X30, X0, #-18
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #136] // Si falla MEM: 0xFFFFFFFFFFFFFFEE
        t12_HS_end:

// ------------------------ MI ------------------------
    // caso SUBIS de    salto signed and unsigned    B.MI: N=1  ID = 13
            ADD X29, XZR, X2 // X29 = 2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, #3 // => N=1

            B.MI t13_MI
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-19
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #144] // Si falla MEM: 0xFFFFFFFFFFFFFFED
            CBZ XZR, t13_MI_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t13_MI:
            ADD X30, X0, #19
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #144] // Si anda MEM: 0x13
        t13_MI_end:

    // caso SUBIS de no salto signed and unsigned    B.MI: N=1  ID = 14
            ADD X29, X1, X2 // X29 = 3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X29, #1 // => N=0

            B.MI t14_MI
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #20
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #152] // Si anda MEM: 0x14
            CBZ XZR, t14_MI_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t14_MI:
            ADD X30, X0, #-20
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #152] // Si falla MEM: 0xFFFFFFFFFFFFFFEC
        t14_MI_end:

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
4 0000000000000005
5 0000000000000006
6 0000000000000007
7 0000000000000008
8 0000000000000009
9 000000000000000A
10 000000000000000B
11 000000000000000C
12 000000000000000D
13 000000000000000E
14 000000000000000F
15 0000000000000010
16 0000000000000011
17 0000000000000012
18 0000000000000013
19 0000000000000014
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
Finalizado para archivo: test-p2-eq-ne-lo-mi-hs.s
===============================================
*/
