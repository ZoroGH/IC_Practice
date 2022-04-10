
module FD3(
    input wire clk,
    output wire clk_div
);

parameter integer N=3;
reg [31:0] cnt;
reg clk_r;
always @ (edge clk) begin
    if( cnt == N-1'b1 ) cnt <= 'b0;
    else cnt <= cnt + 1'b1;
end

always @ (posedge clk) begin
    if(cnt == N-1'b1) clk_r<=~clk_r;
end

assign clk_div = clk_r;

initial begin
    cnt <='b0;
    clk_r<='b0;
end

endmodule