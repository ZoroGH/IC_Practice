`timescale 1ps/1ps
module tb (
);
    reg clk;
    reg a;
    reg b;
    wire sum;
    wire carry;
    HalfAdder ha(
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );
    always #1 clk<=~clk;
    initial begin
        $dumpfile("./dumpfile.vcd");
        $dumpvars;
        clk<=1'b1;
        a<=1'b1;
        b<=1'b1;
        # 2 a<=1'b0;
        # 2 b<=1'b0;
        # 2 a<=1'b1;
        # 2
        $finish;
    end

endmodule