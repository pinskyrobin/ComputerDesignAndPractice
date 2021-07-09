module IROM(
    input [31:0] addr,
    output [31:0] inst
    );
    inst_mem imem(
        .a    (addr[15:2]),
        .spo  (inst)
    );
endmodule
