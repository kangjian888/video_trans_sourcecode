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
	output reg data_request, //the module will get new data from FIFO
	input send_enale, //after every cycle output, if the signal on this line is high, we will begin next cycle sending
	output reg tx_ctrl,
	output reg [3:0] phy_txd//the PHY chip
    );

//----------------------------------------------------------------------------------------------------------------------
//The first Part: State Encoding
//The is five state in this module
// -IDLE: There's no data needed to sending through PHY.
// - START: There are more than 1360 Byte in the fifo,then we begin to send the prefix coding.
// - SEND_DATA:Sending data information.
//----------------------------------------------------------------------------------------------------------------------
localparam IDLE = 2'b00,
		   START = 2'b01,
		   SEND_DATA = 2'b11;
 //----------------------------------------------------------------------------------------------------------------------
 //Internal Varibles
 //----------------------------------------------------------------------------------------------------------------------
 reg [1:0] state_reg, state_next;
 reg [10:0] cnt_reg, cnt_next;//the maximum number should be 1350
 reg [7:0] datain_reg, datain_next;
 reg flag_reg, flag_next;//indicate the first four bit or the last four bit in one byte.
	
 reg [3:0] prefix_code [39:0];//include 7*0x55, 1*0xd5, and the mac address.
 initial
 	begin
 		prefix_code[0 ] <= 4'h5;//this is the 7*0x55
 		prefix_code[1 ] <= 4'h5;
 		prefix_code[2 ] <= 4'h5;
 		prefix_code[3 ] <= 4'h5;
 		prefix_code[4 ] <= 4'h5;
 		prefix_code[5 ] <= 4'h5;
 		prefix_code[6 ] <= 4'h5;
 		prefix_code[7 ] <= 4'h5;
 		prefix_code[8 ] <= 4'h5;
 		prefix_code[9 ] <= 4'h5;
 		prefix_code[10] <= 4'h5;
 		prefix_code[11] <= 4'h5;
 		prefix_code[12] <= 4'h5;
 		prefix_code[13] <= 4'h5;
 		prefix_code[14] <= 4'h5;//this is 1*0xd5
 		prefix_code[15] <= 4'hd;
		prefix_code[16] <= 4'h0;//this is objective mac address.Now is the lab big computer address
 		prefix_code[17] <= 4'h3;
 		prefix_code[18] <= 4'hc;
 		prefix_code[19] <= 4'h9;
 		prefix_code[20] <= 4'h3;
 		prefix_code[21] <= 4'h2;
 		prefix_code[22] <= 4'he;
 		prefix_code[23] <= 4'h1;
 		prefix_code[24] <= 4'hc;
 		prefix_code[25] <= 4'he;
 		prefix_code[26] <= 4'h1;
 		prefix_code[27] <= 4'h2;
 		prefix_code[28] <= 4'h0;//this is the source mac address which is the mac address of tx com
 		prefix_code[29] <= 4'h2;     
 		prefix_code[30] <= 4'ha;     
 		prefix_code[31] <= 4'h1;     
 		prefix_code[32] <= 4'h6;     
 		prefix_code[33] <= 4'h0;     
 		prefix_code[34] <= 4'he;     
 		prefix_code[35] <= 4'h5;     
 		prefix_code[36] <= 4'he;     
 		prefix_code[37] <= 4'h0;     
 		prefix_code[38] <= 4'h7;     
 		prefix_code[39] <= 4'ha;     

 	end
 //----------------------------------------------------------------------------------------------------------------------
 //The second Part: sequential logic (synchronous DFF)
 //----------------------------------------------------------------------------------------------------------------------
always @ (posedge clk)
    begin
        if (rst) 
            begin
                state_reg <= IDLE;
                cnt_reg <= 0;
				datain_reg <= 0;
				flag_reg <= 0;
            end
        else 
            begin
				state_reg <= state_next;
				cnt_reg <= cnt_next;
				datain_reg <= datain_next;
				flag_reg <= flag_next;
            end
    end

//-----------------------------------------------------------------------------------------------------------------------
//The Third Part: the next state logic
//-----------------------------------------------------------------------------------------------------------------------
always @ (*)
    begin
        state_next = state_reg;
        cnt_next = cnt_reg;
		datain_next = datain_reg;
		flag_next = flag_reg;
        case(state_reg)
        IDLE:
        	begin
        		if(send_enale == 1'b1)
        		state_next = START;
        		cnt_next = 11'd0;
        	end
        START:
        	begin
				datain_next = datain;//preparing the data, FIFO is the FWFT model
        		if(send_enale == 1'b1)
        			begin
        				if(cnt_reg == 11'd39)
							begin
								state_next = SEND_DATA;
								cnt_next = 0;
								datain_next = datain;
							end 
						else
							begin
								cnt_next = cnt_reg + 1'b1;
							end

					end
        		else
        			begin
        				state_next = IDLE;
           			end
        	end
		SEND_DATA:
			begin
				//we do not detect the sending enable now, because there must enough data in fifo 
				//for one cycle sending
				if(cnt_reg == 1349)
				    begin 
						if(flag_reg == 1'b0)
							begin
								flag_next = 1'b1;
							end
						else
							begin
								flag_next = 1'b0;
								state_next = IDLE;
							end 
					end
				else
					begin
						if(flag_reg == 1'b0)
							begin
								flag_next = 1'b1;
							end
						else
							begin
								flag_next = 1'b0;
								cnt_next =  cnt_reg + 1'b1;
								datain_next = datain; //the data input
							end
					end

			end

    	endcase
    end

//----------------------------------------------------------------------------------------------------------------------------
//The Fourth Part: output logic assignmeng
//---------------------------------------------------------------------------------------------------------------------------
always @ (*)
	begin
		case(state_reg)//if we use combinational logic, state_reg is ok.
		IDLE:
			begin
				tx_ctrl = 1'b0;
				data_request = 1'b0;
				phy_txd = 4'd0;
			end
		START:
			begin
				if(send_enale == 1)
					begin
						if(cnt_reg == 11'd38)
							begin
								tx_ctrl = 1'b1;
								data_request = 1'b1;
								phy_txd = prefix_code[cnt_reg];
							end
						else 
						    begin
						        tx_ctrl = 1'b1;
						        data_request =  1'b0;
						        phy_txd = prefix_code[cnt_reg];
						    end
					end
				else 
				    begin
				        tx_ctrl = 1'b0;
				        data_request = 1'b0;
				        phy_txd = 4'd0;
				    end
			end
		SEND_DATA:
			begin
				if(cnt_reg == 11'd1349)
					begin
						if(flag_reg == 1'b0)
							begin
								phy_txd = datain_reg [3:0];
								data_request = 1'b0;
								tx_ctrl = 1'b1;
							end
						else 
				    		begin
				        		phy_txd = datain_reg [7:4];
				        		data_request = 1'b0;
				        		tx_ctrl = 1'b1;
				    		end
					end
				else 
				    begin
						if(flag_reg == 1'b0)
							begin
								phy_txd = datain_reg [3:0];
								data_request = 1'b1;
								tx_ctrl = 1'b1;
							end
						else 
				    		begin
				        		phy_txd = datain_reg [7:4];
				        		data_request = 1'b0;
				        		tx_ctrl = 1'b1;
				    		end				        
				    end
			end
		default:
			begin
				tx_ctrl = 1'b0;
				data_request = 1'b0;
				phy_txd = 4'd0;
			end
		endcase
	end

endmodule
