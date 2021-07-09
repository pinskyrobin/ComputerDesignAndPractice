`timescale 1ns / 1ps

module ID(
    input           clk,
    input           rst_n,
    input           rf_we,
    input  [2:0]    sext_op,
    input  [31:0]   pc,
    input  [31:0]   wD,
    input  [31:0]   instruction,
    output [31:0]   sext,
    output [31:0]   rD1,
    output [31:0]   rD2
    );
    
    IROM U_irom(
        .pc_i(pc),
        .instruction(instruction)
    );
    
    Imme U_imme(
        .sext_op(sext_op),
        .instruction(instruction),
        .sext(sext)
    );
    
    RegFile U_regfile(
        .clk(clk),         
        .rst_n(rst_n),        
        .rR1(instruction[19:15]),     
        .rR2(instruction[24:20]),     
        .wR(instruction[11:7]),      
        .wD(wD),      
        .rf_we(rf_we),       
        .rD1(rD1),  
        .rD2(rD2) 
    );
endmodule
  