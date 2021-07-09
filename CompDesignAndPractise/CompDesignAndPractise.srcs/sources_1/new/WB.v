`timescale 1ns / 1ps

module WB(
    input       [1:0]   wd_sel,
    input       [31:0]  ALU_C,
    input       [31:0]  npc_pc4,
    input       [31:0]  dram_data,
    output  reg [31:0]  wD
    );
    
    always @ (*) begin
        case (wd_sel)
            `ALU_C:
                wD = ALU_C;
            `DRAM:
                wD = dram_data;
            `NPC_PC4:
                wD = npc_pc4;
            default:
                wD = 0;
        endcase
    end    
endmodule
