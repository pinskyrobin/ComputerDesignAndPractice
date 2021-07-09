module alub_sel(                //B操作数的来源
    input alub_sel,
    input [31:0] rf_rD2,
    input [31:0] sext_ext,
    output [31:0] alu_b
    );
    assign alu_b = (alub_sel == 'b0) ? rf_rD2:sext_ext;
endmodule