module edgedetector(
	input wire clk,
	input wire rst,
	input wire button,
	input wire counter,
	output wire pos_edge
);

	reg cnt_inc = 1'b0;//�����ź�
	reg [24:0] cnt;//�ײ������?
	wire cnt_end;
	assign cnt_end = cnt_inc & (cnt == 25'd3);//15ms��ֹ�ź�
	
	//�����źŵĸ�ֵ
	always @(posedge clk or posedge rst)begin
		if (rst) 
			cnt_inc <= 1'b0;
		else if (button)
			cnt_inc <= 1'b1;
		else
			cnt_inc <= cnt_inc;
	end
	
	//�ײ������?
	always @(posedge clk or posedge rst)begin
		if (rst) 
			cnt  <= 25'd0;
		else if (cnt_end )
			cnt  <= 25'd0;
		else if (cnt_inc)
			cnt  <= cnt  + 25'd1;
		else
			cnt  <= cnt ;
	end
	
	//���ؼ��?
	reg sig_r0 = 1'b0;
	reg sig_r1 = 1'b0;
	always @(posedge clk or posedge rst)begin
		if(rst)
			sig_r0 <= 1'b0;
		else if(cnt_end)
			sig_r0 <= counter;
		else
			sig_r0 <= sig_r0;
	end
	
	always @(posedge clk or posedge rst)begin
		if(rst)
			sig_r1 <= 1'b0;
		else
			sig_r1 <= sig_r0;
	end
	
	assign pos_edge = ~sig_r1 & sig_r0;
	
endmodule