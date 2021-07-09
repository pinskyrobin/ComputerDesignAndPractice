`timescale 1ns / 1ps

module EX(
    input           alua_sel,
    input           alub_sel,
    input   [2:0]   alu_op,
    input   [3:0]   funct3,
    input   [31:0]  pc,
    input   [31:0]  rf_rD1,
    input   [31:0]  rf_rD2,
    input   [31:0]  sext,
    output          is_branch,
    output  [31:0]  ALU_C
    );
    
    wire    [2:0]   compare_result;
    wire    [31:0]  ALU_A;
    wire    [31:0]  ALU_B;
    
    ALU_Sel U_alu_sel(
        .alua_sel(alua_sel),
        .alub_sel(alub_sel),
        .pc(pc),  
        .sext(sext),  
        .rf_rD1(rf_rD1),
        .rf_rD2(rf_rD2),
        .ALU_B(ALU_A),
        .ALU_B(ALU_B)
    );
    
    ALU_EX U_alu_ex(
        .alu_op(alu_op),        
        .ALU_A(ALU_A),         
        .ALU_B(ALU_B),         
        .compare_result(compare_result),
        .ALU_C(ALU_C)
    );
    
    Branch U_branch(
        .compare_result(compare_result),
        .funct3(funct3),        
        .is_branch(is_branch)  
    );
    
endmodule
