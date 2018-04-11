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
    input PHY_RX_CLK,
    input SYSCLK_P,
    input SYSCLK_N,
    input reset //system reset
    );


    assign PHY_RESET_B = 1'b1;

    //output of 25mhz
    wire g_clk;
    (* mark_debug="true" *) wire [7:0] rx_data_out;
    (* mark_debug="true" *) wire byte_rxdv;
    (* mark_debug="true" *) wire data_out_valid;
    (* mark_debug="true" *) wire [22:0] status;
    assign PHY_TX_CLK = g_clk;
 pll_25MHZ pll_25MHZ_inst(
    // Clock out ports
    .clk_out1(g_clk),     // output clk_out1,25MHZ
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
endmodule
