module reg8file(
	input wire clk,
	input wire clr,
	input wire en,
	input wire [7:0] d,
	input wire [2:0] wsel,
	input wire [7:0] rsel,
	output wire [7:0] q
);
	wire [7:0] r0,r1,r2,r3,r4,r5,r6,r7;
	wire [7:0] en_r;
	decoder_38 u_decoder38(.en(en),.wsel(wsel),.en_r(en_r));
	dff u_dff_0(.clk(clk),.clr(clr),.en(en_r[0]),.d(d),.q(r0));
	dff u_dff_1(.clk(clk),.clr(clr),.en(en_r[1]),.d(d),.q(r1));
	dff u_dff_2(.clk(clk),.clr(clr),.en(en_r[2]),.d(d),.q(r2));
	dff u_dff_3(.clk(clk),.clr(clr),.en(en_r[3]),.d(d),.q(r3));
	dff u_dff_4(.clk(clk),.clr(clr),.en(en_r[4]),.d(d),.q(r4));
	dff u_dff_5(.clk(clk),.clr(clr),.en(en_r[5]),.d(d),.q(r5));
	dff u_dff_6(.clk(clk),.clr(clr),.en(en_r[6]),.d(d),.q(r6));
	dff u_dff_7(.clk(clk),.clr(clr),.en(en_r[7]),.d(d),.q(r7));
	multiplexer u_multiplexer(.sel(rsel),.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7),.q(q));

endmodule
	
	
	