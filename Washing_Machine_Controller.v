`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2023 01:22:03 PM
// Design Name: 
// Module Name: Washing_Machine_Controller
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


module Washing_Machine_Controller(
    input coin_in,
    input clk,
    input double_wash,
    input timer_pause,
    input reset_n,
    output wash_done
    );
    wire timer_stop,done1u,done2u,done5u,rst_timer;
    Timer tm (
    .clk(clk),
    .reset_n(rst_timer),
    .timer_stop(timer_stop),
    .done1u(done1u),
    .done2u(done2u),
    .done5u(done5u)
    );
    Washing_fsm fsm(
    .coin_in(coin_in),
    .clk(clk),
    .double_wash(double_wash),
    .timer_pause(timer_pause),
    .reset_n(reset_n),
    .done_1u(done1u),
    .done_2u(done2u),
    .done_5u(done5u),
    .reset_timer(rst_timer),
    .timer_stop(timer_stop),
    .wash_done(wash_done)
    );
endmodule
