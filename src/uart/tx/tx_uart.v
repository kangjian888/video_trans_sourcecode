`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/28 13:56:10
// Design Name: 
// Module Name: tx_uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// In this module, our clock frequency is 100Mhz, the default boot rate is 20Mbps
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tx_uart(
    input clk,
    input rst,
    output tx_out,
    input tx_enable_signal,
    output tx_done_signal,
    input [7:0] tx_data
    );
wire bps_clk_half;
wire bps_clk_total;
tx_bps 
#(.bps(4_000_000))
tx_bps_inst(
	.clk(clk),
	.rst(rst),
	.count_signal(tx_enable_signal),
	.bps_clk_total(bps_clk_total)
	);

tx_control tx_control_inst(
	.clk(clk),
	.rst(rst),
	.tx_enable_signal(tx_enable_signal),
	.tx_data(tx_data),
	.bps_clk_total(bps_clk_total),
	.tx_out(tx_out),
	.tx_done_signal(tx_done_signal)
	);
endmodule
