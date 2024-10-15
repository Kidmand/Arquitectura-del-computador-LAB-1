// Etapa: MEMORY

module memory     (input logic Branch_M, zero_M, zero, negative, overflow, carry, bCondCheck,
                    input logic [4:0] Rt_B_cond,
                    output logic PCSrc_M);

    bCondCheck Bcond_check(
        .zero(zero),
        .negative(negative),
        .carry(carry),
        .overflow(overflow),
        .bCondCheck(bCondCheck),
        .Rt_B_cond(Rt_B_cond),
        .B_cond_is(B_cond_is)
    );
    mux2    MUX2 (.d0(B_cons_is), .d1(Branch_M), .s(bCondCheck), .y(PCSrc_M));
    assign PCSrc_M = Branch_M & zero_M;

endmodule
