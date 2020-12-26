module alu32(
    input [5:0] op,      // some input encoding of your choice
    input [31:0] rv1,    // First operand
    input [31:0] rv2,    // Second operand
    output [31:0] rvout  // Output value
);
    // Wires for storing the signed versions of rv1 and rv2
    wire signed [31:0] rv1_signed;
    wire signed [31:0] rv2_signed;

    reg signed [31:0] rout; // stores the output of the alu instruction which will be continuously assigned to rvout
    assign rvout = rout;
    assign rv1_signed = rv1;
    assign rv2_signed = rv2;

    always @(rv1 or rv2 or rv1_signed or rv2_signed or op) begin
        case (op)
            6'b000001, 6'b100001, 6'b000011 : begin // 1st two - ADDI, 3rd - ADD
                rout = rv1_signed + rv2_signed;
            end
            6'b001001, 6'b101001, 6'b001011 : begin // 1st two - SLTI, 3rd - SLT
                rout = rv1_signed < rv2_signed;
            end
            6'b001101, 6'b101101, 6'b001111 : begin // 1st two - SLTIU, 3rd - SLTU
                rout = rv1 < rv2;
            end
            6'b010001, 6'b110001, 6'b010011 : begin // 1st two - XORI, 3rd - XOR
                rout = rv1_signed ^ rv2_signed;
            end
            6'b011001, 6'b111001, 6'b011011 : begin // 1st two - ORI, 3rd - OR
                rout = rv1_signed | rv2_signed;
            end
            6'b011101, 6'b111101, 6'b011111 : begin // 1st two - ANDI, 3rd - AND
                rout = rv1_signed & rv2_signed;
            end
            6'b000101, 6'b000111 : begin            // 1st - SLLI, 2nd - SLL
                rout = rv1_signed << rv2[4:0];      // the lower 5 bits only need to be used for shift instructions
            end
            6'b010101, 6'b010111 : begin            // 1st - SRLI, 2nd - SRL
                rout = rv1_signed >> rv2[4:0];      // the lower 5 bits only need to be used for shift instructions
            end
            6'b110101, 6'b110111 : begin            // 1st - SRAI, 2nd - SRA
                rout = rv1_signed >>> rv2[4:0];     // the lower 5 bits only need to be used for shift instructions
            end
            6'b100011 : begin                       // SUB
                rout = rv1_signed - rv2_signed;
            end
            default : begin                         // Incase doesn't match any allowed instructions, setting output to zero than any garbage value
                rout = {32{1'b0}};
            end
        endcase
    end

endmodule
