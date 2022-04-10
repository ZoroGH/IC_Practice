module tb ();

    reg clk;
    reg [1:0]in;
    wire [1:0] res;
    Half_Adder ha(
        .a(in[1]),
        .b(in[0]),
        .sum(res[0]),
        .carry(res[1])
    );
    
    initial begin
        $dumpfile("./dumpfile.vcd");
        $dumpvars;
        clk<=1'b0;
        in<=2'b00;
        # 20 $finish;
    end
    always # 1 clk <= ~clk;
    always @(edge clk) begin
        in<=in+1'b1;
    end
endmodule