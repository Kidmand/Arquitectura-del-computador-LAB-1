    .text
    .org 0x0000

    ADD x9, x30, x30 
    ADD x9, x9, x4
    ADD x10, xzr, xzr
    ADD X11, xzr, xzr

loop:
    STUR x11, [x10]
    ADD x10, x10, x8
    ADD x11, x11, x1
    SUB x9, x9, x1
    CBZ  x9, finloop 
    CBZ  xzr, loop

finloop: CBZ XZR, finloop
