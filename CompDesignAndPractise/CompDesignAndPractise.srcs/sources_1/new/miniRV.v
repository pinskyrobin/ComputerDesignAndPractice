`timescale 1ns / 1ps

module miniRV(
    input clk,
    input rst_n,
    input  [31:0] instruction,
    input  [31:0] rf_rD2,
    output dram_we,
    output [31:0] pc,
    output [31:0] ALU_C,
    output [31:0] DRAM_data,
    output [0:0] debug_wb_have_inst,
    output [31:0] debug_wb_pc,
    output [0:0] debug_wb_ena,
    output [4:0] debug_wb_reg,
    output [31:0] debug_wb_value
    );
    
    wire rf_we;
    wire alua_sel;
    wire alub_sel;
    wire is_branch;
    wire [1:0] npc_op;
    wire [1:0] wd_sel;
    wire [2:0] sext_op;
    wire [3:0] alu_op;
    wire [31:0] npc_pc4;
    wire [31:0] sext;
    wire [31:0] wD;
    wire [31:0] rf_rD1;
    
    assign debug_wb_have_inst = 'b1;
    assign debug_wb_pc        = pc;
    assign debug_wb_ena       = rf_we;
    assign debug_wb_reg       = instruction[11:7];
    assign debug_wb_value     = wD;
    
    Control U_control(
        .clk(clk),
        .rst_n(rst_n),
        .funct3(instruction[14:12]),  
        .funct7(instruction[31:25]),  
        .opcode(instruction[6:0]),  
        .rf_we(rf_we),   
        .dram_we(dram_we), 
        .alua_sel(alua_sel),
        .alub_sel(alub_sel),
        .npc_op(npc_op),
        .wd_sel(wd_sel),
        .sext_op(sext_op),
        .alu_op(alu_op)
    );
    
    IF U_if(
        .clk(clk),
        .rst_n(rst_n),
        .is_branch(is_branch),
        .npc_op(npc_op),
        .sext(sext),
        .rD1(rf_rD1),
        .pc(pc),
        .npc_pc4(npc_pc4)
    );
    
    ID U_id(
        .clk(clk),
        .rst_n(rst_n),
        .rf_we(rf_we),
        .sext_op(sext_op),
        .pc(pc),
        .wD(wD),
        .instruction(instruction),
        .sext(sext),
        .rD1(rf_rD1),        
        .rD2(rf_rD2)        
    );
    
    EX U_ex(
        .alua_sel(alua_sel),
        .alub_sel(alub_sel),
        .alu_op(alu_op),
        .funct3(instruction[14:12]),
        .pc(pc),  
        .rD1(rf_rD1),        
        .rD2(rf_rD2),
        .sext(sext),
        .is_branch(is_branch),
        .ALU_C(ALU_C)
    );
    
    MEM U_mem(
        .clk(clk),
        .dram_we(dram_we),
        .addr(ALU_C),
        .din(rf_rD2),    
        .dout(DRAM_data)
    );
    
    WB U_wb(
        .wd_sel(wd_sel),   
        .ALU_C(ALU_C),    
        .npc_pc4(npc_pc4),  
        .dram_data(DRAM_data),
        .wD(wD)
    );
    
endmodule
