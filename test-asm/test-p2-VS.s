.text
.org 0x0000
// Probar con SUBS, ADDS, SUBIS, ADDIS

    .data
    .align 3              ; Alinear a 8 bytes
max_value: .word 2147483647  ; 2^31 - 1
//--------------NOTE:--------------\\   
    //5'b00101: B_cond_is = (negative === 0); //B.PL verifica que un número sea >= 0
    // registos reservados
    // X30 = mensajes
    // X29 = auxiliar
    // X28 = resultado auxiliar
    // X0 = 0
    // X1 = 1
    // X2 = 2


// caso SUBS X28 > 0    B.VS: V=1   Números Negativos
            LDUR X0, [0x1000]      ; Cargar el valor de max_value en X1
            SUB X29, XZR, X1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X0, X0    //--------> [X28] = -1 - 1 = tendría que dar -2 pero da 0. Debido al overflow
            B.VS vs_1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si falla MEM: 0xFFFFFFFFFFFFFFFF = -1
            CBZ XZR, vs_end_1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        vs_1:
            ADD X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si anda MEM: 0x1
        vs_end_1:

