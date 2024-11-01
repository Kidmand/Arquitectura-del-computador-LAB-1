module bCondCheck (
    input logic zero,
    input logic negative,
    input logic carry,
    input logic overflow,
    input logic bCondCheck,
    input logic [4:0] Rt_B_cond,
    output logic B_cond_is);

    always_comb begin
        B_cond_is = 0;
        if (bCondCheck) begin
            casez (Rt_B_cond)
                5'b00000: B_cond_is = zero;                                             //B.EQ
                5'b00001: B_cond_is = (zero === 0);                                     //B.NE
                5'b00010: B_cond_is = carry;                                            //B.HS
                5'b00011: B_cond_is = (carry === 0);                                    //B.LO
                5'b00100: B_cond_is = negative;                                         //B.MI
                5'b00101: B_cond_is = (negative === 0);                                 //B.PL
                5'b00110: B_cond_is = overflow;                                         //B.VS
                5'b00111: B_cond_is = (overflow === 0);                                 //B.VC
                5'b01000: B_cond_is = ((zero === 0) && carry);                          //B.HI
                5'b01001: B_cond_is = ~((zero === 0) && carry);                         //B.LS
                5'b01010: B_cond_is = (negative === overflow);                          //B.GE
                5'b01011: B_cond_is = (negative !== overflow);                          //B.LT
                5'b01100: B_cond_is = ((zero === 0) && (negative === overflow));    //B.GT
                5'b01101: B_cond_is = ~((zero === 0) && (negative === overflow));   //B.LE
                default: B_cond_is = 0;
            endcase
        end
    end

endmodule
