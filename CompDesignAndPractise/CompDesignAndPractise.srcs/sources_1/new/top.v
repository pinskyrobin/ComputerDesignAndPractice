module top(
    input           clk,
    input           rst_n,
    output          debug_wb_have_inst,   // WB�׶��Ƿ���ָ�� (�Ե�����CPU����flag��Ϊ1)
    output [31:0]   debug_wb_pc,          // WB�׶ε�PC (��wb_have_inst=0�������Ϊ����ֵ)
    output          debug_wb_ena,         // WB�׶εļĴ���дʹ�� (��wb_have_inst=0�������Ϊ����ֵ)
    output [4:0]    debug_wb_reg,         // WB�׶�д��ļĴ����� (��wb_ena��wb_have_inst=0�������Ϊ����ֵ)
    output [31:0]   debug_wb_value        // WB�׶�д��Ĵ�����ֵ (��wb_ena��wb_have_inst=0�������Ϊ����ֵ)
);

    wire ram_clk;
    assign ram_clk = ~clk;
    wire dram_we;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] rf_rD2;
    wire [31:0] ALU_C;
    wire [31:0] DRAM_data;
    miniRV U_miniRV (
        .clk_i               (clk),
        .rst_n               (rst_n),
        .dram_we             (dram_we),
        .pc                  (pc),
        .instruction         (instruction),
        .rf_rD2              (rf_rD2),
        .ALU_C               (ALU_C),
        .DRAM_data           (DRAM_data),
        .debug_wb_have_inst  (debug_wb_have_inst),
        .debug_wb_pc         (debug_wb_pc),
        .debug_wb_ena        (debug_wb_ena),
        .debug_wb_reg        (debug_wb_reg),
        .debug_wb_value      (debug_wb_value)
    );
    
    inst_mem imem(
        .a    (pc[15:2]),
        .spo  (instruction)
    );
    
    data_mem dmem(
        .clk    (ram_clk),
        .a      (ALU_C[15:2]),
        .qspo   (DRAM_data),
        .we     (dram_we),
        .d      (rf_rD2)
    );
endmodule
