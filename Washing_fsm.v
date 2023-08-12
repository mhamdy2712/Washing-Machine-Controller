`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2023 02:23:56 AM
// Design Name: 
// Module Name: Washing_fsm
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


module Washing_fsm(
    input coin_in,
    input clk,
    input double_wash,
    input timer_pause,
    input reset_n,
    input done_1u,
    input done_2u,
    input done_5u,
    output reg reset_timer,
    output timer_stop,
    output wash_done
    );
    localparam idle = 3'b000,filling_water = 3'b001,
                      washing = 3'b010 , rinsing = 3'b011,
                      spinning = 3'b100;
    reg [2:0] curr_state,next_state;
    reg timer_pause_start,double_wash_done,timer_pause_next,double_wash_next;
    reg done;
    always @(posedge clk,negedge reset_n) begin
        if(~reset_n) begin
            reset_timer <= 0;
            curr_state <= idle;
            double_wash_done <= 0;
            timer_pause_start <= 0;
        end
        else begin
            curr_state <= next_state;
            timer_pause_start <= timer_pause_next;
            double_wash_done <= double_wash_next;
        end
    end
    always @(*) begin
        case(curr_state)
            idle: begin
                timer_pause_next = timer_pause_start;
                double_wash_next = double_wash_done;
                done=0;
                if(timer_pause_start)begin
                    reset_timer =1;
                    if(timer_pause)
                        next_state = idle;
                    else
                        next_state = spinning;
                end
                else if(coin_in) begin
                    reset_timer =0;
                    next_state = filling_water;
                end
                else begin
                    reset_timer =0;
                    next_state = idle;
                end
            end
            filling_water: begin
                timer_pause_next = timer_pause_start;
                double_wash_next = double_wash_done;
                done=0;
                reset_timer =1;
                if(done_2u) begin
                    next_state=washing;
                    reset_timer =0;
                end
                else begin
                    next_state = filling_water;
                    reset_timer =1;
                end  
            end
            washing: begin
                timer_pause_next = timer_pause_start;
                double_wash_next = double_wash_done;
                done=0;
                reset_timer =1;
                if(done_5u) begin
                    next_state=rinsing;
                    reset_timer =0;
                end
                else begin
                    next_state = washing;
                    reset_timer =1;
                end  
            end
            rinsing: begin
                done=0;
                reset_timer =1;
                timer_pause_next = timer_pause_start;
                if(~done_2u) begin
                    double_wash_next = double_wash_done;
                    next_state=rinsing;
                    reset_timer =1;
                end
                else if(double_wash && !double_wash_done) begin
                    next_state = washing;
                    reset_timer =0;
                    double_wash_next=1;
                end
                else begin
                    next_state = spinning;
                    reset_timer =0;
                    double_wash_next=0;
                end
            end
            spinning: begin
                double_wash_next = double_wash_done;
                reset_timer =1;
                timer_pause_next=0;
                done=0;
                if(timer_pause) begin
                    next_state=idle;
                    timer_pause_next=1;
                end
                else if(~done_1u) begin
                    next_state=spinning;
                    reset_timer =1;
                end
                else begin
                    done=1;
                    next_state=idle;
                    reset_timer =0;
                end
            end
            default: begin
                next_state=0;
                done=0;
                reset_timer=0;
                double_wash_next = 0;
                timer_pause_next = 0;
            end        
        endcase
    end
    assign wash_done = done;
    assign timer_stop = timer_pause_next;
endmodule
