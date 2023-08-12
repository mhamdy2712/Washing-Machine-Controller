`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2023 01:32:16 PM
// Design Name: 
// Module Name: Washing_Maching_tb
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


module Washing_Maching_tb(

    );
    parameter clk_cycle =10;
    reg clk,coin_in,reset_n,double_wash,timer_pause;
    wire wash_done;
    always begin
        clk=0;
        #(clk_cycle/2);
        clk=1;
        #(clk_cycle/2);
    end
    Washing_Machine_Controller mywmc(
    .coin_in(coin_in),
    .clk(clk),
    .double_wash(double_wash),
    .timer_pause(timer_pause),
    .reset_n(reset_n),
    .wash_done(wash_done)
    );
    initial begin
        reset_n =0;
        coin_in=0;
        double_wash=0;
        timer_pause=0;
        #(clk_cycle);
        reset_n=1;
        coin_in=1;
        double_wash=1;
        #(clk_cycle);
        coin_in=0;
        #(1600*clk_cycle);
        #(2*clk_cycle);
        timer_pause=1;
        #(10*clk_cycle);
        timer_pause=0;
    end
endmodule
