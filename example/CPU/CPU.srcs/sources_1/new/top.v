module top(
    input clk,
    input rst_n,
    output        debug_wb_have_inst,   // WB阶段是否有指令 (对单周期CPU，此flag恒为1)
    output [31:0] debug_wb_pc,          // WB阶段的PC (若wb_have_inst=0，此项可为任意值)
    output        debug_wb_ena,         // WB阶段的寄存器写使能 (若wb_have_inst=0，此项可为任意值)
    output [4:0]  debug_wb_reg,         // WB阶段写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
    output [31:0] debug_wb_value        // WB阶段写入寄存器的值 (若wb_ena或wb_have_inst=0，此项可为任意值)
);
wire ram_clk;
assign ram_clk = ~clk;
    wire dram_we;
    wire [31:0] pc_pc;
    wire [31:0] irom_inst;
    wire [31:0] rf_rD2;
    wire [31:0] alu_c;
    wire [31:0] dram_rd;
miniRV U_miniRV (
    .clk_i               (clk),
    .rst_n               (rst_n),
    .dram_we             (dram_we),
    .pc_pc               (pc_pc),
    .IROM_inst           (irom_inst),
    .rf_rD2              (rf_rD2),
    .alu_c               (alu_c),
    .dram_rd             (dram_rd),
    .debug_wb_have_inst  (debug_wb_have_inst),
    .debug_wb_pc         (debug_wb_pc),
    .debug_wb_ena        (debug_wb_ena),
    .debug_wb_reg        (debug_wb_reg),
    .debug_wb_value      (debug_wb_value)
);
// 下面两个模块，只需要实例化并连线，不需要添加文件
prgrom imem(
    .a    (pc_pc[15:2]),
    .spo  (irom_inst)
);

dram dmem(
    .clk (ram_clk),
    .a   (alu_c[15:2]),
    .spo (dram_rd),
    .we  (dram_we),
    .d   (rf_rD2)
);
endmodule
