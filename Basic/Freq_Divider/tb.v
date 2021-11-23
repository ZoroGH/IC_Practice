`timescale 1ps/1ps
module tb ();
    reg clk;
    wire clk_out;
    reg [31:0] N;
    FD fd(
        .clk_in(clk),
        .N(N),
        .clk_out(clk_out)
    );
    initial begin
        $dumpfile("dumpfile.vcd");
        $dumpvars;
        clk<=1'b0;
        N<=2;
        # 30
        N<=3;
        # 30
        N<=4;
        # 30
        N<=5;
        # 30
        $finish;
    end
    
    always #1 clk<=~clk;

endmodule