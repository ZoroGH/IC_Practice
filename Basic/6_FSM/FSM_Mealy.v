/*
该程序用于学习三段式状态机。
当输入数据为 指定序列时输入为 AA BB CC时输出1.
*/

// 状态机完全按照数学模型来写，分为三段，将结构描述清楚即可
module FSM_Mealy(           //  FSM_Moore fsm(
    input wire clk,         //      .clk  (   ),
    input wire rst_n,       //      .rst_n(   ),
    input wire [7:0] data,  //      .data (   ),
    output reg flag         //      .flag (   )
);                          //  );


// =====三段式状态机 Mealy型===== //
reg [1:0] c_state,n_state;

localparam 
    idle  =  'b00,
    aa    =  'b01,
    bb    =  'b10;

// 状态转移 时序部分
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) c_state <=  idle;
    else c_state <= n_state;
end

// 状态转移条件 次态组合电路
always @(*) begin
    case(c_state)
        idle: begin
            if(data == 'haa) n_state = aa;
            else n_state = idle;
        end
        aa  : begin
            if(data == 'haa) n_state = aa;
            else if(data =='hbb) n_state = bb;
            else n_state = idle;
        end
        bb  : begin
            if(data == 'haa) n_state = aa;
            else if(data == 'hcc) n_state = idle;
            else n_state = idle;
        end
        default: n_state  =  idle;
    endcase
end

// 输出部分 组合电路
always @(*) begin
    if (c_state == bb && data == 'hcc ) flag = 1'b1;
    else flag = 1'b0;
end
endmodule