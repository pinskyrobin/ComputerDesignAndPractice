`timescale 1ns / 1ps

module Control(
    input            clk,
    input            rst_n,
    input [2:0]      funct3,
    input [6:0]      funct7,
    input [6:0]      opcode,
    output           rf_we,
    output           dram_we,
    output           alua_sel,
    output           alub_sel,
    output reg [1:0] npc_op,
    output reg [1:0] wd_sel,
    output reg [2:0] sext_op,
    output reg [2:0] alu_op
    );
        
    // rf_we
    assign rf_we = (opcode == `S_TYPE || opcode == `B_TYPE) ? 0 : 1; 
    
    // alu_sel
    assign alua_sel = (opcode == `B_TYPE || opcode == `J_TYPE) ? 1 : 0;
    assign alua_sel = (opcode == `B_TYPE || opcode == `R_TYPE) ? 0 : 1;
    
    // dram_we
    assign dram_we = (opcode == `S_TYPE) ? 1: 0;
    
    // npc_op
    always @ (*) begin
        case (opcode)
            `R_TYPE, `I_TYPE, `LW_TYPE, `S_TYPE, `U_TYPE:
                npc_op = `PC4;
            `B_TYPE:
                npc_op = `B_JMP;
            `J_TYPE:
                npc_op = `J_JMP;
            `JR_TYPE:
                npc_op = `JR_JMP;
            default:
                npc_op = `PC4;
        endcase
    end
    
    // sext_op
    always @ (*) begin
        case (opcode)
            `I_TYPE, `LW_TYPE, `JR_TYPE:
                sext_op = `I_SEXT;
            `S_TYPE:
                sext_op = `S_SEXT;
            `B_TYPE:
                sext_op = `B_SEXT;
            `U_TYPE:
                sext_op = `U_SEXT;
            `J_TYPE:
                sext_op = `J_SEXT;
            default:
                sext_op = 'b111;
        endcase
    end

    // alu_op
    always @ (*) begin
        if      (opcode == `B_TYPE)  alu_op = `SUB;
        else if (opcode == `U_TYPE)  alu_op = `SLL;
        else if (opcode == `S_TYPE || opcode == `J_TYPE || opcode == `JR_TYPE || opcode == `LW_TYPE) alu_op = `ADD;
        else if (opcode == `R_TYPE) 
            case (funct3)
                'b000:
                    alu_op = (opcode == `R_TYPE && funct7 == 'b010_0000) ? `SUB : `ADD;
                'b111:
                    alu_op = `AND;
                'b110:
                    alu_op = `OR;
                'b100:
                    alu_op = `XOR;
                'b001:
                    alu_op = `SLL;
                'b101:
                    alu_op = (funct7 == 'b000_0000) ? `SRL : `SRA;
                default:
                    alu_op = 'b000;
            endcase
    end
    
    // wd_sel
    always @ (*) begin
        case (opcode)
            `R_TYPE, `I_TYPE, `U_TYPE, `J_TYPE:
                wd_sel = `ALU_C;
            `LW_TYPE:
                wd_sel = `DRAM;
            `JR_TYPE:
                wd_sel = `NPC_PC4;
            default:
                wd_sel = `ALU_C;
        endcase
    end

endmodule
