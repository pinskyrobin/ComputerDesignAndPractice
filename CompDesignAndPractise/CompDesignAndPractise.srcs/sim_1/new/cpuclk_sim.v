`timescale 1ns / 1ps
module cpuclk_sim();
    // input
    reg pclk = 0;
    // output
    wire clock;
    cpuclk UCLK (
        .clk_in1    (pclk),
        .clk_out1   (clock)
    );
    always #5 pclk = ~pclk;
endmodule