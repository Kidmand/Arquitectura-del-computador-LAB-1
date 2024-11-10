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
            STUR X30, [X0, #8] // Si falla MEM: 0xFFFFFFFFFFFFFFFE = -2
            CBZ XZR, ls_end_1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        ls_2:
            ADD X30, X0, #2
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #8] // Si anda MEM: 0x2
        ls_end_2:

//-----------------------------------------------------------------------\\  

// caso SUBS X28 > 0    B.LS = ~((zero === 0) && carry);
            SUB X29, XZR, X2
            ADD XZR, XZR, XZR
            ADD XZR, XZR, XZR
            SUBS X28, X29, X3    //--------> [X28] = 4 - 3 = 1
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            B.LS ls_3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            ADD X30, X0, #3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si anda MEM: 0x3
            CBZ XZR, ls_end_3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
        ls_3:
            SUB X30, X0, #3
                ADD XZR, XZR, XZR
                ADD XZR, XZR, XZR
            STUR X30, [X0, #16] // Si falla MEM: 0xFFFFFFFFFFFFFFFD = -3
        ls_end_3:
/*
Salida en memdump:
Memoria RAM de Arm:
Address Data
0 0000000000000001
1 0000000000000002
2 0000000000000003
3 0000000000000000
4 0000000000000000
5 0000000000000000
6 0000000000000000
7 0000000000000000
8 0000000000000000
9 0000000000000000
10 0000000000000000
11 0000000000000000
12 0000000000000000
13 0000000000000000
14 0000000000000000
15 0000000000000000
16 0000000000000000
17 0000000000000000
18 0000000000000000
19 0000000000000000
20 0000000000000000
21 0000000000000000
22 0000000000000000
23 0000000000000000
24 0000000000000000
25 0000000000000000
26 0000000000000000
27 0000000000000000
28 0000000000000000
29 0000000000000000
30 0000000000000000
31 0000000000000000
32 0000000000000000
33 0000000000000000
34 0000000000000000
35 0000000000000000
36 0000000000000000
37 0000000000000000
38 0000000000000000
39 0000000000000000
40 0000000000000000
41 0000000000000000
42 0000000000000000
43 0000000000000000
44 0000000000000000
45 0000000000000000
46 0000000000000000
47 0000000000000000
48 0000000000000000
49 0000000000000000
50 0000000000000000
51 0000000000000000
52 0000000000000000
53 0000000000000000
54 0000000000000000
55 0000000000000000
56 0000000000000000
57 0000000000000000
58 0000000000000000
59 0000000000000000
60 0000000000000000
61 0000000000000000
62 0000000000000000
63 0000000000000000
Finalizado para archivo: test-p2-ls.s
===============================================
*/
