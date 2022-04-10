`timescale 1ps/1ps
module tb ();
    reg clk;
    wire clk_out;
    reg [31:0] N;
    FD3 fd(
        .clk(clk),
        .clk_div(clk_out)
    );
    initial begin
        $dumpfile("dumpfile.vcd");
        $dumpvars;
        clk<=1'b0;
        #20
        $finish;
    end
    always #1 clk<=~clk;
endmodule