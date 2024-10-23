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

// caso ADDS X28 > 0    B.PL: N=0   Números positivos
 
            ADDS X28, X3, X2    //--------> [X28] = 3 + 2 = 5
            B.PL pl_5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #32] // Si falla MEM: 0xFFFFFFFFFFFFFFFB = -5
            CBZ XZR, pl_end_5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_5:
            ADD X30, X0, #5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #32] // Si anda MEM: 0x5
        pl_end_5:


//-----------------------------------------------------------------------\\ 

// caso ADDS X28 < 0    B.PL: N=0   Números negativos
            SUB X29, XZR, X2
            SUB X28, XZR, X3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, X28    //--------> [X28] = -3 + (-2) = -5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_6
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #6
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #40] // Si anda MEM: 0x6
            CBZ XZR, pl_end_6
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_6:
            SUB X30, X0, #6
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #40] // Si falla MEM: 0xFFFFFFFFFFFFFFFA = -6
        pl_end_6:


//-----------------------------------------------------------------------\\ 

// caso ADDS X28 = 0    B.PL: N=0 
            SUB X29, XZR, X3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X9, X3    //--------> [X28] = -3 + 3 = 0
            B.PL pl_7
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #7
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #48] // Si falla MEM: 0xFFFFFFFFFFFFFFF9 = -7
            CBZ XZR, pl_end_7
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_7:
            ADD X30, X0, #7
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #48] // Si anda MEM: 0x7
        pl_end_7:

//-----------------------------------------------------------------------\\

// caso ADDS X28 < 0    B.PL: N=0 

            SUB X29, XZR, X5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, X3    //--------> [X28] = -5 + 3 = -2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_8
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #8
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #56] // Si anda MEM: 0x8
            CBZ XZR, pl_end_8
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_8:
            SUB X30, X0, #8
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #56] // Si falla MEM: 0xFFFFFFFFFFFFFFF8 = -8
        pl_end_8:
//-----------------------------------------------------------------------\\

// caso ADDS X28 > 0    B.PL: N=0 
            SUB X29, XZR, X3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X9, X4    //--------> [X28] = -3 + 4 = 1
            B.PL pl_9
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #9
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #64] // Si falla MEM: 0xFFFFFFFFFFFFFFF7 = -9
            CBZ XZR, pl_end_9
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_9:
            ADD X30, X0, #9
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #64] // Si anda MEM: 0x9
        pl_end_9:
