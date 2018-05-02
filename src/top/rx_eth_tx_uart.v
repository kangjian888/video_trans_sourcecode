`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/08 17:00:48
// Design Name: 
// Module Name: rx_eth_tx_uart
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


 module rx_eth_tx_uart(
    //output PHY_TX_CTRL,
    //output [3:0] PHY_TXD,
    input PHY_RX_CTRL,
    input [3:0] PHY_RXD,
    output PHY_RESET_B,
    output PHY_TX_CLK,
    //output data_out_valid_debug,//for debug
    output full,//for debug
    output uart_tx,//the output of uart interface
    input PHY_RX_CLK,
    input SYSCLK_P,
    input SYSCLK_N,
    input reset //system reset
    );

 	//(*mark_debug = "true"*) wire uart_tx_debug;//for debug
 	//assign uart_tx_debug = uart_tx;//for debug
    assign PHY_RESET_B = 1'b1;
    //assign data_out_valid_debug = data_out_valid;//for debug
    //output of 25mhz
    wire eth_tx_clk;
    wire [7:0] rx_data_out;
    wire byte_rxdv;
    wire data_out_valid;
    wire [22:0] status;
    assign PHY_TX_CLK = eth_tx_clk;
    //used by uart 100mhz
    wire uart_tx_clk;
    wire rd_en;
    wire [7:0] dout;
    wire empty;
 pll_25MHZ pll_25MHZ_inst(
    // Clock out ports
    .clk_out2(uart_tx_clk), //output clk_out2,100mhz
    .clk_out1(eth_tx_clk),     // output clk_out1,25MHZ
    // Status and control signals
    .reset(reset), // the clock is always work
   // Clock in ports
    .clk_in1_p(SYSCLK_P),    // input clk_in1_p
    .clk_in1_n(SYSCLK_N)
    );    // input clk_in1_n

ethernet_recieve ethernet_recieve_inst(
    .rx_data_out(rx_data_out),
    .byte_rxdv(byte_rxdv),
    .phy_rxd(PHY_RXD),
    .phy_rx_ctrl(PHY_RX_CTRL),
    .phy_rx_clk(PHY_RX_CLK),
    .reset(reset),
    .data_out_valid(data_out_valid),
    .status(status)
    // output reg rx_er  //we could ingore it
    );

ex_rx_uart_tx_fifo ex_rx_uart_tx_fifo_inst (//thers's no reset in fifo module
  .wr_clk(PHY_RX_CLK),                // input wire wr_clk
  .rd_clk(uart_tx_clk),                // input wire rd_clk
  .din(rx_data_out),                      // input wire [7 : 0] din
  .wr_en(data_out_valid),                  // input wire wr_en
  .rd_en(rd_en),                  // input wire rd_en
  .dout(dout),                    // output wire [7 : 0] dout
  .full(full),                    // output wire full
  .empty(empty)                  // output wire empty
);

tx_uart tx_uart_inst(
 .clk(uart_tx_clk),
 .rst(reset),
 .tx_out(uart_tx),
 .tx_enable_signal(empty),//if the fifo is not empty, the signal will be sented continously
 .tx_done_signal(rd_en),//low signal active
 .tx_data(dout)
);
endmodule
