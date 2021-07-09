`include "param.v"
module control_logic(
    input clk,
    input reset,
    input [1:0] alu_zero,
    input [6:0] func7,
    input [2:0] func3,
    input [6:0] opcode,
    output reg rf_we,
    output reg dram_we,
    output reg alub_sel,
    output reg [1:0] npc_op,
    output reg [1:0] wd_sel,
    output reg [2:0] sext_op,
    output reg [3:0] alu_op
    );
    always @(*)begin            //根据指令类型设置NPC
        if(reset)
            npc_op = `NPC_NONE;
        else begin
            case(opcode)
                `R_opcode   :npc_op  = `PC_4;
                `I_opcode_0 :npc_op  = `PC_4;
                `I_opcode_1 :npc_op  = `PC_4;
                `I_opcode_2 :npc_op  = `RA_IMM;
                `S_opcode   :npc_op  = `PC_4;
                `B_opcode   :begin
                        if(func3 == `BEQ && alu_zero == `EQUAL)begin
                            npc_op = `PC_IMM;
                        end
                        else if(func3 == `BNE && alu_zero != `EQUAL)begin
                            npc_op = `PC_IMM;
                        end
                        else if(func3 == `BLT && alu_zero == `LESS)begin
                            npc_op = `PC_IMM;
                        end
                        else if(func3 == `BGE && (alu_zero == `GREAT || alu_zero == `EQUAL))begin
                            npc_op = `PC_IMM;
                        end
                        else begin
                            npc_op = `PC_4;
                        end
                    end
                `U_opcode  :npc_op = `PC_4;
                `J_opcode  :npc_op = `PC_IMM;
                default    :npc_op = `NPC_NONE;
            endcase
        end
    end
    
    always @(*)begin                //根据指令的OPCODE设置write_back的内容
        if(reset)
            wd_sel = `WD_SEL_NONE;
        else begin
            case(opcode)
                `R_opcode   :wd_sel = `ALU_C;
                `I_opcode_0 :wd_sel = `ALU_C;
                `I_opcode_1 :wd_sel = `DRAM_RD;
                `I_opcode_2 :wd_sel = `NPC_PC_4;
                `U_opcode   :wd_sel = `ALU_C;
                `J_opcode   :wd_sel = `NPC_PC_4;
                default     :wd_sel = `WD_SEL_NONE;
            endcase
        end
    end
    
    always @(*)begin            //设置reg_file的写使能信号
        if(reset)begin
            rf_we = 'b1;
        end
        else if(opcode == `S_opcode || opcode == `B_opcode)begin
            rf_we = 'b0;
        end
        else begin
            rf_we = 'b1;
        end
    end
    
    always @(*)begin                //根据指令的OPCODE设置立即数生成OPCODE
        if(reset)
            sext_op = `SEXT_NONE;
        else begin
            case(opcode)
                `R_opcode   :sext_op = `SEXT_NONE;
                `I_opcode_0 :sext_op = `SEXT_I;
                `I_opcode_1 :sext_op = `SEXT_I;
                `I_opcode_2 :sext_op = `SEXT_I;
                `S_opcode   :sext_op = `SEXT_S;
                `B_opcode   :sext_op = `SEXT_B;
                `U_opcode   :sext_op = `SEXT_U;
                `J_opcode   :sext_op = `SEXT_J;
                default     :sext_op = `SEXT_NONE;
            endcase
        end
    end
    
    always @(*)begin                //设置alub_sel的值
        if(reset)begin
            alub_sel = 'b0;
        end
        else if(opcode == `I_opcode_0 || opcode == `I_opcode_1 || opcode == `S_opcode || opcode == `U_opcode)begin
            alub_sel = 'b1;
        end
        else begin
            alub_sel = 'b0;
        end
    end
    
    always @(*)begin                //设置ALU的操作码，ALU执行相应的操作
        if(reset)begin
            alu_op = `ALU_NONE;
        end
        else if(opcode == `B_opcode)begin
            alu_op = `SUB;
        end
        else if(opcode == `U_opcode)begin
            alu_op = `SEL_B;
        end
        else begin
            case(func3)
                3'b000 :begin
                    if((opcode == `R_opcode && func7 == 'b0000000)||(opcode == `I_opcode_0))begin
                        alu_op = `ADD;
                    end
                    else if(opcode == `R_opcode && func7 == 'b0100000)begin
                        alu_op = `SUB;
                    end
                    else begin
                        alu_op = `ADD;
                    end
                    end
                3'b010 :alu_op = `ADD;
                3'b111 :alu_op = `AND;
                3'b110 :alu_op = `OR;
                3'b100 :alu_op = `XOR;
                3'b001 :alu_op = `SLL;
                3'b101 :begin
                    if((opcode == `R_opcode || opcode == `I_opcode_0) && func7 == 'b0000000)begin
                        alu_op = `SRL;
                    end
                    else if((opcode == `R_opcode || opcode == `I_opcode_0) && func7 == 'b0100000)begin
                        alu_op = `SRA;
                    end
                    else begin
                        alu_op = `SRL;
                    end
                    end
                default:alu_op = `ALU_NONE;
            endcase
        end
    end
    
    always @(*)begin                //data_memory写使能
        if(reset)begin
            dram_we = 'b0;
        end
        else if(opcode == `S_opcode)begin
            dram_we = 'b1;
        end
        else begin
            dram_we = 'b0;
        end
    end
endmodule