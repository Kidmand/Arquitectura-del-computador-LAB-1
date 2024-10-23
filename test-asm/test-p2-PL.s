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

// caso SUBS X28 > 0    B.PL: N=0   Números positivos
 
            SUBS X28, X3, X2    //--------> [X28] = 3 - 2 = 1
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
            ADDS X28, X29, X3    //--------> [X28] = -3 + 3 = 0
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
            ADDS X28, X29, X4    //--------> [X28] = -3 + 4 = 1
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

//-----------------------------------------------------------------------\\

// caso ADDS X28 > 0    B.PL: N=0 
            ADDS X28, X3, X2    //--------> [X28] = 3 + 2 = 5
            B.PL pl_10
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #10
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #72] // Si falla MEM: 0xFFFFFFFFFFFFFFF6 = -10
            CBZ XZR, pl_end_10
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_10:
            ADD X30, X0, #10
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #72] // Si anda MEM: 0xA
        pl_end_10:
        
//-----------------------------------------------------------------------\\

// caso SUBIS X28 > 0    B.PL: N=0   Números positivos
 
            SUBS X28, X3, #2    //--------> [X28] = 3 - #2 = 1 
            B.PL pl_11
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #11
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #80] // Si falla MEM: 0xFFFFFFFFFFFFFFF5 = -11
            CBZ XZR, pl_end_11
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_11:
            ADD X30, X0, #11
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #80] // Si anda MEM: 0xB
        pl_end_11:


//-----------------------------------------------------------------------\\    

// caso SUBIS X28 = 0    B.PL: N=0

            SUBS X28, X3, #3    //--------> [X28] = 3 - #3 = 0
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_12
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #12
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #88] // Si falla MEM: 0xFFFFFFFFFFFFFFF4 = -12
            CBZ XZR, pl_end_2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_12:
            ADD X30, X0, #12
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #88] // Si anda MEM: 0xC
        pl_end_12:

//-----------------------------------------------------------------------\\  

// caso SUBIS X28 < 0    B.PL: N=0
            SUBS X28, X2, #3    //--------> [X28] = 2 - #3 = -1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_13
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #13
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #96] // Si anda MEM: 0xD
            CBZ XZR, pl_end_13
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_13:
            SUB X30, X0, #13
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #96] // Si falla MEM: 0xFFFFFFFFFFFFFFF3 = -13
        pl_end_13:

//-----------------------------------------------------------------------\\


// caso SUBIS X28 < 0    B.PL: N=0
            SUB X29, XZR, X2
            ADD XZR, XZR, XZR
            ADD XZR, XZR, XZR
            SUBS X28, X29, #3    //--------> [X28] = -2 - #3 = -5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_14
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #14
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #104] // Si anda MEM: 0x4
            CBZ XZR, pl_end_14
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_14:
            SUB X30, X0, #14
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #104] // Si falla MEM: 0xFFFFFFFFFFFFFFF2 = -14
        pl_end_14:

//-----------------------------------------------------------------------\\

// caso SUBIS X28 > 0    B.PL: N=0   Números positivos
 
            SUBS X28, X3, #2    //--------> [X28] = 3 - #2 = 1
            B.PL pl_15
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #15
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #112] // Si falla MEM: 0xFFFFFFFFFFFFFFF1 = -15
            CBZ XZR, pl_end_15
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_15:
            ADD X30, X0, #15
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #112] // Si anda MEM: 0x15
        pl_end_15:


//-----------------------------------------------------------------------\\ 

// caso ADDIS X28 < 0    B.PL: N=0   Números negativos
            SUB X28, XZR, X3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X28, #-2   //--------> [X28] = -3 + (-2) = -5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_16
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #16
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #120] // Si anda MEM: 0x10
            CBZ XZR, pl_end_16
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_16:
            SUB X30, X0, #16
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #120] // Si falla MEM: 0xFFFFFFFFFFFFFFF0 = -16
        pl_end_16:


//-----------------------------------------------------------------------\\ 

// caso ADDIS X28 = 0    B.PL: N=0 
            SUB X29, XZR, X3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, #3    //--------> [X28] = -3 + 3 = 0
            B.PL pl_17
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #17
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #128] // Si falla MEM: 0xFFFFFFFFFFFFFFEF = -17
            CBZ XZR, pl_end_17
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_17:
            ADD X30, X0, #17
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #128] // Si anda MEM: 0x11
        pl_end_17:

//-----------------------------------------------------------------------\\

// caso ADDIS X28 < 0    B.PL: N=0 

            SUB X29, XZR, X5
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, #3    //--------> [X28] = -5 + 3 = -2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.PL pl_18
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #18
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #136] // Si anda MEM: 0x12
            CBZ XZR, pl_end_18
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_18:
            SUB X30, X0, #18
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #136] // Si falla MEM: 0xFFFFFFFFFFFFFFEE = -18
        pl_end_18:

//-----------------------------------------------------------------------\\

// caso ADDIS X28 > 0    B.PL: N=0 
            SUB X29, XZR, X3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADDS X28, X29, #4    //--------> [X28] = -3 + 4 = 1
            B.PL pl_19
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #19
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #142] // Si falla MEM: 0xFFFFFFFFFFFFFFED = -9
            CBZ XZR, pl_end_19
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_19:
            ADD X30, X0, #19
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #142] // Si anda MEM: 0x13
        pl_end_19:

//-----------------------------------------------------------------------\\

// caso ADDIS X28 > 0    B.PL: N=0 
            ADDS X28, X3, #2    //--------> [X28] = 3 + 2 = 5
            B.PL pl_20
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            SUB X30, X0, #20
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #150] // Si falla MEM: 0xFFFFFFFFFFFFFFEC = -20
            CBZ XZR, pl_end_20
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        pl_20:
            ADD X30, X0, #20
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #150] // Si anda MEM: 0x14
        pl_end_20:
        
//-----------------------------------------------------------------------\\
