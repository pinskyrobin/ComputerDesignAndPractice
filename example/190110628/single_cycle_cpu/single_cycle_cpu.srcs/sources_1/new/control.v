`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/07/01 15:45:46
// Design Name:
// Module Name: control
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module control(input clk,
               input [31:0] instruction,
               input [1:0] zero,            //比较结果，决定分支是否跳转

               output reg we_rf,            //寄存器读写选择
               output reg [2:0] sext_op,    //根据指令选择立即数
               output reg [1:0] wd_sel,     //选择写回寄存器的数据来源
               output reg alub_sel,         //选择传给ALU的数据
               output reg [3:0] ALU_mode,   //ALU操作模式
               output reg [1:0] npc_op,     //choose next pc
               output reg branch,           //jump or not
               output reg dram_we           //enable writing dram or not 
               ); 
    
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction [31:25];
    
    
    always @(*) begin
        case (opcode)
            `R_type:
            begin
                we_rf    <= 1'b1;
                sext_op  <= 3'd0;
                wd_sel   <= 2'b00;
                alub_sel <= 1'b0;
                npc_op   <= `PLUS_4;
                branch <= 1'b0;
                dram_we <= 1'b0;
                case (funct3)
                    3'b000: ALU_mode <= funct7[5] ? `SUB : `ADD; //ADD or SUB
                    3'b111: ALU_mode <= `AND;                    //AND
                    3'b110: ALU_mode <= `OR;                     //OR
                    3'b100: ALU_mode <= `XOR;                    //XOR
                    3'b001: ALU_mode <= `SLL;                    //SLL
                    3'b101: ALU_mode <= funct7[5] ? `SRA : `SRL; //SRL or SRA
                    default: ;
                endcase
            end
            `I_type:
            begin
                we_rf <= 1'b1;
                alub_sel <= 1'b1;
                wd_sel <= 2'b00;
                npc_op   <= `PLUS_4;
                branch <= 1'b0;
                dram_we <= 1'b0;
                case (funct3)
                    3'b000: begin ALU_mode <= `ADD; sext_op <= `I_type_ext; end  //ADDI
                    3'b111: begin ALU_mode <= `AND; sext_op <= `I_type_ext; end  //ANDI
                    3'b110: begin ALU_mode <= `OR;  sext_op <= `I_type_ext; end  //ORI
                    3'b100: begin ALU_mode <= `XOR; sext_op <= `I_type_ext; end  //XORI
                    3'b001: begin 
                            ALU_mode <= `SLL;                      //SLLI
                            sext_op <= `I_type_ext_unsigned;
                            end
                    3'b101: begin 
                            ALU_mode <= funct7[5] ? `SRA : `SRL;   //SRLI or SRAI
                            sext_op <= `I_type_ext_unsigned;
                            end
                    default: ;
                endcase
            end
            `I_type_jalr:
            begin
                sext_op <= `I_type_ext;
                we_rf <= 1'b1;
                alub_sel <= 1'b1;
                wd_sel <= 2'b11;
                ALU_mode <= `ADD;
                npc_op   <= `JUMP_REG;
                branch <= 1'b0;
                dram_we <= 1'b0;
            end
            `I_type_lw:
            begin
                sext_op <= `I_type_ext;
                we_rf <= 1'b1;
                alub_sel <= 1'b1;
                wd_sel <= 2'b01;
                ALU_mode <= `ADD;
                npc_op   <= `PLUS_4;
                branch <= 1'b0;
                dram_we <= 1'b0;
            end
            `S_type:
            begin
                sext_op <= `S_type_ext;
                we_rf <= 1'b0;
                alub_sel <= 1'b1;
                wd_sel <= 2'b10;
                ALU_mode <= `ADD;
                npc_op   <= `PLUS_4;
                branch <= 1'b0;
                dram_we <= 1'b1;
            end
            `B_type:
            begin
                sext_op <= `B_type_ext;
                we_rf <= 1'b0;
                alub_sel <= 1'b0;
                wd_sel <= 2'b10;
                ALU_mode <= `SUB;
                npc_op   <= `BRANCH_CHOOSE;
                dram_we <= 1'b0;
                case (funct3)
                    3'b000: branch <= (zero == `EQUAL)? 1'b1 : 1'b0;
                    3'b001: branch <= (zero == `EQUAL)? 1'b0 : 1'b1;
                    3'b100: branch <= (zero == `LESS)? 1'b1 : 1'b0;
                    3'b101: branch <= ((zero == `EQUAL) || (zero == `GREATER))? 1'b1: 1'b0;
                    default: branch <= 1'b0;
                endcase
            end
            `J_type:
            begin
                sext_op <= `J_type_ext;
                we_rf <= 1'b1;
                alub_sel <= alub_sel;
                wd_sel <= 2'b11;
                ALU_mode <= `ADD;
                npc_op   <= `JUMP;
                branch <= 1'b0;
                dram_we <= 1'b0;
            end
            `U_type:
            begin
                sext_op <= `U_type_ext;
                we_rf <= 1'b1;
                alub_sel <= alub_sel;
                wd_sel <= 2'b10;
                ALU_mode <= ALU_mode;
                npc_op   <= `PLUS_4;
                branch <= 1'b0;
                dram_we <= 1'b0;
            end
            default:;
        endcase
    end
endmodule
