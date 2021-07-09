`timescale 1ns / 1ps

module Branch(
    input [2:0] compare_result,
    input [3:0] funct3,
    output reg  is_branch
    );
    
    always @ (*) begin
        case(funct3)
            `BEQ:
                is_branch = (compare_result == `EQUAL) ? 1 : 0;
            `BNE:
                is_branch = (compare_result == `EQUAL) ? 0 : 1;
            `BLT:
                is_branch = (compare_result == `LESS) ? 1 : 0;
            `BGE:
                is_branch = (compare_result == `GREATER) ? 1 : 0;
            default:
                is_branch = 0;
        endcase
    end
    
endmodule
