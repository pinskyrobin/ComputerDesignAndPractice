`timescale 1ns / 1ps

module MEM(
    input           clk,
    input           dram_we,
    input   [31:0]  addr,
    input   [31:0]  din,
    output  [31:0]  dout
    );
    
//    dram U_dram(
//        .clk    (clk),          // input wire clka
//        .a      (addr[15:2]),   // input wire [13:0] addra
//        .qspo   (dout),         // output wire [31:0] douta
//        .we     (dram_we),      // input wire [0:0] wea
//        .d      (din)           // input wire [31:0] dina
//    );
endmodule
