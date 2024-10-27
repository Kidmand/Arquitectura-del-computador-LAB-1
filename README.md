[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/NmEzgpEA)

# FaMAF-UNC: Arquitectura de Computadoras 2024

Template del laboratorio 1 para Quartus 20.1 y el dispositivo Cyclone IV: EP4CE22F17C6.
Debe realizarse un fork de este repositorio y el nombre debe corresponderse al asignado por la cátedra.

Directorios:

- modulos: Deben estar TODOS los módulos implementados (no crear otros directorios con módulos)
- test-benchs: Por cada módulo debe existir al menos un test-bench. El archivo debe llamarse con el nombre del módulo + "\_tb".

## Informe

### Ejericio 1

<!--
● Describir brevemente qué modificaciones se introdujeron (en qué entidades y con
qué finalidad). Mostrar el diagrama del nuevo microprocesador, indicando las
señales y entidades agregadas (de ser necesario).
-->
Para desarollar las instrucciones `ADDI` y `SUBI` se modificaron los modulos:

**maindec.sv**
```sv
    logic [8:0] output_signals [0:5] = '{
        9'b0_0_0_1_0_0_0_10, 
        9'b0_1_1_1_1_0_0_00, 
        9'b1_1_0_0_0_1_0_00, 
        9'b1_0_0_0_0_0_1_01, 
        9'b0_1_0_1_0_0_0_11, // I-format -> NUEVA LINEA
        9'b0_0_0_0_0_0_0_00  
    };
```
> Se agregaron las señales de control para las instrucciones `ADDI` y `SUBI`.

``` sv
    casez (Op)
        ...
        // TYPE I
        11'b100_1000_100?, // ADDI
        11'b110_1000_100?: // SUBI
                    res = output_signals[4];
        ...
    endcase
```
> Se agrego que segun el opcode de la instruccion se seleccione la señal de control correspondiente.


**aludec.sv**
``` sv
    ...
    else if((aluop == 2'b11)  & (funct[10:1] == 10'b1001000100)) alucontrol = 4'b0010; //ADDI
    else if((aluop == 2'b11)  & (funct[10:1] == 10'b1101000100)) alucontrol = 4'b0110; //SUBI
    ...
```
> Se asignaron las nuevas señales de alucontrol para las instrucciones ADDI y SUBI.


**signext.sv**
```sv
    casez (a[31:21])
        ...
        11'b1001000100?: y = {{52'b0}, a[21:10]};  // I para ADDI
        11'b1101000100?: y = {{52'b0}, a[21:10]};  // I para SUBI
        ...
    endcase
```
> Se modificó el signext pueda extender los valores de las instrucciones `ADDI` y `SUBI`.

**imem.sv**
```sv
    input logic [9:0] addr
```
> Se modifico el tamaño de la direccion de memoria para que entre el nuevo código.

```sv
    logic [N-1:0] ROM [0:1023] = '{default: 32'b0};
```
> Se modifico el tamaño de la memoria ROM para que entre el nuevo código.
> (Le dejamos bastante espacio para no tener problemas)

<!--
● Mostrar el programa en assembler LEGv8 modificado que se utilizó para verificar el
comportamiento del procesador.
-->
Programa en assembler para verificar el comportamiento del procesador con las nuevas instrucciones `ADDI` y `SUBI`:

```sv
    .text
    .org 0x0000

    // Test de ADDI y SUBI
    ADD X17, X17, #1 //ADDI
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X17, [X0, #200] // MEM :0x12
    SUB X18, X18, #1 //SUBI
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X18, [X0, #208] // MEM :0X11

    // Continuación del codigo anterior
    STUR X1, [X0, #0] // MEM 0:0x1
    STUR X2, [X0, #8] // MEM 1:0x2
    STUR X3, [X16, #0] // MEM 2:0x3
    ADD X3, X4, X5
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X3, [X0, #24] // MEM 3:0x9
    SUB X3, X4, X5
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X3, [X0, #32] // MEM 4:0xFFFFFFFFFFFFFFFF
    SUB X4, XZR, X10
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X4, [X0, #40] // MEM 5:0xFFFFFFFFFFFFFFF6
    ADD X4, X3, X4
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X4, [X0, #48] // MEM 6:0xFFFFFFFFFFFFFFF5
    SUB X5, X1, X3
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X5, [X0, #56] // MEM 7:0x2
    AND X5, X10, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X5, [X0, #64] // MEM 8:0x0
    AND X5, X10, X3
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X5, [X0, #72] // MEM 9:0xA
    AND X20, X20, X20
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X20, [X0, #80] // MEM 10:0x14
    ORR X6, X11, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X6, [X0, #88] // MEM 11:0xB
    ORR X6, X11, X3
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X6, [X0, #96] // MEM 12:0xFFFFFFFFFFFFFFFF
    LDUR X12, [X0, #0]
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADD X7, X12, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X7, [X0, #104] // MEM 13:0x1
    STUR X12, [X0, #112] // MEM 14:0x1
    ADD XZR, X13, X14
    STUR XZR, [X0, #120] // MEM 15:0x0
    CBZ X0, L1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X21, [X0, #128] // MEM 16:0x0 (si falla CBZ =21)
L1:
    STUR X21, [X0, #136] // MEM 17:0x15
    ADD X2, XZR, X1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
L2:
    SUB X2, X2, X1
    ADD X24, XZR, X1
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X24, [X0, #144] // MEM 18:0x1 y MEM 19=0x1
    ADD X0, X0, X8
    CBZ X2, L2
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X30, [X0, #144] // MEM 20:0x1E
    ADD X30, X30, X30
    SUB X21, XZR, X21
        ADD XZR, XZR, XZR
    ADD X30, X30, X20
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    LDUR X25, [X30, #-8]
    ADD X30, X30, X30
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    ADD X30, X30, X16
        ADD XZR, XZR, XZR
        ADD XZR, XZR, XZR
    STUR X25, [X30, #-8] // MEM 21:0xA (= MEM 9)
finloop: 
    CBZ XZR, finloop
```

### Ejercicio 2

<!--
● Describir brevemente qué modificaciones se introdujeron (en qué módulos y con qué
  finalidad). Mostrar el diagrama del nuevo microprocesador, indicando las señales y
  módulos agregados.
● Escribir una sección de código assembler, donde se pruebe el funcionamiento de las
  nuevas instrucciones y se verifique que las que ya estaban implementadas
  continúen funcionando correctamente. Los resultados obtenidos al ejecutar cada una
  de las instrucciones deben guardarse en la memoria de datos. Mostrar el programa
  en assembler LEGv8 modificado que se utilizó para verificar el comportamiento del
  procesador y el contenido de memoria al finalizar su ejecución.
-->