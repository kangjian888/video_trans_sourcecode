`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/22 19:30:13
// Design Name: 
// Module Name: ethernet_tx_tb
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

`timescale 1 ns / 1 ps
module ethernet_tx_tb;

localparam CLK_PERIOD = 40;//the unit is ns 

reg clk, rst, send_enale;
reg [7:0] datain;
wire data_request, tx_ctrl;
wire [3:0] phy_txd;

ethernet_tx ethernet_tx_inst(
	.clk(clk),//the 25MHZ clock signal
	.datain(datain),//the input of ethernet data
	.rst(rst),//the reset signal
	.data_request(data_request), //the module will get new data from FIFO
	.send_enale(send_enale), //after every cycle output, if the signal on this line is high, we will begin next cycle sending
	.tx_ctrl(tx_ctrl),
	.phy_txd(phy_txd)//the PHY chip
    );

//Clock Generation
initial
	begin
		clk = 1'b0;
		forever #(CLK_PERIOD/2.0) clk = ~clk;
	end

//Input Simulation
initial
	begin
		//reset
		rst = 1'b1;
		send_enale = 1'b0;
		datain = 8'h00;
		#(2*CLK_PERIOD) rst = 1'b0;

		@(negedge clk)
			begin
				send_enale = 1'b1;
				datain = 8'h39;
			end
	end


endmodule
