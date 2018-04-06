`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/26 20:54:35
// Design Name: 
// Module Name: detect
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// This module is used to detect the signal level. If the rx_in signal becomes from high level to low level. 
// the high_to_low_signal will have a period high level. 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module detect(
    input clk,
    input rst,//high is effect
    input rx_in,
    output high_to_low_signal
    );

reg high_to_low_signal_1;
reg high_to_low_signal_2;

always @ (posedge clk or posedge rst)
    begin
        if(rst)
        	begin
        		high_to_low_signal_1 <= 1'b1;
        		high_to_low_signal_2 <= 1'b1;
        	end
        else
        	begin
        		high_to_low_signal_1 <= rx_in;
        		high_to_low_signal_2 <= high_to_low_signal_1;
        	end
    end

assign high_to_low_signal = !high_to_low_signal_1 && high_to_low_signal_2;
endmodule
