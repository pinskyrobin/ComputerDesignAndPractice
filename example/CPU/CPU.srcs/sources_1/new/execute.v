module execute(
    input alub_sel,
    input [31:0] rf_rD2,
    input [31:0] sext_ext,
    input [3:0] alu_op,    
    input [31:0] rf_rD1,
    output [1:0] alu_zero,
    output [31:0] alu_c
    );
    wire [31:0] alub_sel_b;
    alub_sel u_alub_sel(
        .alub_sel   (alub_sel),
        .rf_rD2     (rf_rD2),
        .sext_ext   (sext_ext),
        .alu_b      (alub_sel_b)
    );
    ALU u_ALU(
        .alu_op     (alu_op),
        .A          (rf_rD1),
        .B          (alub_sel_b),
        .ZERO       (alu_zero),
        .C          (alu_c)
    );
endmodule
