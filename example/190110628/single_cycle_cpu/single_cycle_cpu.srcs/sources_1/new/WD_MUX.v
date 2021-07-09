`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 22:27:20
// Design Name: 
// Module Name: WD_MUX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module WD_MUX(
    input clk,
    input rst_n,
    input [1:0] wd_sel,
    input [31:0] U_ext_num,
    input [31:0] ALU_result,
    input [31:0] DMEM_rd,
    input [31:0] PC_addr,
    output reg [31:0] WD
    );

    always @(*) begin
        if(!rst_n) WD = 32'h0;
        else begin
        case (wd_sel)
            2'b00: WD = ALU_result;
            2'b01: WD = DMEM_rd;
            2'b10: WD = U_ext_num;
            2'b11: WD = PC_addr + 4;
            default: WD = 32'h0;
        endcase
        end
    end
endmodule
