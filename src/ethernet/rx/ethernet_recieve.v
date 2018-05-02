`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/08 17:43:17
// Design Name: 
// Module Name: ip_recieve
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


module ethernet_recieve(
    output reg [7:0] rx_data_out,
    output reg byte_rxdv,
    output reg data_out_valid,
    output [22:0] status,//for debug, see the status of the FSM
    input [3:0] phy_rxd,
    input phy_rx_ctrl,
    input phy_rx_clk,
    input reset
    // output reg rx_er  //we could ingore it
    );

parameter IDLE=22'd1,
SIX_55_1=23'd2,
SIX_55_2=23'd4,
SIX_55_3=23'd8,
SIX_55_4=23'd16,
SIX_55_5=23'd32,
SIX_55_6=23'd64,
SIX_55_7=23'd128,
SPD_D5=23'd256,
RX_BOARD_MAC_1=23'd512,
RX_BOARD_MAC_2=23'd1024,
RX_BOARD_MAC_3=23'd2048,
RX_BOARD_MAC_4=23'd4096,
RX_BOARD_MAC_5=23'd8192,
RX_BOARD_MAC_6=23'd16384,
RX_PC_MAC_1=23'd32768,
RX_PC_MAC_2=23'd65536,
RX_PC_MAC_3=23'd131072,
RX_PC_MAC_4=23'd262144,
RX_PC_MAC_5=23'd524288,
RX_PC_MAC_6=23'd1048576,
RX_DATA=23'd2097152,
RX_FINISH=23'd4194304;
reg [7:0] mybyte;
reg sig;
reg [47:0] board_mac;
reg [47:0] pc_mac;
reg [10:0] package_byte_counter;//use for debug, check how many bytes in one package
reg mac_matched;//the flag showing whether the mac address of the package is matched with the board mac address.
always @ (posedge phy_rx_clk)
    begin
        if(phy_rx_ctrl) begin
        	mybyte <= {phy_rxd,mybyte[7:4]};
        	sig = ~sig;
        end
        else begin
        	mybyte <= mybyte;
        	sig = 1'b0;
        end
    end

reg [7:0] bytedate;
always @ (posedge phy_rx_clk)
    begin
      if(sig&&phy_rx_ctrl) begin
      bytedate <= {phy_rxd,mybyte[7:4]};
      end  
      else if(!phy_rx_ctrl)
      bytedate <= 8'd0;
    end

//generate byte recieve signal
reg byte_sig_t,byte_sig;
reg byte_rxdv_t;
always @ (posedge phy_rx_clk)
    begin
        byte_sig_t <= sig;
        byte_sig <= byte_sig_t;

        byte_rxdv_t <= phy_rx_ctrl;
        byte_rxdv <= byte_rxdv_t;
    end


//if we do not add any protocol in this module
//assign rx_data_out = bytedate;

reg [22:0] current_state, next_state;//check whether the bit numbers are enough
assign status = current_state;
always @ (posedge phy_rx_clk or posedge reset)
    begin
        if(reset)
            begin
                current_state <= IDLE;
            end   
        else 
            begin
                current_state <= next_state;
            end
    end

always @ (*)//combinational logic
    begin
        case (current_state) 
             IDLE://the idle state should reset every value
                 begin
                     if(byte_rxdv&&!byte_sig)
                        begin
                            if(bytedate ==8'h55)
                            next_state <= SIX_55_1;
                            else 
                            next_state <= IDLE;
                        end
                      else
                      	next_state <= IDLE;
                 end
             SIX_55_1:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    begin
                        if(bytedate ==8'h55)
                        next_state <= SIX_55_2;
                        else 
                        next_state <=IDLE;
                    end
                    else if(!byte_rxdv)
                        next_state <= IDLE;
                    else 
                        next_state <= current_state;                    
                 end
             SIX_55_2:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    begin
                        if(bytedate ==8'h55)
                        next_state <= SIX_55_3;
                        else 
                        next_state <= IDLE;
                    end
                    else if(!byte_rxdv)
                        next_state <= IDLE;
                    else 
                        next_state <= current_state;                    
                 end
             SIX_55_3:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    begin
                        if(bytedate ==8'h55)
                        next_state <= SIX_55_4;
                        else 
                        next_state <=IDLE;
                    end
                    else if(!byte_rxdv)
                        next_state <= IDLE;
                    else 
                        next_state <= current_state;                    
                 end
             SIX_55_4:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    begin
                        if(bytedate ==8'h55)
                        next_state <= SIX_55_5;
                        else 
                        next_state <=IDLE;
                    end
                    else if(!byte_rxdv)
                        next_state <= IDLE;
                    else 
                        next_state <= current_state;                    
                 end
             SIX_55_5:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    begin
                        if(bytedate ==8'h55)
                        next_state <= SIX_55_6;
                        else 
                        next_state <= IDLE;
                    end
                    else if(!byte_rxdv)
                        next_state <= IDLE;
                    else 
                        next_state <= current_state;                    
                 end
             SIX_55_6:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    begin
                        if(bytedate ==8'h55)
                        next_state <= SIX_55_7;
                        else 
                        next_state <= IDLE;
                    end
                    else if(!byte_rxdv)
                        next_state <= IDLE;
                    else 
                        next_state <= current_state;                    
                 end
             SIX_55_7:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    begin
                        if(bytedate ==8'hd5)
                        next_state <= SPD_D5;
                        else 
                        next_state <= IDLE;
                    end
                    else if(!byte_rxdv)
                        next_state <= IDLE;
                    else 
                        next_state <= current_state;                    
                 end
             SPD_D5:
                 begin
                    if(byte_rxdv&&!byte_sig)
                        next_state <= RX_BOARD_MAC_1;
                    else if(!byte_rxdv)
                        next_state <= IDLE;
                    else 
                        next_state <= current_state;                    
                 end
             RX_BOARD_MAC_1:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_BOARD_MAC_2;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_BOARD_MAC_2:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_BOARD_MAC_3;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_BOARD_MAC_3:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_BOARD_MAC_4;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_BOARD_MAC_4:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_BOARD_MAC_5;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_BOARD_MAC_5:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_BOARD_MAC_6;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_BOARD_MAC_6:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_PC_MAC_1;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_PC_MAC_1:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_PC_MAC_2;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_PC_MAC_2:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_PC_MAC_3;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_PC_MAC_3:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_PC_MAC_4;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_PC_MAC_4:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_PC_MAC_5;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_PC_MAC_5:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_PC_MAC_6;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_PC_MAC_6:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_DATA;
                    else if(!byte_rxdv)
                    next_state <= IDLE;
                    else 
                    next_state <= current_state; 
                 end
             RX_DATA:
                 begin
                    if(byte_rxdv&&!byte_sig)
                    next_state <= RX_DATA;
                    else if(!byte_rxdv)
                    next_state <= RX_FINISH;
                    else 
                    next_state <= current_state;                    
                 end
             RX_FINISH:
                 begin 
                    next_state <= IDLE;                    
                 end
             default:
                 begin
                    next_state <= IDLE;
                 end
         endcase 
    end
always @ (posedge phy_rx_clk)
    begin
        case (next_state) 
            IDLE:
                begin
                   board_mac <= 48'b0;
                   pc_mac <= 48'b0;
                   rx_data_out <= 8'b0;
                   mac_matched <= 1'b0;
                end

            RX_BOARD_MAC_1:
                begin
                   if(byte_rxdv&&!byte_sig)
                   board_mac <= {board_mac[39:0],bytedate};
                   else 
                   board_mac <= board_mac;
                end
            RX_BOARD_MAC_2:
                begin
                   if(byte_rxdv&&!byte_sig)
                   board_mac <= {board_mac[39:0],bytedate};
                   else 
                   board_mac <= board_mac;
                end
            RX_BOARD_MAC_3:
                begin
                   if(byte_rxdv&&!byte_sig)
                   board_mac <= {board_mac[39:0],bytedate};
                   else 
                   board_mac <= board_mac;
                end
            RX_BOARD_MAC_4:
                begin
                   if(byte_rxdv&&!byte_sig)
                   board_mac <= {board_mac[39:0],bytedate};
                   else 
                   board_mac <= board_mac;
                end
            RX_BOARD_MAC_5:
                begin
                   if(byte_rxdv&&!byte_sig)
                   board_mac <= {board_mac[39:0],bytedate};
                   else 
                   board_mac <= board_mac;
                end
            RX_BOARD_MAC_6:
                begin
                   if(byte_rxdv&&!byte_sig)
                   board_mac <= {board_mac[39:0],bytedate};
                   else 
                   board_mac <= board_mac;
                end
            RX_PC_MAC_1:
                begin
                   if(board_mac == 48'h309c231eec21)//the mac address of the board. you could modify it by yourself
                   mac_matched <= 1'b1;
                   else 
                   mac_matched <= 1'b0;
                   if(byte_rxdv&&!byte_sig)
                   pc_mac <= {pc_mac[39:0],bytedate};
                   else 
                   pc_mac <= pc_mac;
                end
            RX_PC_MAC_2:
                begin
                   if(byte_rxdv&&!byte_sig)
                   pc_mac <= {pc_mac[39:0],bytedate};
                   else 
                   pc_mac <= pc_mac;
                end
            RX_PC_MAC_3:
                begin
                   if(byte_rxdv&&!byte_sig)
                   pc_mac <= {pc_mac[39:0],bytedate};
                   else 
                   pc_mac <= pc_mac;
                end
            RX_PC_MAC_4:
                begin
                   if(byte_rxdv&&!byte_sig)
                   pc_mac <= {pc_mac[39:0],bytedate};
                   else 
                   pc_mac <= pc_mac;
                end
            RX_PC_MAC_5:
                begin
                   if(byte_rxdv&&!byte_sig)
                   pc_mac <= {pc_mac[39:0],bytedate};
                   else 
                   pc_mac <= pc_mac;
                end
            RX_PC_MAC_6:
                begin
                   if(byte_rxdv&&!byte_sig)
                   pc_mac <= {pc_mac[39:0],bytedate};
                   else 
                   pc_mac <= pc_mac;
                end
            RX_DATA:
                begin
                if (mac_matched) 
                    begin
                        if(byte_rxdv&&!byte_sig)
                            begin
                                data_out_valid <= 1'b1;
                                rx_data_out <= bytedate;
                            end
                        else 
                            begin
                                data_out_valid <= 1'b0;
                                rx_data_out <= rx_data_out;
                            end                       
                    end
                else 
                    begin
                        data_out_valid <= 1'b0;
                        rx_data_out <= 8'b0;
                    end
 
                end
            RX_FINISH:
                begin
                	data_out_valid <= 1'b0;
                end
            default:
                begin
                    board_mac <= board_mac;
                    pc_mac <= pc_mac;
                    rx_data_out <= rx_data_out;
                end
        endcase
    end

endmodule
