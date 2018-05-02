`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/27 11:13:03
// Design Name: 
// Module Name: rx_control
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


module rx_control(
    input clk,
    input rst,//high level is effect
    input rx_in,
    input high_to_low_signal,
    input bps_clk_half,
    input bps_clk_total,
    input rx_enable_signal,
    output reg count_signal,
    output reg [7:0] rx_data,
    output reg rx_done_signal
    );

parameter IDLE = 4'b0000,
START_BIT  = 4'b0001,
DATA_BIT_1 = 4'b0010,
DATA_BIT_2 = 4'b0011,
DATA_BIT_3 = 4'b0100,
DATA_BIT_4 = 4'b0101,
DATA_BIT_5 = 4'b0110,
DATA_BIT_6 = 4'b0111,
DATA_BIT_7 = 4'b1000,
DATA_BIT_8 = 4'b1001,
STOP_BIT_1 = 4'b1010,//generate rx_done_signal
STOP_BIT_2 = 4'b1011//keep rx_data for long time to keep fifo having right value
;

reg [3:0] current_state, next_state;

always @ (posedge clk or posedge rst)
    begin
        if(rst)
            begin
                current_state <= IDLE;
            end
        else
            begin
                current_state <= next_state;
            end
    end

always @ (*)
    begin
        next_state <= current_state;
        case (current_state) 
            IDLE:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (high_to_low_signal) 
                               begin
                                   next_state <= START_BIT;
                               end
                           else 
                               begin
                                   next_state <= IDLE;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            START_BIT:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (bps_clk_total) 
                               begin
                                   next_state <= DATA_BIT_1;
                               end
                           else 
                               begin
                                   next_state <= current_state;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            DATA_BIT_1:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (bps_clk_total) 
                               begin
                                   next_state <= DATA_BIT_2;
                               end
                           else 
                               begin
                                   next_state <= current_state;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            DATA_BIT_2:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (bps_clk_total) 
                               begin
                                   next_state <= DATA_BIT_3;
                               end
                           else 
                               begin
                                   next_state <= current_state;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            DATA_BIT_3:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (bps_clk_total) 
                               begin
                                   next_state <= DATA_BIT_4;
                               end
                           else 
                               begin
                                   next_state <= current_state;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            DATA_BIT_4:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (bps_clk_total) 
                               begin
                                   next_state <= DATA_BIT_5;
                               end
                           else 
                               begin
                                   next_state <= current_state;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            DATA_BIT_5:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (bps_clk_total) 
                               begin
                                   next_state <= DATA_BIT_6;
                               end
                           else 
                               begin
                                   next_state <= current_state;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            DATA_BIT_6:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (bps_clk_total) 
                               begin
                                   next_state <= DATA_BIT_7;
                               end
                           else 
                               begin
                                   next_state <= current_state;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            DATA_BIT_7:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (bps_clk_total) 
                               begin
                                   next_state <= DATA_BIT_8;
                               end
                           else 
                               begin
                                   next_state <= current_state;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            DATA_BIT_8:
                begin
                    if (rx_enable_signal) 
                       begin
                           if (bps_clk_total) 
                               begin
                                   next_state <= STOP_BIT_1;
                               end
                           else 
                               begin
                                   next_state <= current_state;
                               end
                       end
                   else 
                       begin
                           next_state <= IDLE;
                       end   
                end
            STOP_BIT_1:
                begin
                  next_state <= STOP_BIT_2;
                end
            STOP_BIT_2:
            	begin
            		if(rx_enable_signal)
            			begin
            				if (bps_clk_half) 
            				    begin
            				        next_state <= IDLE;
            				    end
            				else 
            				    begin
            				        next_state <= current_state;
            				    end
            			end
            		else 
            		    begin
            		        next_state <= IDLE;
            		    end
            	end
            default:
                begin
                    next_state <= IDLE;
                end
        endcase
    end

always @ (posedge clk)
    begin
        case (next_state) //so we could solve one clock problem
            IDLE:
                begin
                    rx_data <= 8'b00000000;
                    count_signal <= 1'b0;
                    rx_done_signal <= 1'b0;
                end
            START_BIT:
                begin
                    count_signal <= 1'b1;
                end
            DATA_BIT_1:
                begin
                if(bps_clk_half)   
                rx_data[7] <= rx_in; 
                else 
                rx_data <= rx_data;
                end
            DATA_BIT_2:
                begin
                if(bps_clk_half)   
                rx_data[6] <= rx_in; 
                else 
                rx_data <= rx_data;
                end
            DATA_BIT_3:
                begin
                if(bps_clk_half)   
                rx_data[5] <= rx_in; 
                else 
                rx_data <= rx_data;
                end
             DATA_BIT_4:
                begin
                if(bps_clk_half)   
                rx_data[4] <= rx_in; 
                else 
                rx_data <= rx_data;
                end
            DATA_BIT_5:
                begin
                if(bps_clk_half)   
                rx_data[3] <= rx_in; 
                else 
                rx_data <= rx_data;
                end
            DATA_BIT_6:
                begin
                if(bps_clk_half)   
                rx_data[2] <= rx_in; 
                else 
                rx_data <= rx_data;
                end 
            DATA_BIT_7:
                begin
                if(bps_clk_half)   
                rx_data[1] <= rx_in; 
                else 
                rx_data <= rx_data;
                end 
            DATA_BIT_8:
                begin
                if(bps_clk_half)   
                rx_data[0] <= rx_in; 
                else 
                rx_data <= rx_data;
                end
            STOP_BIT_1:
                begin
                  rx_done_signal <= 1'b1; 
                end
            STOP_BIT_2:
            	begin
            		rx_done_signal <= 1'b0;
            	end
            default:
                begin
                    rx_data <= 8'b00000000;
                    count_signal <= 1'b0;
                    rx_done_signal <= 1'b0;
                end
        endcase
    end

endmodule
