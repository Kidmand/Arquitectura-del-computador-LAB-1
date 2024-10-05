module alu
    #(parameter int unsigned N = 64)
    (input logic [N-1:0] a, b,
     input logic [3:0] ALUControl,
     input logic write_flags,  // Señal para habilitar la actualización de banderas
     output logic [N-1:0] result,
     output logic zero,
     output logic negative,
     output logic carry,
     output logic overflow );

    always_comb begin
        // Inicializa las señales
        result = '0;
        zero = 1'b0;
        negative = 1'b0;
        carry = 1'b0;  // Inicializa carry
        overflow = 1'b0;  // Inicializa overflow

        // Realiza la operación según ALUControl
        case (ALUControl)
            4'b0000: result = a & b;  // AND
            4'b0001: result = a | b;  // OR
            4'b0010: begin
                result = a + b; // Suma
                carry = (result < a) ? 1'b1 : 1'b0; // Chequeo de carry
                overflow = (a[N-1] == b[N-1]) && (result[N-1] != a[N-1]); // Chequeo de overflow
            end
            4'b0110: begin
                result = a - b; // Resta
                carry = (a < b) ? 1'b1 : 1'b0; // Chequeo de borrow
                overflow = (a[N-1] != b[N-1]) && (result[N-1] != a[N-1]); // Chequeo de overflow
            end
            4'b0111: result = b;       // Pass-through
            default: result = '0;       // Default case
        endcase

        // Bandera Zero
        zero = (result === '0) ? 1'b1 : 1'b0;

        // Bandera Negative
        negative = result[N-1]; // El bit más significativo (MSB) indica el signo

        // Actualiza las banderas solo si write_flags está habilitado
        if (!write_flags) begin
            zero = 1'b0; // Mantiene el estado anterior si no se deben actualizar
            negative = 1'b0; // Mantiene el estado anterior si no se deben actualizar
            carry = 1'b0; // Mantiene el estado anterior si no se deben actualizar
            overflow = 1'b0; // Mantiene el estado anterior si no se deben actualizar
        end
    end

endmodule
