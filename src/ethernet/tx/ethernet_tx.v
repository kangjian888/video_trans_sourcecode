`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/21 20:23:55
// Design Name: 
// Module Name: ethernet_tx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// The module is used to send fixed number data which is 1360 to the PHY chip. 
//The module add the prefix(8*0x55 and 1*oxd5)and 12 byte mac information to the package and send it out.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ethernet_tx(
	input clk,//the 25MHZ clock signal
	input [7:0] datain,//the input of ethernet data
	input rst,//the reset signal
	input data_valid, //if the data valid is one, the module can get data from fifo or other memory
	input send_enale, //after every cycle output, if the signal on this line is high, we will begin next cycle sending
	output tx_ctrl,
	output [3:0] phy_txd//the PHY chip
    );

//----------------------------------------------------------------------------------------------------------------------
//The first Part: State Encoding
//The is five state in this module
// -IDLE: There's no data needed to sending through PHY
// - START: There are more than 1360 Byte in the fifo
// - MAKE: Generation prefix and mac address
// - SEND_MAC:Sending mac information
// - SEND_DATA:Sending data information
//----------------------------------------------------------------------------------------------------------------------
localparam IDLE = 2'b00,
		   START = 2'b01,
		   SEND_MAC = 2'b10,
		   SEND_DATA = 2'b11;
 //----------------------------------------------------------------------------------------------------------------------
 //Internal Varibles
 //----------------------------------------------------------------------------------------------------------------------
 reg [1:0] state_reg, state_next;
 reg [5:0] cnt_reg, cnt_next;//the maximum number should be 32
 reg [3:0] prefix_code [39:0];//include 7*0x55, 1*0xd5, and the mac address.

 initial
 	begin
 		prefix_code[0] <= 4'h5;
 	end
 //----------------------------------------------------------------------------------------------------------------------
 //The second Part: sequential logic (synchronous DFF)
 //----------------------------------------------------------------------------------------------------------------------
always @ (posedge clk)
    begin
        if (rst) 
            begin
               state_reg <= IDLE;
               cnt_reg <= 4'b0; 
            end
        else 
            begin
				state_reg <= state_next;
				cnt_reg <= cnt_next;                
            end
    end

//-----------------------------------------------------------------------------------------------------------------------
//The Third Part: the next state logic
//-----------------------------------------------------------------------------------------------------------------------
always @ (*)
    begin
        state_next <= state_reg;
        cnt_next <= cnt_reg;
        case(state_reg)
        IDLE:
        	begin
        		if(send_enale == 1'b1)
        		state_next <= START;
        	end
        START:
        	begin
        		if(send_enale == 1'b1)
        			begin
        				if(cnt_reg <= )
        			end
        		else
        			begin
        				state_next <= IDLE;
           			end
        	end
    end
endmodule