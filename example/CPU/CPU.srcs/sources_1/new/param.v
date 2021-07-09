`ifndef CPU_PARAM
`define CPU_PARAM
 //指令的ALU_OPCODE   
    `define ADD          'b0000
    `define SUB          'b0001
    `define AND          'b0010
    `define OR           'b0011
    `define XOR          'b0100
    `define SLL          'b0101
    `define SRL          'b0110
    `define SRA          'b0111
    `define SEL_B        'b1000
    `define ALU_NONE     'b1111
//指令类型opcode
    `define R_opcode     'b0110011
    `define I_opcode_0   'b0010011
    `define I_opcode_1   'b0000011
    `define I_opcode_2   'b1100111
    `define S_opcode     'b0100011
    `define B_opcode     'b1100011
    `define U_opcode     'b0110111
    `define J_opcode     'b1101111
//SEXT对应不同指令类型的操作码
    `define SEXT_I       'b000
    `define SEXT_S       'b001
    `define SEXT_B       'b010
    `define SEXT_U       'b011
    `define SEXT_J       'b100
    `define SEXT_NONE    'b111
//Branch类型指令对应的编码
    `define BEQ          'b000
    `define BNE          'b001
    `define BLT          'b100
    `define BGE          'b101
//寄存器写回的内容
    `define ALU_C        'b00
    `define DRAM_RD      'b01
    `define NPC_PC_4     'b10
    `define WD_SEL_NONE  'b11
//比较结果
    `define LESS         'b00
    `define EQUAL        'b01
    `define GREAT        'b10
//PC选择
    `define PC_4         'b00
    `define PC_IMM       'b01
    `define RA_IMM       'b10
    `define NPC_NONE     'b11

`endif
