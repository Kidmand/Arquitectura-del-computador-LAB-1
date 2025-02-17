// ALU
module alu
    #(parameter int unsigned N = 64)
    (input logic [N-1:0] a, b,
     input logic [3:0] ALUControl,
     output logic [N-1:0] result,
     output logic zero, zero_flag,
     output logic negative,
     output logic carry,
     output logic overflow,
     output logic write_flags);

    logic [N:0] aux_result; // Tiene un bit de mas para detectar al carry
    //assign result = aux_result[N-1:0];

    always_comb begin
        // Inicialización de aux_result en cada ciclo.
        aux_result = '0;
        // Si es instuccion que setea flags, escribiremos las flags.
        // Ya que las itruciones que setean flags, (ADDIS, SUBI, ADDS, SUBS) tienen el MBS en 1.
        write_flags = ALUControl[3];
        // Setamos valores por defecto (por las dudas)
        zero = 1'b0;
        zero_flag = 1'b0;
        negative = 1'b0;
        carry = 1'b0;
        overflow = 1'b0;
        // Realiza la operación según ALUControl
        casez (ALUControl)
            4'b0000: aux_result = a & b;  // AND
            4'b0001: aux_result = a | b;  // OR
            4'b0111: aux_result = b;      // PASS b
            4'b?010: begin // SUMA
                aux_result = a + b;
                if (write_flags === '1) begin // Si seta flags, setamos si hay overflow.
                    overflow = (((~a[N-1]) && (~b[N-1]) && (aux_result[N-1])) ||
                                ((a[N-1])  && (b[N-1]) && (~aux_result[N-1])));
                end
            end
            4'b?110: begin // RESTA
                // Resta utilizando complemento a dos
                logic [N-1:0] complemento_b;        // Almacena el complemento a dos de b
                complemento_b = ~b + 1'b1;          // Calcular complemento a dos de b
                aux_result = a + complemento_b;     // Resta como suma de complemento a dos

                if (write_flags === '1) begin // Si seta flags, setamos si hay overflow.
                    overflow = (((~a[N-1]) && (b[N-1]) && (aux_result[N-1])) ||
                                ((a[N-1]) && (~b[N-1]) && (~aux_result[N-1])));
                end
            end
            default: result = '0;
        endcase
        if (write_flags === 1) begin // Si seta flags las setamos
            // Bandera de carry
            carry = (aux_result[N] === '1);
            // Bandera Zero
            zero_flag = (aux_result[N-1:0] === '0) ? 1'b1 : 1'b0;
            // Bandera Negative (El bit más significativo (MSB) indica el signo)
            negative = aux_result[N-1];
        end
        // Check si es 0
        zero = (aux_result[N-1:0] === '0) ? 1'b1 : 1'b0;
        result = aux_result[N-1:0];
    end

endmodule
