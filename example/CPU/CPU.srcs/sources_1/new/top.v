module top(
    input clk,
    input rst_n,
    output        debug_wb_have_inst,   // WB�׶��Ƿ���ָ�� (�Ե�����CPU����flag��Ϊ1)
    output [31:0] debug_wb_pc,          // WB�׶ε�PC (��wb_have_inst=0�������Ϊ����ֵ)
    output        debug_wb_ena,         // WB�׶εļĴ���дʹ�� (��wb_have_inst=0�������Ϊ����ֵ)
    output [4:0]  debug_wb_reg,         // WB�׶�д��ļĴ����� (��wb_ena��wb_have_inst=0�������Ϊ����ֵ)
    output [31:0] debug_wb_value        // WB�׶�д��Ĵ�����ֵ (��wb_ena��wb_have_inst=0�������Ϊ����ֵ)
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
// ��������ģ�飬ֻ��Ҫʵ���������ߣ�����Ҫ����ļ�
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
