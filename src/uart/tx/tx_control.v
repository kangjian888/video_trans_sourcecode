`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/27 20:34:40
// Design Name: 
// Module Name: tx_control
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


module tx_control(
    input clk,
    input rst,//high level is effect
    input [7:0] tx_data,
    input bps_clk_total,
    input tx_enable_signal,
    output reg tx_out,
    output reg tx_done_signal
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
STOP_BIT = 4'b1010;
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
        case (current_state) 
            IDLE:
                begin
                    if (!tx_enable_signal) 
                        begin
                            next_state <= START_BIT;
                        end
                    else 
                        begin
                            next_state <= IDLE;
                        end
                end
            START_BIT:
                begin
                    if (!tx_enable_signal) 
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
            		if (!tx_enable_signal) 
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
            		if (!tx_enable_signal) 
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
            		if (!tx_enable_signal) 
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
            		if (!tx_enable_signal) 
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
            		if (!tx_enable_signal) 
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
            		if (!tx_enable_signal) 
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
            		if (!tx_enable_signal) 
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
            		if (!tx_enable_signal) 
            		    begin
            		        if (bps_clk_total) 
            		            begin
            		                next_state <= STOP_BIT;
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
            STOP_BIT:
            	begin
            		if (!tx_enable_signal) 
            		    begin
            		        if (bps_clk_total) 
            		            begin
            		                next_state <= START_BIT;
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
reg counter;//flag
always @ (posedge clk)
    begin
        case (next_state) 
            IDLE:
                begin
                    tx_out <= 1'b1;
                end
            START_BIT:
                begin
                    tx_out <= 1'b0;
                    tx_done_signal <= 1'b0;
                    counter <= 1'b0;
                end
            DATA_BIT_1:
                begin
                	tx_out <= tx_data[7];
                end
            DATA_BIT_2:
                begin
                	tx_out <= tx_data[6];
                end
            DATA_BIT_3:
                begin  
                	tx_out <= tx_data[5];                      
                end    
            DATA_BIT_4:
                begin 
                	tx_out <= tx_data[4];                 
                end   
            DATA_BIT_5:
            	begin 
                	tx_out <= tx_data[3];                 
            	end   
            DATA_BIT_6:
            	begin 
                	tx_out <= tx_data[2];                 
            	end   
            DATA_BIT_7:
            	begin 
                	tx_out <= tx_data[1];                 
            	end   
            DATA_BIT_8:
            	begin 
                	tx_out <= tx_data[0];                 
            	end  
            STOP_BIT:
     	       	begin
     	       		tx_out <= 1'b1;
                    if(tx_done_signal ==1'b1)
                        begin
                            counter <= 1'b1;
                            tx_done_signal <= 1'b0;
                        end
                    else 
                        begin
                            if(counter == 1'b0)
                                begin
                                    tx_done_signal <= 1'b1;
                                end
                            else
                                begin
                                    counter <= counter;
                                    tx_done_signal <= 1'b0;
                                end
                        end
            	end
                /*the below code can generate 2 cycle's done signal
                //reg [1:0] counter;
                //begin
                    //tx_out <= 1'b1;
                    //if(tx_done_signal ==1'b1)
                        //begin
                            //if(counter != 2'b01)
                                //begin
                                    //counter <= counter + 1'b1;
                                //end
                            //else 
                                //begin
                                    //counter <= counter;
                                    //tx_done_signal <= 1'b0;
                                //end
                        //end
                    //else 
                        //begin
                            //if(counter == 2'b00)
                                //begin
                                    //tx_done_signal <= 1'b1;
                                //end
                            //else
                                //begin
                                    //counter <= counter;
                                    //tx_done_signal <= 1'b0;
                                //end
                        //end
                //end
                */

        endcase
    end

endmodule
