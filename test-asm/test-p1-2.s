    .text
    .org 0x0000

    // Test de ADDI y SUBI
    ADD X1, X1, #1 //ADDI
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X1, [x0, #0] // MEM :0x2
    SUB X4, X4, #1 //SUBI
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X4, [x0, #8] // MEM :0X3
    ADD X5, X5, #0
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X5, [x0, #16] // MEM :0x5
    SUB X6, X6, #0
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X6, [x0, #24] // MEM :0x6
    ADD x7, x0, #-1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X7, [x0, #32] // MEM :FFFFFFFFFFFFFFF
    SUB x8, x0, #-1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X8, [x0, #40] // MEM :1
    ADD x9, x0, #1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X9, [x0, #48] // MEM :1
    SUB x10, x0, #1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X10, [x0, #56] // MEM :FFFFFFFFFFFFFFF
    ADD x11, x0, #0
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X11, [x0, #64] // MEM :0
    SUB x12, x0, #0
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X12, [x0, #72] // MEM :0
    ADD x13, x0, #1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X13, [x0, #80] // MEM :1
    

finloop: 
    CBZ XZR, finloop
