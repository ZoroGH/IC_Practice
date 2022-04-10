// 本项目设计20位的循环移位计数器，每次
module Loop_Shift(
    input wire clk_in,
    input wire rst_n
    output wire out,
);

    reg [31:0] N =  1'b1;
    wire clk;

    FD fd(
        .clk_in(clk_in),
        .N(N),
        .clk_out(clk)
    );

    

endmodule