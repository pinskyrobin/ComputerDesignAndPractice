`timescale 1ns / 1ps

module miniRV_sim();
reg clk = 'b0;
reg rst_n = 'b0;
always #5 clk = ~clk;
miniRV U_miniRV(
    .clk_i(clk),
    .rst_n(rst_n)
);
initial begin
    #2000 rst_n = 'b1;
    #1000000 $finish;
end
endmodule
