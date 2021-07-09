`timescale 1ns / 1ps

module Imme(
    input [2:0] 	sext_op,
    input [24:0]	instruction,
    output reg [31:0] sext
    );
    always @(*) begin
        case (sext_op)
            `I_TYPE:    //I-type
                sext = {{20{instruction[24]}}, instruction[24:13]};
            `S_TYPE:   //S-type
                sext = {{20{instruction[24]}}, instruction[24:18], instruction[4:0]};
            `B_TYPE:   //B-type
                sext = {{20{instruction[24]}}, instruction[24], instruction[0], instruction[23:18], instruction[4:1]};
            `U_TYPE:   //U-type
                sext = {instruction[24:5], 12'b0};
            `J_TYPE:   //J-type
                sext = {{12{instruction[24]}}, instruction[24], instruction[12:5], instruction[13], instruction[23:14]};
            default:
                sext = 32'h0;
        endcase
    end
    
endmodule
