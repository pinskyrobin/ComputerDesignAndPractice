module reg_file(
    input clk,
    input reset,
    input rf_we,
    input [4:0] rR1,
    input [4:0] rR2,
    input [4:0] wR,
    input [31:0] wD,
    output [31:0] rD1,
    output [31:0] rD2
    );
    reg[31:0] rf_reg [31:0];
    integer i = 0;
    //¼Ä´æÆ÷ÒëÂë½á¹û
    assign rD1 = (rR1 == 'b0)? 'b0:rf_reg[rR1];
    assign rD2 = (rR2 == 'b0)? 'b0:rf_reg[rR2];
    //write_back²Ù×÷Ğ´»Ø¼Ä´æÆ÷¶Ñ
    always @(posedge clk or posedge reset)begin
        if(reset)
        begin
            for(i = 0;i < 32;i = i+1)
            begin
                rf_reg[i] = 'b0;
            end
        end 
        else if(rf_we == 'b1)
        begin
            rf_reg[wR] <= (wR == 'b0)?'b0:wD;
        end
    end
endmodule