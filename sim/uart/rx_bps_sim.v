`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/26 21:43:38
// Design Name: 
// Module Name: rx_bps_sim
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

module rx_bps_sim(
 );

reg clk, rst, count_signal;
wire bps_clk;

initial
	begin
		clk <= 1'b0;
		rst <= 1'b1;
		count_signal <= 1'b0;
	end

always
	begin
		#5
		clk <= ~clk;
	end

always
	begin
		#100
		rst <= 1'b0;
		count_signal <= 1'b1;
	end

rx_bps rx_bps_inst(
	.clk(clk),
	.rst(rst),
	.count_signal(count_signal),
	.bps_clk(bps_clk));
endmodule
