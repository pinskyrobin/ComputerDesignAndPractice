`include "param.v"
module SEXT(
    input [2:0] sext_op,
    input [31:0] din,
    output [31:0] ext
    );
    assign ext = (sext_op == `SEXT_I) ? {{20{din[31]}},din[31:20]}:
                 (sext_op == `SEXT_S) ? {{20{din[31]}},din[31:25],din[11:7]}:
                 (sext_op == `SEXT_B) ? {{19{din[31]}},din[31],din[7],din[30:25],din[11:8],1'b0}:
                 (sext_op == `SEXT_U) ? {din[31:12],12'b0}:
                 (sext_op == `SEXT_J) ? {{11{din[31]}},din[31],din[19:12],din[20],din[30:21],1'b0}:'b0;
endmodule