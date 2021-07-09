`include "param.v"
module instruction_fetch(
    input cpu_clk, 
    input rst_i,
    input [1:0] npc_op,
    input [31:0] imm,
    input [31:0] ra,
    output reg[31:0] pc,
    output [31:0] npc_pc_4
    );
    /* verilator lint_off UNOPTFLAT */wire [31:0] npc;
    //NPC处理
    assign npc_pc_4 = pc + 3'b100;
    assign npc = (npc_op == `PC_4) ? pc + 3'b100:(npc_op == `PC_IMM) ? pc + imm:(npc_op == `RA_IMM) ? (ra + imm) & ~1: npc;
    //PC处理
    always @(posedge cpu_clk or posedge rst_i)begin
        if(rst_i)begin
            pc <= 'hfffffffc;
        end
        else begin
            pc <= npc;
        end
    end
endmodule
