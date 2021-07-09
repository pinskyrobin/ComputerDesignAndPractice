`include "param.v"
module ALU(
    input [3:0] alu_op,
    input [31:0] A,
    input [31:0] B,
    output [1:0] ZERO,
    output [31:0] C
    );
	wire signed[31:0]C_0;
	assign C_0 = $signed(A)>>>B[4:0];          //移位操作
	
    assign ZERO = ($signed(A + ~B + 'b1) < 0) ?`LESS:           //Branch操作
                  ((A + ~B + 'b1) == 0)?`EQUAL:
                                        `GREAT;
                                        
    assign C = (alu_op == `ADD)  ?(A + B):              //算术操作
               (alu_op == `SUB)  ?(A + ~B + 'b1):
               (alu_op == `AND)  ?(A & B):
               (alu_op == `OR )  ?(A | B):
               (alu_op == `XOR)  ?(A ^ B):
               (alu_op == `SLL)  ?(A << B[4:0]):
               (alu_op == `SRL)  ?(A >> B[4:0]):
               (alu_op == `SRA)  ?C_0:
               (alu_op == `SEL_B)?(B):
                                 'b0;
endmodule


