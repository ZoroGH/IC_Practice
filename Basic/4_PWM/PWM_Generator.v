module PWM_Generator(
    input wire clk,
    input wire rst_n,
    // input wire cmp,
    output reg pwm_wave
);
    parameter N = 1;
    reg [31:0] cnt;

    always@(posedge clk or negedge rst_n) begin
        if(~rst_n) cnt<='b0;
        else if (cnt<=20'd999_999) cnt<=cnt+1'b1; //控制pwm的周期
        else cnt<='b0;
    end
    
    assign pwm_wave = cnt>32'd?1'b1:1'b0; //控制占空比 // 这种方式也能被复位

endmodule