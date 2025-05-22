module s2_in(
	input wire clk,
	input wire rst_n,
	input wire s2_in,
	output reg valid,
	output reg s2_out
);

	reg cnt_inc = 1'b0;//�����ź�
	reg [24:0] cnt;//�ײ������?
	wire cnt_end;
	assign cnt_end = cnt_inc & (cnt == 25'd30);//15ms��ֹ�ź�
	
	//�����źŵĸ�ֵ
	always @(posedge clk or posedge rst_n)begin
		if (rst_n) 
			cnt_inc <= 1'b0;
		else 
			cnt_inc <= 1'b1;
	end
	
	//�ײ������?
	always @(posedge clk or posedge rst_n)begin
		if (rst_n) 
			cnt  <= 25'd0;
		else if (cnt_end )
			cnt  <= 25'd0;
		else if (cnt_inc)
			cnt  <= cnt  + 25'd1;
	end
	
	reg sig_r0 = 1'b0;
	reg sig_r1 = 1'b0;
	always @(posedge clk or posedge rst_n)begin
		if(rst_n)
			sig_r0 <= 1'b0;
		else if(cnt_end)
			sig_r0 <= s2_in;
		else
			sig_r0 <= sig_r0;
	end
	
	always @(posedge clk or posedge rst_n)begin
		if(rst_n)
			sig_r1 <= 1'b0;
		else
			sig_r1 <= sig_r0;
	end
	always @(posedge clk or posedge rst_n)begin
		if(rst_n)
			sig_r1 <= 1'b0;
		else
			sig_r1 <= sig_r0;
	end
	always @(posedge clk or posedge rst_n)begin
		if(rst_n)
			s2_out <= 1'b0;
		else if(~sig_r1 & sig_r0)begin
			s2_out <= 1;
			valid <= 1;
		end	
		else begin
			s2_out <= 0;
			valid <= 0;
		end
	end

endmodule