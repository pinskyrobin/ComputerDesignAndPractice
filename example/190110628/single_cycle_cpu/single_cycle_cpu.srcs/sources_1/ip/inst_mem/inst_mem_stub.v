// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Jul  6 18:15:52 2021
// Host        : 614-12 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/190110628/single_cycle_cpu/single_cycle_cpu.srcs/sources_1/ip/inst_mem/inst_mem_stub.v
// Design      : inst_mem
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.3" *)
module inst_mem(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[15:0],spo[31:0]" */;
  input [15:0]a;
  output [31:0]spo;
endmodule
