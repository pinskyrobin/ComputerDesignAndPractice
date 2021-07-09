module miniRV(
    input clk_i,
    input rst_n,
    output        dram_we,
    output [31:0] pc,
    output [31:0] IROM_inst,
    output [31:0] rf_rD2,
    output [31:0] alu_c,
    output [31:0] dram_rd,
    output        debug_wb_have_inst,
    output [31:0] debug_wb_pc,
    output        debug_wb_ena,
    output [4:0]  debug_wb_reg,
    output [31:0] debug_wb_value
    );
	//wire cpu_clk;
    wire rst_i = ~rst_n;
    wire [1:0] npc_op;
    wire [1:0] wd_sel;
    wire rf_we;
    wire [2:0] sext_op;
    wire alub_sel;
    wire [3:0] alu_op;
    wire [1:0] alu_zero;
    //wire dram_we;
    
    wire [31:0] npc_pc_4;
    //wire [31:0] pc_pc;
    wire [31:0] sext_ext;
    //wire [31:0] irom_inst;
    wire [31:0] wd_sel_wd;
    wire [31:0] rf_rD1;
    //wire [31:0] rf_rD2;
    //wire [31:0] alu_c;
    //wire [31:0] dram_rd;
    assign debug_wb_have_inst = 'b1;
    assign debug_wb_pc        = pc;
    assign debug_wb_ena       = rf_we;
    assign debug_wb_reg       = IROM_inst[11:7];
    assign debug_wb_value     = wd_sel_wd;
//    cpuclk u_clk(
//        .clk_in1    (clk_i),
//        .clk_out1   (cpu_clk)
//    );
    control_logic u_control_logic(
        .clk        (clk_i),
        .reset      (rst_i),
        .func7      (IROM_inst[31:25]),
        .func3      (IROM_inst[14:12]),
        .opcode     (IROM_inst[6:0]),
        .npc_op     (npc_op),
        .wd_sel     (wd_sel),
        .rf_we      (rf_we),
        .sext_op    (sext_op),
        .alub_sel   (alub_sel),
        .alu_op     (alu_op),
        .alu_zero   (alu_zero),
        .dram_we    (dram_we)
    );
    instruction_fetch u_instruction_fetch(
        .cpu_clk    (clk_i),
        .rst_i      (rst_i),
        .pc         (pc),
        .npc_op     (npc_op),
        .imm        (sext_ext),
        .ra         (rf_rD1),
        .npc_pc_4   (npc_pc_4)
    );
    instruction_decode u_instruction_decode(
        .pc         (pc),
        .IROM_inst  (IROM_inst),
        .sext_op    (sext_op),
        .sext_ext   (sext_ext),
        .cpuclk     (clk_i),
        .rst_i      (rst_i),
        .rf_we      (rf_we),
        .wd_sel_wd  (wd_sel_wd),
        .rf_rD1     (rf_rD1),
        .rf_rD2     (rf_rD2)
    );
    execute u_execute(
        .alub_sel   (alub_sel),
        .rf_rD2     (rf_rD2),
        .sext_ext   (sext_ext),
        .alu_op     (alu_op),
        .rf_rD1     (rf_rD1),
        .alu_zero   (alu_zero),
        .alu_c      (alu_c)
    );
    data_memory u_data_memory(
        .clk        (clk_i),
        .dram_we    (dram_we),
        .addr        (alu_c),
        .din       (rf_rD2),
        .rd         (dram_rd)
    );
    write_back u_write_back(
        .wd_sel     (wd_sel),
        .alu_c      (alu_c),
        .dram_rd    (dram_rd),
        .npc_pc_4   (npc_pc_4),
        .wD         (wd_sel_wd)
    );
endmodule
