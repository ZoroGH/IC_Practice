`timescale 1ns/1ns
`define CLOCK_PERIOD 10
module tb();

reg clk;
reg rst_n;
always #(`CLOCK_PERIOD/2) clk<=~clk;

reg [7:0] data_i;
wire flag;

FSM_Mealy fsm(
    .clk  (clk      ),
    .rst_n(rst_n    ),
    .data (data_i   ),
    .flag (flag     )
);

initial begin
    $dumpfile("./dumpfile.vcd");
    $dumpvars;
    clk<=1'b1;
    rst_n<=1'b0;
    data_i<='hff;
    #`CLOCK_PERIOD
    rst_n<=1'b1;
    #(`CLOCK_PERIOD + 1 )
    #`CLOCK_PERIOD data_i<='haa;
    #`CLOCK_PERIOD data_i<='hbb;
    #`CLOCK_PERIOD data_i<='hcc;
    #`CLOCK_PERIOD data_i<='hbb;
    #`CLOCK_PERIOD data_i<='haa;
    #`CLOCK_PERIOD data_i<='hbb;
    #`CLOCK_PERIOD data_i<='hcc;
    #`CLOCK_PERIOD data_i<='haa;
    #`CLOCK_PERIOD data_i<='hbb;
    #`CLOCK_PERIOD data_i<='haa;
    #`CLOCK_PERIOD data_i<='hbb;
    #`CLOCK_PERIOD data_i<='hcc;
    #`CLOCK_PERIOD data_i<='hcc;
    #(`CLOCK_PERIOD * 4)
    $finish;
end

endmodule