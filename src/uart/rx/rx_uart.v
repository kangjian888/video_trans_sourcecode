`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/27 17:08:38
// Design Name: 
// Module Name: rx_uart
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


module rx_uart(
    input clk,
    input rst,
    input rx_in,
    input rx_enable_signal,
    output rx_done_signal,
    output [7:0] rx_data
    );

wire high_to_low_signal;

detect dectect_inst(
	.clk(clk),
	.rst(rst),
	.rx_in(rx_in),
	.high_to_low_signal(high_to_low_signal)
	);

wire bps_clk_half;
wire bps_clk_total;
wire count_signal;

rx_bps 
	#(
		.bps(4_000_000)
	 )
rx_bps_inst(
	.clk(clk),
	.rst(rst),
	.count_signal(count_signal),
	.bps_clk_half(bps_clk_half),
	.bps_clk_total(bps_clk_total)
	);

rx_control rx_control_inst(
	.clk(clk),
	.rst(rst),
	.rx_in(rx_in),
	.high_to_low_signal(high_to_low_signal),
	.bps_clk_total(bps_clk_total),
	.bps_clk_half(bps_clk_half),
	.rx_enable_signal(rx_enable_signal),
	.count_signal(count_signal),
	.rx_data(rx_data),
	.rx_done_signal(rx_done_signal)
	);
endmodule
