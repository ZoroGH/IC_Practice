//  Key_Debounce kd (
//      .clk     (      ),
//      .rst_n   (      ),
//      .key_in  (      ),
//      .key_out (      )
//  );


module Key_Debounce (
    input       clk         ,
    input       rst_n       ,
    input       key_in      ,
    output reg  key_out
);

parameter N = 32 ;           // debounce timer bitwidth
parameter FREQ = 50;         // model clock :Mhz
parameter MAX_TIME = 20;     // ms
localparam TIMER_MAX_VAL =   MAX_TIME * 1000 * FREQ  - 1 ; // 计数值最大值
/* 
    输入时钟频率为 50MHz，延迟时间为20ms
    则计数器应该记录的最大值便是 50MHz * 20ms = 1000 * 1000 次
    需要20bit的计数器。
 */

reg key_in_d0;//锁存一拍
wire key_in_flip;
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        key_in_d0 <= 1'b1;
    end
    else begin
        key_in_d0 <= key_in;
    end
end
assign key_in_flip = key_in ^ key_in_d0;


reg [N-1:0] cnt;
reg [1:0] c_stat;
reg [1:0] n_stat;
localparam idle     = 2'b0;
localparam flip     = 2'b1;
localparam counting = 2'd2;

// c_stat & n_stat
always @(posedge clk or negedge rst_n) begin
	if(~rst_n)
		c_stat<=1'b0;
	else
		c_stat<=n_stat;
end
// status changing 
always@(*) begin
	case(c_stat)
        idle: begin
            n_stat = (key_in_flip==1'b1) ? flip : idle ;
        end
        flip: begin
            n_stat = (key_in_flip==1'b1) ? flip : counting ;
        end
        counting : begin
            if (key_in_flip == 1'b1) begin
                n_stat = flip;
            end
            else if (cnt == TIMER_MAX_VAL)
                n_stat = idle;
            else 
                n_stat = counting;
        end
    endcase
end

// 计数器控制
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        cnt<='b0;
    end
    else begin
        case (c_stat)
            idle     : cnt <= 'b0       ;
            flip     : cnt <= 'b0       ;
            counting : cnt <=  cnt+1'b1 ;
        endcase
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin // 默认情况下 输入会和输出相同
        key_out <= key_in;
    end
    else begin
        if (cnt == TIMER_MAX_VAL)// 只有当状态稳定时，输出才会变化
            key_out <= key_in;
    end
end 

endmodule