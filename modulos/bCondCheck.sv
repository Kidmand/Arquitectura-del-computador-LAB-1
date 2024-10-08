module bCondCheck (
    input logic zero,
    input logic negative,
    input logic carry,
    input logic overflow,
    input logic [N-1:0] IM_readData,
    output logic condBranch
);

always_comb begin                 //B.cond
    if (IM_readData[N-1:N-7] === 8'b01010100) begin
        casez (IM_readData[4:0])
            
            5'b00000: condBranch = zero;           //B.EQ
            5'b00001: condBranch = (zero === 0);   //B.NE
            5'b00010: condBranch = carry;          //B.HS
            5'b00011: condBranch = (carry === 0);  //B.LO
            5'b00100: 
            5'b00101:
            5'b00110:
            5'b00111:
            5'b01000:
            5'b01001:
            5'b01010:
            5'b01011:
            5'b01100:
            5'b01101:
            

            default: condBranch = condBranch;
        endcase
    end
end

endmodule