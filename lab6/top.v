module top(
	input clk,
	input rst_n,
	input [3:0] row,
	input s2_in,

	output [7:0] sel,
	output [7:0] seg,
	output [3:0] col 
);

parameter T1ms = 24999;
wire [3:0] key_data;
wire flag;
wire clk_1k;
wire [19:0] bin_data;
wire [23:0] bcd;
wire s2_out;
wire valid;
	s2_in inst_s2_in 
		(
			.clk(clk_1k), 
			.rst_n(rst_n), 
			.s2_in(s2_in), 
			.valid(valid), 
			.s2_out(s2_out)
		);

	key_board #(
			.T1ms(T1ms)
		) inst_key_board (
			.clk    (clk),
			.rst_n  (rst_n),
			.row    (row),
			.col    (col),
			.data   (key_data),
			.valid  (flag),
			.clk_1k (clk_1k)
		);
	calculator inst_calculator
		(
			.clk      (clk_1k),
			.rst_n    (rst_n),
			.flag     (flag),
			.key_data (key_data),
			.s2_out   (s2_out),
			.valid_s2 (valid),
			.bin_data (bin_data)
		);

	bin2bcd_12bit inst_bin2bcd_12bit 
		(
			.bin(bin_data),
			.bcd(bcd)
		);

	seven_seg inst_seven_seg 
		(
			.clk     (clk), 
			.rst_n   (rst_n), 
			.data_in (bcd), 
			.sel     (sel), 
			.seg     (seg)
		);



endmodule