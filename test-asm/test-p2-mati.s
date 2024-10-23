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

// ----------------------------EQ----------------------------
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

    // [] caso ADDIS de    salto 0        B.EQ: Z=1 ID = B
    // [] caso ADDIS de no salto no 0     B.EQ: Z=1 ID = C
    
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
    // caso SUBS de    salto signed    B.NE: Z=0  ID =
    // caso SUBS de no salto signed    B.NE: Z=0  ID =
    // caso SUBS de    salto unsigned  B.NE: Z=0  ID =
    // caso SUBS de no salto unsigned  B.NE: Z=0  ID =

    // caso SUBIS de    salto signed    B.NE: Z=0 ID =
    // caso SUBIS de no salto signed    B.NE: Z=0 ID =
    // caso SUBIS de    salto unsigned  B.NE: Z=0 ID =
    // caso SUBIS de no salto unsigned  B.NE: Z=0 ID =

    // caso ADDS de    salto signed    B.NE: Z=0  ID =
    // caso ADDS de no salto signed    B.NE: Z=0  ID =
    // caso ADDS de    salto unsigned  B.NE: Z=0  ID =
    // caso ADDS de no salto unsigned  B.NE: Z=0  ID =

    // caso ADDIS de    salto signed    B.NE: Z=0 ID =
    // caso ADDIS de no salto signed    B.NE: Z=0 ID =
    // caso ADDIS de    salto unsigned  B.NE: Z=0 ID =
    // caso ADDIS de no salto unsigned  B.NE: Z=0 ID =

// ------------------------ LO ------------------------
    // caso SUBS de    salto unsigned  B.LO: C=1  ID =
    // caso SUBS de no salto unsigned  B.LO: C=1  ID =

    // caso SUBIS de    salto unsigned  B.LO: C=1 ID =
    // caso SUBIS de no salto unsigned  B.LO: C=1 ID =

    // caso ADDS de    salto unsigned  B.LO: C=1  ID =
    // caso ADDS de no salto unsigned  B.LO: C=1  ID =

    // caso ADDIS de    salto unsigned  B.LO: C=1 ID =
    // caso ADDIS de no salto unsigned  B.LO: C=1 ID =

// ------------------------ HS ------------------------
    // caso SUBS de    salto unsigned  B.HS: C=1  ID =
    // caso SUBS de no salto unsigned  B.HS: C=1  ID =

    // caso SUBIS de    salto unsigned  B.HS: C=1 ID =
    // caso SUBIS de no salto unsigned  B.HS: C=1 ID =

    // caso ADDS de    salto unsigned  B.HS: C=1  ID =
    // caso ADDS de no salto unsigned  B.HS: C=1  ID =

    // caso ADDIS de    salto unsigned  B.HS: C=1 ID =
    // caso ADDIS de no salto unsigned  B.HS: C=1 ID =

// ------------------------ MI ------------------------
    // caso SUBS de    salto signed    B.MI: N=1  ID =
    // caso SUBS de no salto signed    B.MI: N=1  ID =

    // caso SUBIS de    salto signed    B.MI: N=1 ID =
    // caso SUBIS de no salto signed    B.MI: N=1 ID =

    // caso ADDS de    salto signed    B.MI: N=1  ID =
    // caso ADDS de no salto signed    B.MI: N=1  ID =

    // caso ADDIS de    salto signed    B.MI: N=1 ID =
    // caso ADDIS de no salto signed    B.MI: N=1 ID =

endloop:
    CBZ XZR, endloop

