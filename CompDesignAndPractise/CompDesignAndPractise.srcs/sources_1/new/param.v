`ifndef CPU_PARAM
`define CPU_PARAM

    // OPCODE
    `define R_TYPE  'b0110011
    `define I_TYPE  'b0010011   // exclude inst-lw/jalr
    `define LW_TYPE 'b0000011   // inst-lw
    `define JR_TYPE 'b1100111   // inst-jalr
    `define S_TYPE  'b0100011
    `define B_TYPE  'b1100011
    `define U_TYPE  'b0110111
    `define J_TYPE  'b1101111

    // NPC_OP
    `define PC4     'b00
    `define B_JMP   'b01
    `define J_JMP   'b10
    `define JR_JMP  'b11
    
    // SEXT_OP
    `define I_SEXT  'b000
    `define S_SEXT  'b001
    `define B_SEXT  'b010
    `define U_SEXT  'b011
    `define J_SEXT  'b100
    
    // ALU_OP
    `define ADD     'b000
    `define SUB     'b001
    `define AND     'b010
    `define OR      'b011
    `define XOR     'b100
    `define SLL     'b101
    `define SRL     'b110
    `define SRA     'b111
    
    // FUNCT3
    `define BEQ     'b100
    `define BNE     'b101
    `define BLT     'b110
    `define BGE     'b111
    
    // BRANCH OPERATION
    `define NOP      'b00
    `define EQUAL    'b01
    `define LESS     'b10
    `define GREATER  'b11
    
    // WD_SEL
    `define ALU_C    'b00
    `define DRAM     'b01
    `define NPC_PC4  'b10
    
`endif