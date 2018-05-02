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
	input reset,//system reset, high level is effect
	input uart_rx,//the input of uart interface
	output PHY_TX_CLK,
	output PHY_RESET_B,
	output PHY_TX_CTRL,
	output [3:0] PHY_TXD
	//output rx_done_signal_out,//for debug
	//output [7:0] din_out//for debug
    );
 //assign PHY_RESET_B = 1'b1;//previous experiment
 assign PHY_RESET_B = ~reset;
 assign PHY_TX_CLK = eth_tx_clk;
 //assign rx_done_signal_out = rx_done_signal;//for debug
 //assign din_out = din;//for debug
 //(*mark_debug = "true"*) wire uart_rx_debug;//for debug
 //assign uart_rx_debug = uart_rx;
 wire eth_tx_clk;
 wire uart_rx_clk;
 //wire uart_rx_n;//invert the uart_rx
 //assign uart_rx_n = ~uart_rx;
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
  wire [7:0] dout;//the data to ethernet tranciver module
  wire full;
  wire [16:0] rd_data_count;
  wire send_enale;
  wire empty;
  wire data_request;
  //assign data_request = 1'b0;//for debug
 ex_tx_uart_rx_fifo ex_tx_uart_rx_fifo_inst (
  .wr_clk(uart_rx_clk),          // input wire wr_clk
  .rd_clk(eth_tx_clk),          // input wire rd_clk
  .din(din),                // input wire [7 : 0] din
  .wr_en(rx_done_signal),            // input wire wr_en
  .rd_en(data_request),            // input wire rd_en
  .dout(dout),              // output wire [7 : 0] dout
  .full(full),              // output wire full
  .empty(empty),            // output wire empty
  .rd_data_count(rd_data_count)  // output wire [16 : 0] rd_data_count
);
 assign send_enale = (rd_data_count >= 1350) ? 1'b1 : 1'b0;//this is very important, you must prove the number of package is enough

  //wire PHY_TX_CTRL_d;//for debug
  //assign PHY_TX_CTRL_d = PHY_TX_CTRL;
  //wire [3:0] PHY_TXD_d;//for debug
  //assign PHY_TXD_d = PHY_TXD;
 ethernet_tx ethernet_tx_inst(
  .clk(eth_tx_clk),//the 25MHZ clock signal
  .datain(dout),//the input of ethernet data
  .rst(reset),//the reset signal
  .data_request(data_request), //the module will get new data from FIFO
  .send_enale(send_enale), //after every cycle output, if the signal on this line is high, we will begin next cycle sending
  .tx_ctrl(PHY_TX_CTRL),//the PHY CHIP
  .phy_txd(PHY_TXD)//the PHY chip
    );


endmodule
