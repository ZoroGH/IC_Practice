# 分频器

<p align='right'>ZoroGH</p>

分频器用于时钟分频。

判断一个信号是否是分频信号，条件有三。其一，该信号是否为周期信号。其二，一个周期内是否仅有一个上升沿和一个下降沿。前两条是时钟信号的要求，第三点是，如果前两条满足，则该信号在一个周期内，有N个时钟周期，即为时钟的N分频信号，或称N分频时钟。

## 偶数分频

占空比为50%的情况下，在计数器值为分频数一半时进行翻转，即可得到N分频信号。翻转一次为半个周期，一个周期内要翻转两次才能得到N分频信号。

```verilog
parameter integer N=2;
reg [31:0] cnt;
reg clk_div;
always @ (posedge clk) begin
    if( cnt==(N>>2-1'b1) ) cnt<='b0;
    else cnt<=1'b1+cnt;
end

always @ (posedge clk) begin
    if(cnt==(N>>2)) clk_div<=~clk_div;
end
```

## 奇数分频

奇数分频相比起偶数分频来看，难度稍大，因为无法直接根据分频比的一半（非整数）进行翻转。

### 脉冲（持续一个周期）

根据时钟的定义即可，计数器进行计数，周期为N，那么每个周期内只要出现一个上升沿和一个下降沿即可。

```verilog
parameter integer N=3;
reg [31:0] cnt;
reg clk_div;
always @ (posedge clk) begin
    if( cnt==(N-1'b1) ) cnt<='b0;
    else cnt<=1'b1+cnt;
end
always @ (posedge clk) clk <= ( cnt == (N - 1'b1) ) ? 1'b1 : 1'b0 ;// 任意一个常数均可，此处是正脉冲
```

### 占空比50%

占空比为50%的奇数分频信号，也即一个周期内含有奇数个时钟周期。

原理是通过上升沿分频信号与下降沿分频信号之间相差一个时钟相位来获取奇数分频信号。

这里参考[小脚丫平台的分频器教程](https://www.stepfpga.com/doc/stepmxo2-lab17)，

```verilog
module FD2(
    input wire clk,
    output wire clk_div
);

parameter integer N=3;
reg [31:0] cnt;

always @ (posedge clk) begin // 计数器部分
    if( cnt == N-1'b1 ) cnt <= 'b0;
    else cnt <= cnt + 1'b1;
end

reg clk_div_p; // positive
always @ (posedge clk ) begin
    if( cnt <= (N>>2) ) clk_div_p <=1'b0;
    else clk_div_p <= 1'b1;
end
reg clk_div_n; // negative
always @ (negedge clk ) begin
    if( cnt <= (N>>2) ) clk_div_n <=1'b0;
    else clk_div_n <= 1'b1;
end

assign clk_div = clk_div_p & clk_div_n;

initial begin
    cnt <='b0;
end
endmodule
```



## 任意整数分频比

实际上，实现了上述奇偶分频后，即可实现任意分频比，甚至，上述奇数分频也可以直接实现任意整数分频。而笔者在思考过程中，最开始想到的奇数解决方案是双边沿触发器，**时钟信号在一个周期内有一个上升沿和一个下降沿，那么在N个周期内，就有2N个上升沿和下降沿。于是，分频信号每N个边沿翻转一次，那么2次翻转后，就对应时钟信号的2N个边沿，即N分频。**

```verilog
parameter integer N=3;
reg [31:0] cnt;
always @(edge clk) begin // 也可以写成  always @ (posedge clk or negedge clk) 
    if (cnt == N-1'b1) clk_div_r<=~clk_div_r;
end

assign clk_div = clk_div_r;
```

>   注意，这里的双边沿翻转，其核心器件是**双边沿触发器**，而这类器件极其少见，而且，当时钟频率较高时，用软件的方式来控制计数产生时钟快速翻转必然带来不稳定，而上述奇数分频中，利用正负两相信号进行与的操作，比双边沿触发更加合理且效果更好。
>
>   本质上，上述三种方法都是数边沿来计数，且奇数分频与双边沿触发器分频是一样的，奇数分频中，也是**利用了时钟信号的上升沿与下降沿**，但是两种写法综合出来电路不一样，前者相较而言更优。

```verilog
// testbench file
`timescale 1ps/1ps
module tb ();
    reg clk;
    wire clk_out;
    reg [31:0] N;
    FD fd(
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
```



