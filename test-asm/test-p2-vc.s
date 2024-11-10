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

    // [] caso SUBIS de    salto mayor positivo B.VC:  V=0  signed and unsigned   ID = 1
    // [] caso ADDIS de    salto mayor negativo B.VC:  V=0  signed and unsigned   ID = 2
    // [] caso SUBIS de no salto mayor positivo B.VC:  V=1  signed and unsigned   ID = 3
    // [] caso ADDIS de no salto mayor negativo B.VC:  V=1  signed and unsigned   ID = 4

// ----------------------------VC----------------------------
    // caso SUBIS de    salto mayor positivo B.VC:  V=0  signed and unsigned   ID = 1
            ADDS X28, X17, #0 // => V=0

            B.VS t1_VS
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si falla MEM: 0xFFFFFFFFFFFFFFFF
            CBZ XZR, t1_VS_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t1_VS:
            ADD X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si anda MEM: 0x1
        t1_VS_end:

    // --------------------------------------------------------
    // caso ADDIS de    salto mayor negativo B.VC:  V=0  signed and unsigned   ID = 2
            SUBS X28, X18, #0 // => V=0

            B.VS t2_VS
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #-2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si falla MEM: 0xFFFFFFFFFFFFFFFE
            CBZ XZR, t2_VS_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t2_VS:
            ADD X30, X0, #2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si anda MEM: 0x2
        t2_VS_end:

    // --------------------------------------------------------
    // caso SUBIS de no salto mayor positivo B.VC:  V=1  signed and unsigned   ID = 3
            ADDS X28, X17, #1 // => V=1

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

    // --------------------------------------------------------
    // caso SUBIS de no salto mayor negativo B.VC:  V=1  signed and unsigned   ID = 4
            SUBS X28, X18, #1 // => V=1

            B.HI t4_HI
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #4
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #24] // Si anda MEM: 0x4
            CBZ XZR, t4_HI_end
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        t4_HI:    
            ADD X30, X0, #-4
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #24] // Si falla MEM: 0xFFFFFFFFFFFFFFFC
        t4_HI_end:
endloop:
    CBZ XZR, endloop

