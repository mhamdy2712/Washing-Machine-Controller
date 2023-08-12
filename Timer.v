`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2023 02:27:01 PM
// Design Name: 
// Module Name: Timer
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


module Timer
#(parameter N=10)(
    input clk,
    input reset_n,
    input timer_stop,
    output done1u,
    output done2u,
    output done5u
    );
     reg [N-1:0] Q_reg,Q_Next;
    always @(posedge clk)
    begin
        if(~reset_n)
            Q_reg<= 'b0;
        else
            Q_reg<=Q_Next;
    end
    always @(*)
    begin
        if(timer_stop)
            Q_Next = Q_reg;
        else
            Q_Next = Q_reg+1;
    end
    assign done1u = (Q_reg==99);
    assign done2u = (Q_reg==199);
    assign done5u = (Q_reg==499);
endmodule
