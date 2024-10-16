module maindec(
    input logic [10:0] Op,
    output logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, condBranch,
    output logic [1:0] ALUOp);

    logic [9:0] output_signals [0:6] = '{
        10'b0_0_0_1_0_0_0_0_10, // R-format
        10'b0_1_1_1_1_0_0_0_00, // LDUR
        10'b1_1_0_0_0_1_0_0_00, // STUR
        10'b1_0_0_0_0_0_1_0_01, // CBZ
        10'b0_1_0_1_0_0_0_0_11, // I-format
        10'b0_0_0_0_0_0_1_1_01, // B.cond
        10'b0_0_0_0_0_0_0_0_00  // default
    };

    logic [9:0] res;
    assign {Reg2Loc,
            ALUSrc,
            MemtoReg,
            RegWrite,
            MemRead,
            MemWrite,
            Branch,
            condBranch,
            ALUOp } = res;

    always_comb begin
        casez (Op)
            // TYPE R ADDS y SUBS
            11'b101_0101_1000, //ADDS
            11'b111_0101_1000, //SUBS
            11'b100_0101_1000,
            11'b110_0101_1000,
            11'b100_0101_0000,
            11'b101_0101_0000: res = output_signals[0];
            // LDUR
            11'b111_1100_0010: res = output_signals[1];
            // STUR
            11'b111_1100_0000: res = output_signals[2];
            // CBZ
            11'b101_1010_0???: res = output_signals[3];
            // TYPE I
            11'b101_1000_100?, // ADDIS
            11'b1111_000_100?, // SUBIS
            11'b100_1000_100?, // ADDI
            11'b110_1000_100?: // SUBI
                    res = output_signals[4];
            // B.cond
            11'b010_1010_0???: res = output_signals[5];
            default: res = output_signals[6];
        endcase
    end

endmodule
