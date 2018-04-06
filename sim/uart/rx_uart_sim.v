`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/27 17:27:41
// Design Name: 
// Module Name: rx_uart_sim
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

`timescale 100ps/1ps

module rx_uart_sim(

    );

reg clk, rst, rx_in, rx_enable_signal;
wire rx_done_signal;
wire [7:0] rx_data;

initial
	begin
		clk <= 1'b0;
		rst <= 1'b1;
		rx_in <= 1'b1;
		rx_enable_signal <= 1'b0;
	end

always
    begin
      #25
      clk <= ~clk;  
    end
always
	begin
		#100
		rst <= 1'b0;
		rx_enable_signal <= 1'b1;
	end
always
	begin
		#100000
		rx_in = 0;
		#10000
		rx_in = 1;
		#10000
		rx_in = 0;
		#10000
		rx_in = 1;
		#10000
		rx_in = 0;
		#10000
		rx_in = 1;
		#10000
		rx_in = 0;
		#10000
		rx_in = 1;
		#10000
		rx_in = 0;
		#10000
		rx_in = 1;
	end

rx_uart rx_uart_inst(
	.rx_in(rx_in),
	.rx_enable_signal(rx_enable_signal),
	.clk(clk),
	.rst(rst),
	.rx_done_signal(rx_done_signal),
	.rx_data(rx_data)
	);
endmodule
