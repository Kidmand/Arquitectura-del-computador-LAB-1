module fetch
    #(parameter int unsigned N = 64)
    (input logic PCSrc_F, clk, reset,
     input logic [N-1:0] PCBranch_F,
     output logic [N-1:0] imem_addr_F );

    logic [N-1:0] output_adder,output_mux, output_PC;

    mux2 #(N) MUX(.d0(output_adder),
                    .d1(PCBranch_F),
                    .s(PCSrc_F),
                    .y(output_mux));

    flopr #(N) PC(.clk(clk),
                    .reset(reset),
                    .d(output_mux),
                    .q(output_PC));

    adder #(N) Add(.a(output_PC),
                     .b(64'd4),
                     .y(output_adder));

    assign imem_addr_F = output_PC;

endmodule
