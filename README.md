# IC_Practice
该仓库用于记录本人在学习数字电路及Verilog语言学习过程中所产生的代码.

本仓库所使用的工具为iverilog 与 GTKwave.

[学习笔记地址](./Notes/Note.md)

## DIRS

- Environment_Test
- Basic
- Notes




## TIPS

本项目中各种命名均采用下划线类型。
```verilog

//宏定义使用全大写并用下划线隔开
`define MAX_WIDTH 5;
//变量 全小写字母并用下划线隔开
reg [7:0] clk_p;
wire [7:0] sum_out;
//模块 大写字母开头并用下划线隔开
module Half_Adder();
//文件 同模块
"Half_Adder.v"
"Half_Adder_Top.v"
```

- GTKwave用命令行直接打开文件后，浏览波形会变得极其卡顿，应该先打开GTKwave，再导入需要预览的文件。


## MAIN LOG

- 21/10/23 编写基本的自动脚本指令
- 22/02/16 添加了若干项目，加法器，分频器，LED，PWM，循环移位寄存器
- 22/03/02 有限状态机
- 22/04/17 按键消抖


