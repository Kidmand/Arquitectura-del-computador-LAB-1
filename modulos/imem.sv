// IMEM
module imem
    #(parameter int unsigned N = 32) (
    input logic [9:0] addr,
    output logic [N-1:0] q );

    logic [N-1:0] ROM [0:1023] = '{default: 32'b0};

    initial begin
        $readmemh("imem.txt", ROM);
    end

    always_comb begin
        q = ROM[addr];
    end

endmodule
