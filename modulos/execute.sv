module execute
    #(parameter int unsigned N = 64)
    (input logic AluSrc,
     input logic [3:0] AluControl,
     input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E,
     output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E,
     output logic zero_E, negative_E, carry_E, overflow_E);

    logic [N-1:0] output_sl2, output_mux;

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
                   // .write_flags(write_flags_E), // FIXME: Esta señal medio al pedo, ya que se puede calcular directamente de AluControl
                   .result(aluResult_E),
                   .zero(zero_E),
                   .negative(negative_E),
                   .carry(carry_E),
                   .overflow(overflow_E));

    assign writeData_E = readData2_E;

endmodule
