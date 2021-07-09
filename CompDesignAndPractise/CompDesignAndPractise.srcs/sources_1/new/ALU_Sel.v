`timescale 1ns / 1ps

module ALU_Sel(
    input          alua_sel,
    input          alub_sel,
    input   [31:0] pc,
    input   [31:0] sext,
    input   [31:0] rf_rD1,
    input   [31:0] rf_rD2,
    output  [31:0] ALU_A,
    output  [31:0] ALU_B
    );
    
    assign ALU_A = (alua_sel == 'b0) ? rf_rD1 : pc;
    assign ALU_B = (alub_sel == 'b0) ? rf_rD2 : sext;
    
endmodule
