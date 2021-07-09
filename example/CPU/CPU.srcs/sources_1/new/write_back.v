`include "param.v"
module write_back(          //Ð´»ØÑ¡Ôñ
    input [1:0] wd_sel,
    input [31:0] alu_c,
    input [31:0] dram_rd,
    input [31:0] npc_pc_4,
    output [31:0] wD
    );
    assign wD = (wd_sel == `ALU_C) ? alu_c:(wd_sel == `DRAM_RD) ? dram_rd:(wd_sel == `NPC_PC_4) ? npc_pc_4:'b0;
endmodule