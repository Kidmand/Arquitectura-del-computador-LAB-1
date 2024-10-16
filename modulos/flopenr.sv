module flopenr #(parameter int unsigned N = 64)
    (input logic clk,
     input logic reset,
     input logic enable,        // Agregar la señal de habilitación
     input logic [N-1:0] d,
     output logic [N-1:0] q );

    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            q <= '0;              // Reiniciar el registro a 0
        else if (enable)
            q <= d;               // Actualizar solo si enable es alto
    end

endmodule