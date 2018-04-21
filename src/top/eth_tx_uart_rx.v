`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/20 08:35:22
// Design Name: 
// Module Name: eth_tx_uart_rx
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


module eth_tx_uart_rx(
	input SYSCLK_N,
	input SYSCLK_P,
	input reset,//system reset
	input uart_rx,//the input of uart interface
	output PHY_TX_CLK,
	output PHY_RESET_B,
	output rx_done_signal_out,//for debug
	output [7:0] din_out//for debug
    );
 assign PHY_RESET_B = 1'b1;
 assign PHY_TX_CLK = eth_tx_clk;
 assign rx_done_signal_out = rx_done_signal;
 assign din_out = din;
 wire eth_tx_clk;
 wire uart_rx_clk;
 pll_25MHZ pll_25MHZ_inst(
    // Clock out ports
    .clk_out1(eth_tx_clk),     // output clk_out1,25mhz
    .clk_out2(uart_rx_clk),     // output clk_out2,used by uart recieved module
    // Status and control signals
    .reset(reset), // input reset
   // Clock in ports
    .clk_in1_p(SYSCLK_P),    // input clk_in1_p
    .clk_in1_n(SYSCLK_N)
    );    // input clk_in1_n
 wire rx_enable_signal;
 wire [7:0] din;
 wire rx_done_signal;
 assign rx_enable_signal = 1'b1;
 rx_uart rx_uart_inst(
 .clk(uart_rx_clk),
 .rst(reset),
 .rx_in(uart_rx),
 .rx_enable_signal(rx_enable_signal),
 .rx_done_signal(rx_done_signal),
 .rx_data(din)
   );
  (*mark_debug = "true"*) wire [7:0] dout;//the data to ethernet tranciver module
  (*mark_debug = "true"*) wire full;
  (*mark_debug = "true"*) wire empty;
  (*mark_debug = "true"*) wire prog_empty;
 ex_tx_uart_rx_fifo ex_tx_uart_rx_fifo_inst (
  .wr_clk(uart_rx_clk),          // input wire wr_clk
  .rd_clk(eth_tx_clk),          // input wire rd_clk
  .din(din),                // input wire [7 : 0] din
  .wr_en(rx_done_signal),            // input wire wr_en
  .rd_en(rd_en),            // input wire rd_en
  .dout(dout),              // output wire [7 : 0] dout
  .full(full),              // output wire full
  .empty(empty),            // output wire empty
  .prog_empty(prog_empty)  // output wire prog_empty
);
endmodule
