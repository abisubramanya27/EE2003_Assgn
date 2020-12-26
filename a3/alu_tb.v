`timescale 1ns/1ns 
// Appends PASS/FAIL to alu_tb.log
module alu_tb ();
    
    wire [4:0] d_rs1;   // value from decoder - muxed to regfile
    wire  [4:0] rs1;
    
    reg  [4:0] i_rs1; reg sel;
    wire [4:0] rs2, rd;
    wire [5:0] op;
    wire [31:0] rv1, rv2, r_rv2, rvout;
    reg  clk;
    reg  [31:0] instr;
    reg  we;
    wire d_we;          // dummy value from decoder, multiplexed in testbench
    integer i, s, numinstr, fp, reg_file, exp_reg, fail, log_file;

    // Instantiate ALU
    alu32 u1(
        .op(op),
        .rv1(rv1),
        .rv2(rv2),
        .rvout(rvout)
    );

    regfile u2(
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .we(we),
        .wdata(rvout),
        .rv1(rv1),
        .rv2(r_rv2)     // Decoder selects between this and Imm
    );

    dummydecoder u3(
        .instr(instr),
        .op(op),
        .rs1(d_rs1),
        .rs2(rs2),
        .rd(rd),
        .we(d_we),
        .r_rv2(r_rv2),  // From RegFile
        .rv2(rv2)       // To ALU
    );

    // Set up clock
    always #5 clk=~clk;
    assign rs1 = sel ? d_rs1 : i_rs1;
    initial begin
        // Uncomment below to dump out VCD file for gtkwave
        // NOTE: This will NOT work on the jupyter terminal
        // $dumpfile("alu_tb.vcd");
        // $dumpvars(0, alu_tb);
        clk = 1;
        sel = 1'b1;
        fp = $fopen(`TESTFILE, "r");
        reg_file = $fopen(`REGFILE, "r");
        log_file = $fopen("alu_tb.log", "a");
        s = $fscanf(fp, "%d\n", numinstr);
        @(negedge clk);
        for (i=0; i<numinstr; i=i+1) begin
            s = $fscanf(fp, "%x\n", instr);
            we = d_we;
            $display("instr = %x", instr);
            @(negedge clk);
        end
        we = 0;
        fail = 0;
        
        // Dump out all registers
        for (i=0; i<32; i=i+1) begin
            sel = 1'b0;
            i_rs1 = i;
            s = $fscanf(reg_file, "%d\n", exp_reg);
            @(negedge clk); // let one clock edge pass
            if(exp_reg !== rv1) begin
                $display("FAIL: Expected Reg[%d] = %x vs. Got Reg[%d] = %x", i, $signed(exp_reg), i, rv1);
                fail = fail + 1;
            end 
        end
        if(fail != 0) begin
            $display("FAILED. %d registers do not match.\n", fail);
            $fwrite(log_file, "FAIL\n");
        end else begin
            $display("PASSED\n.");
            $fwrite(log_file, "PASS\n");
        end
        $finish;
    end

endmodule
