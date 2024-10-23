module signext (
    input logic [31:0] a,
    output logic [63:0] y );

    always_comb
        // Usar casez para poder detectar los singos de pregunta "?".
        casez (a[31:21])
             11'b111_1100_0010: y = {{55{a[20]}}, a[20:12]};        // LDUR
             11'b111_1100_0000: y = {{55{a[20]}}, a[20:12]};        // STUR
             11'b101_1010_0???: y = {{45{a[23]}}, a[23:5]};         // CBZ
             11'b010_1010_0???: y = {{45{a[23]}}, a[23:5]};         // B.cond
             11'b1001000100?: y = {{52'b0}, a[21:10]};              // I for ADDI
             11'b1101000100?: y = {{52'b0}, a[21:10]};              // I for SUBI
             11'b1011000100?: y = {{52'b0}, a[21:10]};              // I for ADDIS
             11'b1111000100?: y = {{52'b0}, a[21:10]};              // I for SUBIS
             // En cualquier otro caso:
             default: y = '0;
        endcase

endmodule
