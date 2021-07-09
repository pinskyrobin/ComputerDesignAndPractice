`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 14:51:07
// Design Name: 
// Module Name: mini_rv
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


module mini_rv(
    input clk,
    input rst_n,
    input  wire       busy   ,
    
    output wire        led0_en,
    output wire        led1_en,
    output wire        led2_en,
    output wire        led3_en,
    output wire        led4_en,
    output wire        led5_en,
    output wire        led6_en,
    output wire        led7_en,
    output wire        led_ca ,
    output wire        led_cb ,
    output wire        led_cc ,
    output wire        led_cd ,
    output wire        led_ce ,
    output wire        led_cf ,
    output wire        led_cg ,
    output wire        led_dp
    );
    
    
    wire [31:0] debug_wb_pc;
    
    top U_top (
        .clk (clk),
        .rst_n (rst_n),
        .debug_wb_pc (debug_wb_pc)
    );
    
    display display_U (
    .clk (clk),
    .rst_n (rst_n),
    .busy   (busy),
    .PC     (debug_wb_pc),
    .led0_en(led0_en),
    .led1_en(led1_en),
    .led2_en(led2_en),
    .led3_en(led3_en),
    .led4_en(led4_en),
    .led5_en(led5_en),
    .led6_en(led6_en),
    .led7_en(led7_en),
    .led_ca(led_ca),
    .led_cb(led_cb),
    .led_cc(led_cc),
    .led_cd(led_cd),
    .led_ce(led_ce),
    .led_cf (led_cf) ,
    .led_cg(led_cg),
    .led_dp(led_dp)
    );
    
endmodule
