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

    // [] caso SUBIS de    salto signed   B.EQ: Z=1 ID = 5
    // [] caso SUBIS de no salto signed   B.EQ: Z=1 ID = 6
    // [] caso SUBIS de    salto unsigned B.EQ: Z=1 ID = 7
    // [] caso SUBIS de no salto unsigned B.EQ: Z=1 ID = 8

    // [] caso ADDS de    salto signed   B.EQ: Z=1  ID = 9
    // [] caso ADDS de no salto signed   B.EQ: Z=1  ID = 10
    // [] caso ADDS de    salto unsigned B.EQ: Z=1  ID = 11
    // [] caso ADDS de no salto unsigned B.EQ: Z=1  ID = 12

    // [] caso ADDIS de    salto signed   B.EQ: Z=1 ID = 13
    // [] caso ADDIS de no salto signed   B.EQ: Z=1 ID = 14
    // [] caso ADDIS de    salto unsigned B.EQ: Z=1 ID = 15
    // [] caso ADDIS de no salto unsigned B.EQ: Z=1 ID = 16
    
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
        t1_EQ:
            ADD X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si anda MEM: 0x1
    
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
        t3_EQ:
            ADD X30, X0, #3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si anda MEM: 0x3
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
            STUR X30, [X0, #32] // Si falla MEM: 0xFFFFFFFFFFFFFFFF
        t5_EQ:
            ADD X30, X0, #5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #32] // Si anda MEM: 0x1
    
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
            STUR X30, [X0, #40] // Si anda MEM: 0x2
            CBZ XZR, t6_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t6_EQ:    
            ADD X30, X0, #-6
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #40] // Si falla MEM: 0xFFFFFFFFFFFFFFFE
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
            STUR X30, [X0, #48] // Si falla MEM: 0xFFFFFFFFFFFFFFFD
        t7_EQ:
            ADD X30, X0, #7
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #48] // Si anda MEM: 0x3
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
            STUR X30, [X0, #56] // Si anda MEM: 0x4
            CBZ XZR, t8_EQ_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t8_EQ:
            ADD X30, X0, #-8
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #56] // Si falla MEM: 0xFFFFFFFFFFFFFFFC
        t8_EQ_end:

    // caso ADDS de    salto signed   B.EQ: Z=1  ID = 9
    // caso ADDS de no salto signed   B.EQ: Z=1  ID = 10
    // caso ADDS de    salto unsigned B.EQ: Z=1  ID = 11
    // caso ADDS de no salto unsigned B.EQ: Z=1  ID = 12

    // caso ADDIS de    salto signed   B.EQ: Z=1 ID = 13
    // caso ADDIS de no salto signed   B.EQ: Z=1 ID = 14
    // caso ADDIS de    salto unsigned B.EQ: Z=1 ID = 15
    // caso ADDIS de no salto unsigned B.EQ: Z=1 ID = 16

// ------------------------ NE ------------------------
    // [x] caso SUBS de    salto signed    B.NE: Z=0  ID = 17
    // [] caso SUBS de no salto signed    B.NE: Z=0  ID = 18
    // [] caso SUBS de    salto unsigned  B.NE: Z=0  ID = 19
    // [] caso SUBS de no salto unsigned  B.NE: Z=0  ID = 20

    // [] caso SUBIS de    salto signed    B.NE: Z=0 ID = 21
    // [] caso SUBIS de no salto signed    B.NE: Z=0 ID = 22
    // [] caso SUBIS de    salto unsigned  B.NE: Z=0 ID = 23
    // [] caso SUBIS de no salto unsigned  B.NE: Z=0 ID = 24

    // [] caso ADDS de    salto signed    B.NE: Z=0  ID = 25
    // [] caso ADDS de no salto signed    B.NE: Z=0  ID = 26
    // [] caso ADDS de    salto unsigned  B.NE: Z=0  ID = 27
    // [] caso ADDS de no salto unsigned  B.NE: Z=0  ID = 28

    // [] caso ADDIS de    salto signed    B.NE: Z=0 ID = 29
    // [] caso ADDIS de no salto signed    B.NE: Z=0 ID = 30
    // [] caso ADDIS de    salto unsigned  B.NE: Z=0 ID = 31
    // [] caso ADDIS de no salto unsigned  B.NE: Z=0 ID = 32

// ------------------------ LO ------------------------
    // [] caso SUBS de    salto unsigned  B.LO: C=1  ID = 33
    // [] caso SUBS de no salto unsigned  B.LO: C=1  ID = 34

    // [] caso SUBIS de    salto unsigned  B.LO: C=1 ID = 35
    // [] caso SUBIS de no salto unsigned  B.LO: C=1 ID = 36

    // [] caso ADDS de    salto unsigned  B.LO: C=1  ID = 37 
    // [] caso ADDS de no salto unsigned  B.LO: C=1  ID = 38

    // [] caso ADDIS de    salto unsigned  B.LO: C=1 ID = 39
    // [] caso ADDIS de no salto unsigned  B.LO: C=1 ID = 40

// ------------------------ HS ------------------------
    // [] caso SUBS de    salto unsigned  B.HS: C=1  ID = 41
    // [] caso SUBS de no salto unsigned  B.HS: C=1  ID = 42

    // [] caso SUBIS de    salto unsigned  B.HS: C=1 ID = 43
    // [] caso SUBIS de no salto unsigned  B.HS: C=1 ID = 44

    // [] caso ADDS de    salto unsigned  B.HS: C=1  ID = 45
    // [] caso ADDS de no salto unsigned  B.HS: C=1  ID = 46

    // [] caso ADDIS de    salto unsigned  B.HS: C=1 ID = 47
    // [] caso ADDIS de no salto unsigned  B.HS: C=1 ID = 48

// ------------------------ MI ------------------------
    // [] caso SUBS de    salto signed    B.MI: N=1  ID = 49
    // [] caso SUBS de no salto signed    B.MI: N=1  ID = 50

    // [] caso SUBIS de    salto signed    B.MI: N=1 ID = 51
    // [] caso SUBIS de no salto signed    B.MI: N=1 ID = 52

    // [] caso ADDS de    salto signed    B.MI: N=1  ID = 53
    // [] caso ADDS de no salto signed    B.MI: N=1  ID = 54

    // [] caso ADDIS de    salto signed    B.MI: N=1 ID = 55
    // [] caso ADDIS de no salto signed    B.MI: N=1 ID = 56

endloop:
    CBZ XZR, endloop

