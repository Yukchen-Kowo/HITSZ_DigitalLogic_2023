module counter20(
	input wire clk,
	input wire rst,
	input wire button,
	output reg [3:0]number_0,
	output reg [3:0]number_1
);
	reg [5:0]cnt;//0-20����
	reg cnt_inc = 1'b0;//�����ź�
	reg [24:0] cnt_origin;//�ײ������?
	assign cnt_end_origin = cnt_inc & (cnt_origin == 25'd45);//0.1s��ֹ�ź� 1000000  //���Ҫ�������99
	assign cnt_end = cnt_end_origin & (cnt == 6'd20);//0-20��ֹ�ź�
	
	//�����źŵĸ�ֵ?
	always @(posedge clk or posedge rst)begin
		if (rst) 
			cnt_inc <= 1'b0;
		else if (button)
			cnt_inc <= 1'b1;
		else if (cnt>=6'd20 & button)
		    cnt_inc <= 1'b1;
		else if (cnt >= 6'd20)
		    cnt_inc <= 1'd0;
        else
			cnt_inc <= cnt_inc;	
	end
	
	//�ײ������?
	always @(posedge clk or posedge rst)begin
		if (rst) 
			cnt_origin <= 25'd0;
		else if (cnt_end_origin)
			cnt_origin <= 25'd0;
		else if (cnt_inc)
			cnt_origin <= cnt_origin + 25'd1;
		else
			cnt_origin <= cnt_origin;
	end
	
	//0��20������?
	always @(posedge clk or posedge rst)begin
		if (rst)
			cnt <= 6'd0;
		else if (cnt_end)
			cnt <= 6'd0;
		else if (cnt_end_origin)
			cnt <= cnt + 6'd1;
		else if (cnt>=6'd20 & button)
		    cnt <= 6'd0;
		else
			cnt <= cnt;
	end
	
	//��cntת����ʮ�����µ�ʮλ���ֺ͸�λ��
	always @(*)begin
		if(cnt>=6'd20)begin
			number_0 = 4'd0;
			number_1 = 4'd2;
			if(button)begin
			    number_0 = 4'd0;
			    number_1 = 4'd0;
			end
			else begin
			    number_0 = 4'd0;
			    number_1 = 4'd2;
			end
		end
		else if (cnt>6'd10)begin
			number_0 = cnt-6'd10;
			number_1 = 4'd1;
		end
		else begin
			number_0 = cnt;
			number_1 = 4'd0;
		end
	end
	
endmodule
		
	