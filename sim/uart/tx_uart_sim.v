`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/28 14:14:44
// Design Name: 
// Module Name: tx_uart_sim
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
module tx_uart_sim(

    );

reg clk, rst, tx_enable_signal;
wire tx_done_signal;
wire tx_out;
reg [7:0] tx_data;

initial
	begin
		clk <= 1'b0;
		rst <= 1'b1;
		tx_enable_signal <= 1'b0;
		tx_data <=8'b01010101;
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
		tx_enable_signal <= 1'b1;
	end

tx_uart tx_uart_inst(
	.clk(clk),
	.rst(rst),
	.tx_enable_signal(tx_enable_signal),
	.tx_done_signal(tx_done_signal),
	.tx_data(tx_data),
	.tx_out(tx_out)
	);
endmodule
