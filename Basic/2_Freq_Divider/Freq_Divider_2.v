module FD2(
    input wire clk,
    output wire clk_div
);

parameter integer N=3;
reg [31:0] cnt;

always @ (posedge clk) begin
    if( cnt == N-1'b1 ) cnt <= 'b0;
    else cnt <= cnt + 1'b1;
end

reg clk_div_p;
always @ (posedge clk ) begin
    if( cnt <= (N>>2) ) clk_div_p <=1'b0;
    else clk_div_p <= 1'b1;
end
reg clk_div_n;
always @ (negedge clk ) begin
    if( cnt <= (N>>2) ) clk_div_n <=1'b0;
    else clk_div_n <= 1'b1;
end

assign clk_div = clk_div_p & clk_div_n;

initial begin
    cnt <='b0;
end

endmodule