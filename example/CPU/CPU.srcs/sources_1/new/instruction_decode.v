module instruction_decode(
    input [31:0] pc,
    output [31:0] IROM_inst,
    input [2:0] sext_op,
    output [31:0] sext_ext,
    input cpuclk,
    input rst_i,
    input rf_we,
    input [31:0] wd_sel_wd,
    output [31:0] rf_rD1,
    output [31:0] rf_rD2
    );
    IROM u_IROM(
        .addr       (pc),
        .inst       (IROM_inst)
    );
    SEXT u_SEXT(
        .sext_op    (sext_op),
        .din        (IROM_inst),
        .ext        (sext_ext)
    );
    reg_file u_reg_file(
        .clk        (cpuclk),
        .reset      (rst_i),
        .rf_we      (rf_we),
        .rR1        (IROM_inst[19:15]),
        .rR2        (IROM_inst[24:20]),
        .wR         (IROM_inst[11:7]),
        .wD         (wd_sel_wd),
        .rD1        (rf_rD1),
        .rD2        (rf_rD2)
    );
endmodule
