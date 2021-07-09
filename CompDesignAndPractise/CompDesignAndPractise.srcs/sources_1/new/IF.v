`timescale 1ns / 1ps
module IF(
    input              clk,
    input              rst_n,
    input              is_branch,
    input       [1:0]  npc_op,
    input       [31:0] sext,
    input       [31:0] rD1,
    output  reg [31:0] pc,
    output      [31:0] npc_pc4
    );

    wire    [31:0]  npc;
    
    assign npc_pc4 = pc + 4;
    assign npc = (npc_op == `PC4 || (npc_op == `B_JMP && !is_branch)) ? pc + 4 :
                 (npc_op == `B_JMP && is_branch) ? pc + sext :
                 (npc_op == `J_JMP) ? rD1 + sext :
                 (npc_op == `JR_JMP) ?  pc + (sext << 1) : npc;
	
    always @ (posedge clk) begin
        if (!rst_n)     pc <= 'hfffffffc;
        else            pc <= npc;
    end
endmodule
