    .text
    .org 0x0000
    // Los tests pasan si las señales de N, Z, C, V en wave corresponden y
    // la posicion 0x0 de la memoria contiene 0xFFFFFFFFFFFFFFFF.
    // Los tests fallan si la posicion 0x0 de la memoria contiene el id del test que fallo.
    //                        
    // [x] caso de    salto signed   B.EQ: Z=1          id = 1
    // [x] caso de no salto signed   B.EQ: Z=1          id = 2
    // [x] caso de    salto unsigned B.EQ: Z=1          id = 3
    // [x] caso de no salto unsigned B.EQ: Z=1          id = 4

    // [x] caso de    salto signed   B.NE: Z=0          id = 5
    // [] caso de no salto signed   B.NE: Z=0          id = 6
    // [] caso de    salto unsigned B.NE: Z=0          id = 7
    // [] caso de no salto unsigned B.NE: Z=0          id = 8

    // [] caso de    salto signed   B.LT: N≠V          id = 9
    // [] caso de no salto signed   B.LT: N≠V          id = 10
    // [] caso de    salto unsigned B.LO: C=1          id = 11
    // [] caso de no salto unsigned B.LO: C=1          id = 12

    // [] caso de    salto signed   B.LE: Z=1 || N≠V   id = 13
    // [] caso de no salto signed   B.LE: Z=1 || N≠V   id = 14
    // [] caso de    salto unsigned B.LS: C=1 || Z=1   id = 15
    // [] caso de no salto unsigned B.LS: C=1 || Z=1   id = 16

    // [] caso de    salto signed   B.GT: Z=0 && N=V   id = 17
    // [] caso de no salto signed   B.GT: Z=0 && N=V   id = 18
    // [] caso de    salto unsigned B.HI: C=1 && Z=0   id = 19
    // [] caso de no salto unsigned B.HI: C=1 && Z=0   id = 20

    // [] caso de    salto signed   B.GE: N=V          id = 21
    // [] caso de no salto signed   B.GE: N=V          id = 22
    // [] caso de    salto unsigned B.HS: C=1          id = 23
    // [] caso de no salto unsigned B.HS: C=1          id = 24

    // registos reservados
    // X30 = id de test
    // X29 = auxiliar
    // X28 = resultado auxiliar
    // X0 = 0
    // X1 = 1
    // X2 = 2

// TODO: Probar con SUBS, ADDS, SUBIS, ADDIS

// ----------------------------------------------------------
// ----------------------------EQ----------------------------
    // Test de B.EQ signado // caso de salto
    ADD X30, X0, #1 // X30 = 1

    SUB X29, X1, X2    // X29 = 1-2 = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X29 // X28 = -1-(-1) = 0 => Z=1

    B.EQ signed_BEQ_pass
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR 
    CBZ XZR, instruction_fail
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR 
signed_BEQ_pass:
// --------------------------------------------------------
    // Test de B.EQ signado // caso de no salto
    ADD X30, X0, #2 // id = 2

    SUB X29, X0, X2    // X29 = 0-2 = -2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X1  // X28 = -2-1 = -3 => Z=0

    B.EQ instruction_fail
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR 
// --------------------------------------------------------
    // Test de B.EQ no signado // caso de salto
    ADD X30, X0, #3 // id = 3

    ADD X29, X1, X2    // X29 = 1+2 = 3
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X29 // X28 = 3-3 = 0 => Z=1

    B.EQ unsigned_BEQ_pass
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR 
    CBZ XZR, instruction_fail
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR 
unsigned_BEQ_pass:
// --------------------------------------------------------
    // Test de B.EQ no signado // caso de no salto
    ADD X30, X0, #4 // id = 4

    ADD X29, X1, X1    // X29 = 1+1 = 2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X1  // X28 = 2-1 = 1 => Z=0

    B.EQ instruction_fail
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR 

// --------------------------------------------------------
    ADD X30, X0, #-1 // X30 = 0xFFFFFFFFFFFFFFFF si pasan todos los EQ
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #8] // MEM: 0xFFFFFFFFFFFFFFFF 
// ----------------------------------------------------------

// ----------------------------NE----------------------------
    // Test de B.NE signado // caso de salto
    ADD X30, X0, #5 // id = 5

    SUB X29, X1, X2    // X29 = 1-2 = -1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    SUBS X28, X29, X1 // X28 = -1-1 = -2 => Z=0

    B.NE signed_BNE_pass
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR 
    CBZ XZR, instruction_fail
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR 
signed_BNE_pass:

// --------------------------------------------------------
    ADD X30, X0, #-2 // X30 = 0xFFFFFFFFFFFFFFFE si pasan todos los NE
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #16] // MEM: 0xFFFFFFFFFFFFFFFE
// ----------------------------------------------------------

endloop:
    CBZ XZR, endloop
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR

instruction_fail: // ARGs: X30 = id de test
    // Se escribe en memoria el id del test que fallo
    // en la direccion 0X0
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #0] // MEM[X0] = id
    CBZ XZR, endloop
