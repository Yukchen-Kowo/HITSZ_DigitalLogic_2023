`timescale 1ns/1ps

module flowing_water_lights_sim();

	reg clk;
	reg rst;
	reg button;
	reg [1:0]freq_set;
	wire [7:0]led;
	
	flowing_water_lights u_flowing_water_lights(.clk(clk),.rst(rst),.button(button),.freq_set(freq_set),.led(led));
	
	initial begin
		clk=1'b0;rst=1'b1;button=1'b1;freq_set=2'b00;
		#10 rst=1'b0;
		#15 button=1'b0;
		#25 button=1'b1;
		#40 freq_set=2'b10;

	end
	
	always #5 clk=~clk;

endmodule