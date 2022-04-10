module LED(
    input clk,
    input rst_n,
    output wire led
);
    reg [23:0] cnt;
    always @ (posedge clk or negedge rst_n) begin
        if(~rst_n) cnt<='b0;
        else cnt<=cnt+1'b1;
    end
    assign led = cnt[23];
endmodule