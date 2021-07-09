`timescale 1ns / 1ps

module ALU_EX(
    input   [2:0]   alu_op,
    input   [31:0]  ALU_A,
    input   [31:0]  ALU_B,
    output  [1:0]   compare_result,
    output  reg [31:0] ALU_C
    );
    
    
    assign compare_result = ((ALU_A + ~ALU_B + 1) == 0) ? `EQUAL :
                            ((ALU_A + ~ALU_B + 1) < 0) ? `LESS :
                            ((ALU_A + ~ALU_B + 1) > 0) ? `GREATER : `NOP;
    
    always @ (*) begin
		case (alu_op)
			`ADD:
				 ALU_C = ALU_A + ALU_B;
			`SUB:
				 ALU_C = ALU_A - ALU_B;
			`AND:
				 ALU_C = ALU_A & ALU_B;
			`OR:
				 ALU_C = ALU_A | ALU_B;
			`XOR:
				 ALU_C = ALU_A ^ ALU_B;
			`SLL:
			     ALU_C = ALU_A << ALU_B[4:0];
			`SRL:
			     ALU_C = ALU_A >> ALU_B[4:0];
			`SRA:
			    case(ALU_B[4:0])
			         0:   ALU_C = ALU_A;
			         1:   ALU_C = {{1{ALU_C[31]}}, ALU_A[30:0]};
			         2:   ALU_C = {{2{ALU_C[31]}}, ALU_A[29:0]};
			         3:   ALU_C = {{3{ALU_C[31]}}, ALU_A[28:0]};
			         4:   ALU_C = {{4{ALU_C[31]}}, ALU_A[27:0]};
			         5:   ALU_C = {{5{ALU_C[31]}}, ALU_A[26:0]};
			         6:   ALU_C = {{6{ALU_C[31]}}, ALU_A[25:0]};
			         7:   ALU_C = {{7{ALU_C[31]}}, ALU_A[24:0]};
			         8:   ALU_C = {{8{ALU_C[31]}}, ALU_A[23:0]};
			         9:   ALU_C = {{9{ALU_C[31]}}, ALU_A[22:0]};
			         10:  ALU_C = {{10{ALU_C[31]}}, ALU_A[21:0]};
			         11:  ALU_C = {{11{ALU_C[31]}}, ALU_A[20:0]};
			         12:  ALU_C = {{12{ALU_C[31]}}, ALU_A[19:0]};
			         13:  ALU_C = {{13{ALU_C[31]}}, ALU_A[18:0]};
			         14:  ALU_C = {{14{ALU_C[31]}}, ALU_A[17:0]};
			         15:  ALU_C = {{15{ALU_C[31]}}, ALU_A[16:0]};
			         16:  ALU_C = {{16{ALU_C[31]}}, ALU_A[15:0]};
			         17:  ALU_C = {{17{ALU_C[31]}}, ALU_A[14:0]};
			         18:  ALU_C = {{18{ALU_C[31]}}, ALU_A[13:0]};
			         19:  ALU_C = {{19{ALU_C[31]}}, ALU_A[12:0]};
			         20:  ALU_C = {{20{ALU_C[31]}}, ALU_A[11:0]};
			         21:  ALU_C = {{21{ALU_C[31]}}, ALU_A[10:0]};
			         22:  ALU_C = {{22{ALU_C[31]}}, ALU_A[9:0]};
			         23:  ALU_C = {{23{ALU_C[31]}}, ALU_A[8:0]};
			         24:  ALU_C = {{24{ALU_C[31]}}, ALU_A[7:0]};
			         25:  ALU_C = {{25{ALU_C[31]}}, ALU_A[6:0]};
			         26:  ALU_C = {{26{ALU_C[31]}}, ALU_A[5:0]};
			         27:  ALU_C = {{27{ALU_C[31]}}, ALU_A[4:0]};
			         28:  ALU_C = {{28{ALU_C[31]}}, ALU_A[3:0]};
			         29:  ALU_C = {{29{ALU_C[31]}}, ALU_A[2:0]};
			         30:  ALU_C = {{30{ALU_C[31]}}, ALU_A[1:0]};
			         31:  ALU_C = {{31{ALU_C[31]}}, ALU_A[0]};
			         default:
			              ALU_C = {32{ALU_C[31]}};
			    endcase
			default: ;
		endcase
	end
    
endmodule
