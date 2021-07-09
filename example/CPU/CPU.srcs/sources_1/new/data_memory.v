module data_memory(
    input clk,
    input dram_we,
    input [31:0] addr,
    input [31:0] din,
    output [31:0] rd
    );
    wire dram_clk;
    assign dram_clk = ~clk;
    data_mem dmem(
        .clk (dram_clk),
        .a   (addr[15:2]),
        .spo (rd),
        .we  (dram_we),
        .d   (din)
    );
endmodule