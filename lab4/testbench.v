`timescale 1ns/1ps

module led_display_ctrl_sim();
	
	reg clk;
	reg rst;
	reg button;
	reg counter;
	wire [7:0]led_en;
	wire led_ca;
	wire led_cb;
    wire led_cc;
	wire led_cd;
	wire led_ce;
	wire led_cf;
	wire led_cg;
	wire led_dp;
	
	led_display_ctrl u_led_display_ctrl(
		.clk(clk),
		.rst(rst),
		.button(button),
		.counter(counter),
		.led_en(led_en),
		.led_ca(led_ca),
		.led_cb(led_cb),
		.led_cc(led_cc),
		.led_cd(led_cd),
		.led_ce(led_ce),
		.led_cf(led_cf),
		.led_cg(led_cg),
		.led_dp(led_dp)
	);
	
	// 这一段initial测试的是按键计数功能，以及消抖和上升沿检测。
	initial begin
		clk=1'b0;rst=1'b1;button=1'b0;counter=1'b0;
		#10 rst=1'b0;button=1'b1;
		//测试counter的同时测0-20计数
		#10 button=1'b0;counter=1'b1;//1
		#200 counter=1'b0;
		#200 counter=1'b1;//2
		#200 counter=1'b0;
		#180 counter= 1'b1;
		#2 counter= 1'b0;
		#2 counter = 1'b1;
		#2 counter= 1'b0;
		#2 counter = 1'b1;
		#2 counter= 1'b0;
		#2 counter = 1'b1;
		#2 counter= 1'b0;
		#2 counter = 1'b1;
		#2 counter = 1'b0;
		#3counter = 1'b1;
		#40 counter=1'b0;//3
		#2 counter= 1'b0;
		#2 counter = 1'b1;
				#2 counter= 1'b0;
		#2 counter = 1'b1;
		#2 counter = 1'b0;
		#2 counter = 1'b0;
		#200 counter=1'b0;
		#200 counter=1'b1;//4

		#200 counter=1'b0;rst=1'b1;
	end

	always #4 clk=~clk;
	
endmodule