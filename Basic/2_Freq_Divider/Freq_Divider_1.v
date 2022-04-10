`timescale 1ps/1ps

/* 
此分频器通过双边沿触发来实现
 */

module FD (
    input wire clk_in,
    input wire [31:0] N,
    output reg clk_out
);
    initial begin
        cnt<=1'b1;
        clk_out<='b0;
    end

    reg [31:0] cnt;
    always @(edge clk_in) begin // 双边沿触发
        if (cnt<N)begin
            cnt<=1'b1+cnt;
        end else begin
            cnt<=1'b1;
            clk_out<=~clk_out;
        end
    end
endmodule