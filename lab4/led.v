module led(
	input wire [3:0]number,
	output reg [7:0]seg_code
);
//�����������ת��Ϊled�Ķ���?
//seg_code:ca,cb,cc,cd,ce,cf,cg,dp
	always @(*)begin
		case(number)
			4'd0:seg_code=8'b00000011;
			4'd1:seg_code=8'b10011111;
			4'd2:seg_code=8'b00100101;
			4'd3:seg_code=8'b00001101;
			4'd4:seg_code=8'b10011001;
			4'd5:seg_code=8'b01001001;
			4'd6:seg_code=8'b01000001;
			4'd7:seg_code=8'b00011111;
			4'd8:seg_code=8'b00000001;
			4'd9:seg_code=8'b00001001;
			default:seg_code=8'b00000011;
		endcase
	end

endmodule