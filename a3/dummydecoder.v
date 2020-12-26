module dummydecoder(
    input [31:0] instr,  // Full 32-b instruction
    output [5:0] op,     // some operation encoding of your choice
    output [4:0] rs1,    // First operand
    output [4:0] rs2,    // Second operand
    output [4:0] rd,     // Output reg
    input  [31:0] r_rv2, // From RegFile
    output [31:0] rv2,   // To ALU
    output we            // Write to reg
);

    assign op = {instr[30],instr[14:12],instr[5:4]}; // taking the bits which change within the different ALU instrucitons
    // In particular 5th bit is set for instructions not using immediate values
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd = instr[11:7];
    assign we = 1;    // For only ALU ops, can always set to 1
    assign rv2 = instr[5] == 1 ? r_rv2 :                                                // value from regfile will be used if not an immediate type instruction 
                 instr[14:12] == 1 || instr[14:12] == 5 ? { {26{instr[24]}} , instr[24:20] } : { {19{instr[31]}} , instr[31:20] };  // only 5 bit immediate values in case of shift instructions; for others 12-bit immediate values; all are sign extended to 32

endmodule
