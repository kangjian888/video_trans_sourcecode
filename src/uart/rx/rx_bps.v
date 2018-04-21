`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/26 21:06:12
// Design Name: 
// Module Name: rx_bps
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


module rx_bps(
    input clk,
    input rst,//high level is effective
    input count_signal,
    output bps_clk_half,//the usage output
    output bps_clk_total
    );
parameter bps = 115200;//baudrate of the module,the defaul number is 115200
parameter integer total_counter = 1*100_000_000/bps-1;//this parameter cannot be changed,you must put the multiplication in the form place or the result is always zero
parameter integer half_counter = total_counter/2-1;

reg [14:0] counter;

always @ (posedge clk or posedge rst)
    begin
        if(rst)
        	begin
        		counter <= 15'd0;
        	end
        else if (counter == total_counter) 
            begin
                counter <= 15'd0;
            end
        else if (count_signal) 
            begin
                counter <= counter + 1'b1;
            end
        else 
        	begin
        		counter <= 15'd0;
        	end

    end

assign bps_clk_half = (counter == half_counter) ? 1'b1 : 1'b0;
assign bps_clk_total = (counter == total_counter) ? 1'b1 : 1'b0;
endmodule
