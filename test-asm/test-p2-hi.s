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

