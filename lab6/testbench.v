`timescale 1ns/1ps
module tb_top (); /* this is automatically generated */

	// clock
	reg clk;
	initial begin
		clk = 0;
		forever #(0.5) clk = ~clk;
	end
	reg clk_1;
	initial begin
		clk_1 = 0;
		forever #(20) clk_1 = ~clk_1;
	end


	// (*NOTE*) replace reset, clock, others
	parameter T1ms = 1;

	reg				rst_n;
	reg	[3:0]		row;
	wire	[7:0]	sel;
	wire	[7:0]	seg;
	wire	[3:0]	col;
	reg	[4:0]		key;
	reg				s2_in;
	top #(
			.T1ms(T1ms)
		) inst_top (
			.clk   (clk),
			.rst_n (rst_n),
			.row   (row),
			.s2_in (s2_in),
			.sel   (sel),
			.seg   (seg),
			.col   (col)
		);





	initial begin
		rst_n = 1;   
	    row = 4'b1111;
	    key = 'h10;
		s2_in = 0;	    
		repeat(100)@(posedge clk);
	    rst_n = 0;

		key = 'h0f;
		repeat(100)@(posedge clk);// 1
		key = 'h0c;
		repeat(100)@(posedge clk);// +
		key = 'h0d;
		repeat(100)@(posedge clk);// 2
		s2_in = 1;	
		repeat(100)@(posedge clk);// =
		s2_in = 0;
		repeat(100)@(posedge clk);
		key = 'h0c;
		repeat(100)@(posedge clk);// +
		key = 'h0e;
		repeat(100)@(posedge clk);// 3
		s2_in = 1;	
		repeat(100)@(posedge clk);// =
		s2_in = 0;
		repeat(100)@(posedge clk);
		repeat(100)@(posedge clk);
		$finish;
	end

always @ (*)
		begin
			case (key)
				5'h10		:	row = 4'b1111;
				5'h00		:	row = {1'b1,1'b1,1'b1,col[0]};
				5'h01		:	row = {1'b1,1'b1,1'b1,col[1]};				
				5'h02		:	row = {1'b1,1'b1,1'b1,col[2]};
				5'h03		:	row = {1'b1,1'b1,1'b1,col[3]};	
				5'h04		:	row = {1'b1,1'b1,col[0],1'b1};	
				5'h05		:	row = {1'b1,1'b1,col[1],1'b1};	
				5'h06		:	row = {1'b1,1'b1,col[2],1'b1};	
				5'h07		:	row = {1'b1,1'b1,col[3],1'b1};	
				5'h08		:	row = {1'b1,col[0],1'b1,1'b1};
				5'h09		:	row = {1'b1,col[1],1'b1,1'b1};
				5'h0a		:	row = {1'b1,col[2],1'b1,1'b1};
				5'h0b		:	row = {1'b1,col[3],1'b1,1'b1};
				5'h0c		:	row = {col[0],1'b1,1'b1,1'b1};
				5'h0d		:	row = {col[1],1'b1,1'b1,1'b1};
				5'h0e		:	row = {col[2],1'b1,1'b1,1'b1};
				5'h0f		:	row = {col[3],1'b1,1'b1,1'b1};
				default	:	row = 4'b1111;
			endcase
		end


endmodule
