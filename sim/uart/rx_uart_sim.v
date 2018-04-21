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

`timescale 1ns/1ps

module rx_uart_sim;

//local parameter declaration
localparam CLK_PERIOD = 10.0;

//Interface of the uart_rx
reg clk, rst, rx_in, rx_enable_signal;
wire rx_done_signal;
wire [7:0] rx_data;

//Instantiate the uart_rx
rx_uart rx_uart_inst(
	.rx_in(rx_in),
	.rx_enable_signal(rx_enable_signal),
	.clk(clk),
	.rst(rst),
	.rx_done_signal(rx_done_signal),
	.rx_data(rx_data)
	);
//Generate Clock Signal
initial 
	begin
		clk =  1'b0;
		forever #(CLK_PERIOD/2.0) clk = ~clk;
	end


//Input Simulation
initial
	begin
		//reset
		rst = 1'b1;
		rx_in = 1'b1;
		rx_enable_signal = 1'b0;
		
		//Input simulation begin
		@(posedge clk)
		rst = 1'b0;
		rx_enable_signal = 1'b1;
		rx_in = 1'b1;
		#1000
		rx_in = 1'b0;
		#250
		rx_in = 1'b1;
		#250
		rx_in = 1'b0;
		#250
		rx_in = 1'b1;
		#250
		rx_in = 1'b0;
		#250
		rx_in = 1'b1;
		#250
		rx_in = 1'b0;
		#250
		rx_in = 1'b1;
		#250
		rx_in = 1'b0;
		#250
		rx_in = 1'b1;
		wait(rx_done_signal == 1'b1);#(1000*CLK_PERIOD);
		$finish;
	end
//Output monitor
always @(posedge clk)begin
	if(rx_done_signal) begin
		$display("the recieved letter is %d. It should be 55",rx_data);
	end
end
endmodule
