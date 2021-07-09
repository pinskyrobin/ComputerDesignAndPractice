`include "param.v"

module ALU_EX(
    input   [3:0]   alu_op,
    input   [31:0]  ALU_A,
    input   [31:0]  ALU_B,
    output  [1:0]   compare_result,
    output  reg [31:0] ALU_C
    );
    
    
    assign compare_result = ((ALU_A + ~ALU_B + 1) == 0) ? `EQUAL :
                             ((ALU_A + ~ALU_B + 1) > 'h8000_000) ? `LESS :
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
			         'd0:   ALU_C = ALU_A;
			         'd1:   ALU_C = {{1{ALU_A[31]}}, ALU_A[31:1]};
			         'd2:   ALU_C = {{2{ALU_A[31]}}, ALU_A[31:2]};
			         'd3:   ALU_C = {{3{ALU_A[31]}}, ALU_A[31:3]};
			         'd4:   ALU_C = {{4{ALU_A[31]}}, ALU_A[31:4]};
			         'd5:   ALU_C = {{5{ALU_A[31]}}, ALU_A[31:5]};
			         'd6:   ALU_C = {{6{ALU_A[31]}}, ALU_A[31:6]};
			         'd7:   ALU_C = {{7{ALU_A[31]}}, ALU_A[31:7]};
			         'd8:   ALU_C = {{8{ALU_A[31]}}, ALU_A[31:8]};
			         'd9:   ALU_C = {{9{ALU_A[31]}}, ALU_A[31:9]};
			         'd10:  ALU_C = {{10{ALU_A[31]}}, ALU_A[31:10]};
			         'd11:  ALU_C = {{11{ALU_A[31]}}, ALU_A[31:11]};
			         'd12:  ALU_C = {{12{ALU_A[31]}}, ALU_A[31:12]};
			         'd13:  ALU_C = {{13{ALU_A[31]}}, ALU_A[31:13]};
			         'd14:  ALU_C = {{14{ALU_A[31]}}, ALU_A[31:14]};
			         'd15:  ALU_C = {{15{ALU_A[31]}}, ALU_A[31:15]};
			         'd16:  ALU_C = {{16{ALU_A[31]}}, ALU_A[31:16]};
			         'd17:  ALU_C = {{17{ALU_A[31]}}, ALU_A[31:17]};
			         'd18:  ALU_C = {{18{ALU_A[31]}}, ALU_A[31:18]};
			         'd19:  ALU_C = {{19{ALU_A[31]}}, ALU_A[31:19]};
			         'd20:  ALU_C = {{20{ALU_A[31]}}, ALU_A[31:20]};
			         'd21:  ALU_C = {{21{ALU_A[31]}}, ALU_A[31:21]};
			         'd22:  ALU_C = {{22{ALU_A[31]}}, ALU_A[31:22]};
			         'd23:  ALU_C = {{23{ALU_A[31]}}, ALU_A[31:23]};
			         'd24:  ALU_C = {{24{ALU_A[31]}}, ALU_A[31:24]};
			         'd25:  ALU_C = {{25{ALU_A[31]}}, ALU_A[31:25]};
			         'd26:  ALU_C = {{26{ALU_A[31]}}, ALU_A[31:26]};
			         'd27:  ALU_C = {{27{ALU_A[31]}}, ALU_A[31:27]};
			         'd28:  ALU_C = {{28{ALU_A[31]}}, ALU_A[31:28]};
			         'd29:  ALU_C = {{29{ALU_A[31]}}, ALU_A[31:29]};
			         'd30:  ALU_C = {{30{ALU_A[31]}}, ALU_A[31:30]};
			         'd31:  ALU_C = {{31{ALU_A[31]}}, ALU_A[31]};
			         default:
			              ALU_C = {32{ALU_C[31]}};
			    endcase
			`LUI:
			     ALU_C = ALU_B;
			default: ;
		endcase
	end
    
endmodule
