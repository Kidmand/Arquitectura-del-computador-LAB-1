.text
.org 0x0000
// Probar con SUBS, ADDS, SUBIS, ADDIS

//--------------NOTE:--------------\\   
    //5'b00101: B_cond_is = (negative === 0); //B.PL verifica que un número sea >= 0
    // registos reservados
    // X30 = mensajes
    // X29 = auxiliar
    // X28 = resultado auxiliar
    // X0 = 0
    // X1 = 1
    // X2 = 2
 // LS = ~((zero === 0) && carry); 

// caso SUBS X28 = 0    B.LS = ~((zero === 0) && carry);
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X1, X1    //--------> [X28] = 1 - 1 = 0
            B.LS ls_1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si falla MEM: 0xFFFFFFFFFFFFFFFF = -1
            CBZ XZR, ls_end_1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        ls_1:
            ADD X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si anda MEM: 0x1
        ls_end_1:

//-----------------------------------------------------------------------\\    

// caso SUBS X28 > 0    B.LS = ~((zero === 0) && carry);
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUBS X28, X4, X5    //--------> [X28] = 4 - 5 = -1
            B.LS ls_2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si falla MEM: 0xFFFFFFFFFFFFFFFE = -2
            CBZ XZR, ls_end_1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        ls_2:
            ADD X30, X0, #2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si anda MEM: 0x2
        ls_end_2:

//-----------------------------------------------------------------------\\  