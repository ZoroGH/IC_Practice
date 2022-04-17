`timescale 10ns/10ns
`define CLK_PEROID 2 // 50Mhz 时钟

module tb();
reg clk;
reg rst_n;
reg key_in;
wire key_out;
always #(`CLK_PEROID/2) clk <= ~clk;

Key_Debounce kd (
	.clk     (clk       ),
	.rst_n   (rst_n     ),
	.key_in  (key_in    ),
	.key_out (key_out   )
);

initial begin
	$dumpfile("./dumpfile.vcd");
	$dumpvars;
	clk<=1'b1;
	rst_n <= 1'b0;
	key_in<=1'b1;
	#`CLK_PEROID
	rst_n <= 1'b1;
	#(`CLK_PEROID/2)
	#(`CLK_PEROID*3)	key_in <= 1'b0;
	#(`CLK_PEROID*2)	key_in <= 1'b1;
	#(`CLK_PEROID*100)	key_in <= 1'b0;
	#(`CLK_PEROID*30)	key_in <= 1'b1;
	#(`CLK_PEROID*3)	key_in <= 1'b0;
	#(`CLK_PEROID*1)	key_in <= 1'b1;


	#(`CLK_PEROID*100000)    	key_in <= 1'b0;
	#(`CLK_PEROID*300000)    	key_in <= 1'b1;
	#(`CLK_PEROID*200000)    	key_in <= 1'b0;
	#(`CLK_PEROID*400000)    	key_in <= 1'b1;
	#(`CLK_PEROID*100000)    	key_in <= 1'b0;

	#(`CLK_PEROID*1000*1000*4)
	#(`CLK_PEROID*1000*1000*4)

	#(`CLK_PEROID*100000)       key_in <= 1'b1;
	#(`CLK_PEROID*300000)       key_in <= 1'b0;
	#(`CLK_PEROID*200000)       key_in <= 1'b1;
	#(`CLK_PEROID*400000)       key_in <= 1'b0;
	#(`CLK_PEROID*100000)       key_in <= 1'b1;
	#(`CLK_PEROID*1000)         key_in <= 1'b0;
	#(`CLK_PEROID*1000)         key_in <= 1'b1;
	#(`CLK_PEROID*500)          key_in <= 1'b0;
	#(`CLK_PEROID*5)            key_in <= 1'b1;
	#(`CLK_PEROID*50)           key_in <= 1'b0;
	#(`CLK_PEROID*1)            key_in <= 1'b1;
	#(`CLK_PEROID*1000*1000*4)
	$finish;
end
endmodule

