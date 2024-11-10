// MEMORY
module memory     (input logic Branch_M, zero_M, zero_flag, negative, overflow, carry, bCondCheck,
                    input logic [4:0] Rt_B_cond,
                    output logic PCSrc_M);

    logic B_cond_is;
    logic PCSrc_M_aux_;

    bCondCheck B_cond_check(
        .zero(zero_flag),
        .negative(negative),
        .carry(carry),
        .overflow(overflow),
        .bCondCheck(bCondCheck),
        .Rt_B_cond(Rt_B_cond),
        .B_cond_is(B_cond_is)
    );

    assign PCSrc_M_aux_ = Branch_M && zero_M;
    mux2 #(1) MUX2 (.d0(PCSrc_M_aux_), .d1(B_cond_is), .s(bCondCheck), .y(PCSrc_M));

endmodule
