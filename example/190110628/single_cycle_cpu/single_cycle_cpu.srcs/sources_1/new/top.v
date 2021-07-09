`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 09:38:11
// Design Name: 
// Module Name: single_cycle_cpu
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


module top(
    input clk,
    input rst_n,
    output debug_wb_have_inst,
    output [31:0] debug_wb_pc,
    output debug_wb_ena,
    output [4:0] debug_wb_reg,
    output [31:0] debug_wb_value
    );
    
    wire clock;


    wire [31:0] PC;
    wire [31:0] PC_4;
    wire [31:0] instruction;
    wire [31:0] NPC;
    wire [31:0] PC_ext;
    wire [31:0] RD1;
    wire [31:0] RD2;
    wire [31:0] sext_number;    //imm from IMM-GEN
    wire [31:0] DMEM_rd;
    wire [31:0] WD;
    wire [31:0] operandB;
    wire [31:0] ALU_result;


    wire [1:0] zero;

    //control signals
    wire [1:0] npc_op;
    wire we_rf;
    wire [2:0] sext_op;
    wire [1:0] wd_sel;
    wire alub_sel;
    wire branch;
    wire dram_we;
    wire [3:0] ALU_mode;

    assign clock = clk;
    //clock set
//    cpu_clk U_cpu_clk(
//        .clk_in1 ( clk ),
//        .clk_out1  ( clock  )
//    );

    //assign debug signals begin
    assign debug_wb_have_inst = 1;
    assign debug_wb_pc = PC;
    assign debug_wb_ena = we_rf;
    assign debug_wb_reg = instruction[11:7];
    assign debug_wb_value = WD;
    //assign debug signals end
    
    inst_mem U_insfetch(
        .a(PC[15:2]),
        .spo(instruction)
     );

    //    wire ram_clk;
    //	assign ram_clk = !clock;
    data_mem U_dataRAM(
        .clk     (clk     ),
        .we ( dram_we ),
        .a    ( ALU_result[15:2]    ),
        .d ( RD2 ),
        .spo  ( DMEM_rd  )
    );
    
    //program counter
    PC U_PC(
        .NPC   ( NPC   ),
        .clk   ( clock   ),
        .rst_n ( rst_n ),
        .PC    ( PC    )
    );
    
//     inst_mem U_insfetch(
//        .a(PC[15:2]),
//        .spo(instruction)
//     );

    //decode the instructions
    idecode U_idecode(
        .clk    ( clock    ),
        .npc_op ( npc_op ),
        .PC     ( PC     ),
        .PC_ext ( sext_number ),
        .branch ( branch ),
        .RD1    ( RD1    ),
        .rst_n  ( rst_n  ),
        .NPC    ( NPC    ),
        .PC_4   ( PC_4   )
    );

    //choose the write data of regfile
    WD_MUX U_WD_MUX(
        .clk(clock),
        .rst_n (rst_n),
        .wd_sel     ( wd_sel     ),
        .U_ext_num (sext_number),
        .ALU_result ( ALU_result ),
        .DMEM_rd    ( DMEM_rd    ),
        .PC_addr    ( PC       ),
        .WD         ( WD         )
    );


    regfile U_regfile(
        .clk   ( clock   ),
        .rD1   ( instruction[19:15]   ),
        .rD2   ( instruction[24:20]   ),
        .wR    ( instruction[11:7]    ),
        .wD    ( WD    ),
        .WE    ( we_rf    ),
        .rst_n ( rst_n ),
        .RD1   ( RD1   ),
        .RD2   ( RD2   )
    );

    imm_gen U_imm_gen(
        .instruction ( instruction[31:7] ),
        .sext_op     ( sext_op     ),
        .ext_number  ( sext_number  )
    );

    ALUB_MUX u_ALUB_MUX(
        .alub_sel ( alub_sel ),
        .RD2      ( RD2      ),
        .imm      ( sext_number      ),
        .operandB  ( operandB  )
    );


    ALU U_ALU(
        .operandA ( RD1 ),
        .operandB ( operandB ),
        .ALU_mode ( ALU_mode ),
        .zero     ( zero     ),
        .ALU_result  ( ALU_result  )
    );


//    wire ram_clk;
//	assign ram_clk = !clock;
//    data_mem U_dataRAM(
//        .clk     ( ram_clk     ),
//        .we ( dram_we ),
//        .a    ( ALU_result[15:2]    ),
//        .d ( RD2 ),
//        .spo  ( DMEM_rd  )
//    );

    control U_control(
        .clk         ( clock         ),
        .instruction ( instruction ),
        .zero        ( zero        ),
        .we_rf       ( we_rf       ),
        .sext_op     ( sext_op     ),
        .wd_sel      ( wd_sel      ),
        .alub_sel    ( alub_sel    ),
        .ALU_mode    ( ALU_mode    ),
        .npc_op      ( npc_op      ),
        .branch      ( branch      ),
        .dram_we     ( dram_we     )
    );


endmodule
