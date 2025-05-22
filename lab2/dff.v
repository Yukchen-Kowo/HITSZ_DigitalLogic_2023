module dff(
	input wire clk,
	input wire clr,
	input wire en,
	input wire [7:0] d,
	output reg [7:0] q
);
	
	always@(posedge clk or posedge clr)begin
		if (clr)
			q <= 1'b0;
		else if (en)
			q <= d;
		else
			q <= q;
	end
endmodule