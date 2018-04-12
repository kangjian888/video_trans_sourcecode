// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu Apr 12 11:26:02 2018
// Host        : DESKTOP-B3RT09T running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/KANG
//               Jian/Desktop/video_trans_source/ip/pll_25MHZ/pll_25MHZ_stub.v}
// Design      : pll_25MHZ
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module pll_25MHZ(clk_out1, clk_out2, reset, clk_in1_p, clk_in1_n)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,clk_out2,reset,clk_in1_p,clk_in1_n" */;
  output clk_out1;
  output clk_out2;
  input reset;
  input clk_in1_p;
  input clk_in1_n;
endmodule
