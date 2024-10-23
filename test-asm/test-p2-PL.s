.text
.org 0x0000
//--------------NOTE:--------------\\   
    //5'b00101: B_cond_is = (negative === 0); //B.PL verifica que un número sea >= 0
    // registos reservados
    // X30 = mensajes
    // X29 = auxiliar
    // X28 = resultado auxiliar
    // X0 = 0
    // X1 = 1
    // X2 = 2

// Probar con SUBS, ADDS, SUBIS, ADDIS

// caso SUBS X28 > 0    B.PL: N=0   Números positivos
 
            SUBS X28, X3, X2    //--------> [X28] = 3 - 2 = 1 
            B.PL pl_1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si falla MEM: 0xFFFFFFFFFFFFFFFF = -1
            CBZ XZR, pl_end_1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_1:
            ADD X30, X0, #1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #0] // Si anda MEM: 0x1
        pl_end_1:


//-----------------------------------------------------------------------\\    

// caso SUBS X28 = 0    B.PL: N=0

            SUBS X28, X3, X3    //--------> [X28] = 3 - 3 = 0
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si falla MEM: 0xFFFFFFFFFFFFFFFE = -2
            CBZ XZR, pl_end_2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_2:
            ADD X30, X0, #2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si anda MEM: 0x2
        pl_end_2:

//-----------------------------------------------------------------------\\  

// caso SUBS X28 < 0    B.PL: N=0
            SUBS X28, X2, X3    //--------> [X28] = 2 - 3 = -1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si anda MEM: 0x3
            CBZ XZR, pl_end_3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_3:
            SUB X30, X0, #3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si falla MEM: 0xFFFFFFFFFFFFFFFD = -3
        pl_end_3:

//-----------------------------------------------------------------------\\


// caso SUBS X28 < 0    B.PL: N=0
            SUB X29, XZR, X2
            ADD XZR, XZR, XZR
            ADD XZR, XZR, XZR
            SUBS X28, X29, X3    //--------> [X28] = -2 - 3 = -5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_4
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #4
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #24] // Si anda MEM: 0x4
            CBZ XZR, pl_end_4
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_4:
            SUB X30, X0, #4
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #24] // Si falla MEM: 0xFFFFFFFFFFFFFFFC = -4
        pl_end_4:

//-----------------------------------------------------------------------\\
