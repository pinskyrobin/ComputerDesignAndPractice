`timescale 1ns / 1ps

// write:clock, read:combine
module RegFile(
    input 			clk,
    input			rst_n,
    input [4:0] 	rR1,
    input [4:0] 	rR2,
    input [4:0] 	wR,
    input [31:0]	wD,
    input 			rf_we,
    output [31:0]   rD1,
    output [31:0]   rD2
    );
    
    integer index = 0;
    reg	[31:0]	register[0:31];
  	
  	assign rD1 = (!rR1) ? 0 : register[rR1];
  	assign rD2 = (!rR2) ? 0 : register[rR2];
  	
	always @ (posedge clk) begin
		// reg0 === 0
		register[0] <= 32'b0;
		if (!rst_n)
            for(index = 0; index < 32; index = index + 1)
                register[index] <= 0;
		else if (rf_we && wR != 0)
			register[wR] <= wD;
	end
endmodule
