module execute
    #(parameter int unsigned N = 64)
    (input logic AluSrc,
     input logic [3:0] AluControl,
     input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E,
     output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E,
     output logic zero_E, zero_flag_E, negative_E, carry_E, overflow_E);

    logic [N-1:0] output_sl2, output_mux;
    logic write_flags_ALU;
    logic zero_ALU, zero_flag_ALU, negative_ALU, carry_ALU, overflow_ALU;

    adder #(N) Add(.a(PC_E),
                    .b(output_sl2),
                    .y(PCBranch_E));

    sl2  #(N) ShiftLeft2(.a(signImm_E),
                          .y(output_sl2));

    mux2 #(N) MUX(.d0(readData2_E),
                   .d1(signImm_E),
                   .s(AluSrc),
                   .y(output_mux));

    alu #(N) ALU(.a(readData1_E),
                   .b(output_mux),
                   .ALUControl(AluControl),
                   .result(aluResult_E),
                   .write_flags(write_flags_ALU),
                   .zero(zero_ALU),
                   .zero_flag(zero_flag_Azero_ALU),
                   .negative(negative_Azero_ALU),
                   .carry(carry_Azero_ALU),
                   .overflow(overflow_Azero_ALU));

    flopenr   #(4)      CPSR_flags (.clk(clk),
                                    .reset(reset),
                                    .enable(write_flags_ALU),
                                    .d({
                                        zero_flag_ALU,
                                        negative_ALU,
                                        carry_ALU,
                                        overflow_ALU
                                    }),
                                    .q({
                                        zero_flag_E,
                                        negative_E,
                                        carry_E,
                                        overflow_E
                                    }));


    assign writeData_E = readData2_E;

endmodule
