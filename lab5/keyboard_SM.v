module keyboard_SM #(
    parameter CNT_THRESHOLD=1000000-1,
    parameter STATE0 = 4'b1110 , 
    parameter STATE1 = 4'b1101 ,
    parameter STATE2 = 4'b1011 , 
    parameter STATE3 = 4'b0111 
)(
    input  wire       clk,
    input  wire       reset,
    input  wire [3:0] row,           //�������ź�
    output reg  [3:0] col,           //�����ɨ���ź�
    output reg        keyboard_en,   //keyboard�Ƿ��а���,ֻ�а��µ�ʱ�򰴼�ֵ����Ч�����ָ�λ״̬��0��ʵ�ʰ��±��Ϊ0�ļ�
    output reg  [3:0] keyboard_num,  //keyboard���尴�µ�����,�͵������,ֻά��һ������
    output reg [15:0] keyboard_led   //keyboard���尴�µ�����,�͵�led

);
reg [3:0] current_state;
reg [3:0] next_state; 

wire cnt_end;

/********************************
 * ������ɨ��Ƶ�ʿ����ź�
 ********************************/
counter #(CNT_THRESHOLD, 24) u_counter(
    .clk(clk), 
    .reset(reset), 
    .cnt_inc(1),
    .cnt_end(cnt_end)
);

/********************************
 * ״̬���л�״̬
 ********************************/
always@(posedge clk or posedge reset) begin
    if(reset)
        current_state <= STATE0;
    else if(cnt_end)
        current_state <= next_state;

end

/********************************
 * ״̬����̬�߼�
 ********************************/
always@(*) begin
    case(current_state) 
        STATE0: next_state = STATE1;
        STATE1: next_state = STATE2;
        STATE2: next_state = STATE3;
        STATE3: next_state = STATE0;
        default : next_state = STATE0;
    endcase
end
      
// �����ɨ���ź�
always@(posedge clk or posedge reset) begin
    if (reset)
        col <= 4'b1111;
    else begin
        case(current_state) 
            STATE0: col <= 4'b1110;
            STATE1: col <= 4'b1101;
            STATE2: col <= 4'b1011;
            STATE3: col <= 4'b0111;
        endcase
    end
end


reg[15:0] key;   // 16��������״̬��1�ǰ��£�0��û����
reg[15:0] key_r;
/********************************
 * ��ȡ���ź�
 ********************************/
always @(posedge clk, posedge reset) begin
    if (reset == 1) key <= 0;
    else  begin                     // key[3:0]��Ӧ�ұߵ�һ��col0,��ABCD����
        if (col[0] == 0) key[3:0]   <= ~row;    // �����ź�����ȡ���������ж�
        if (col[1] == 0) key[7:4]   <= ~row;    // ɨ����֮����ͳһ���룬���Ǳ�ɨ����ж�
        if (col[2] == 0) key[11:8]  <= ~row;
        if (col[3] == 0) key[15:12] <= ~row;
    end
end



//����� row ���첽�źţ�ͨ�����д����Ĳ��������첽�ź�ͬ����������ֹ����̬��
always @(posedge clk, posedge reset) begin
    if (reset == 1) key_r <= 0;
    else key_r <= key;
end

wire[15:0] key_posedge = (~key_r) & key;   // ��Ӧ�������²��������� 

/********************************
 * �����������
 ********************************/
always @(posedge clk, posedge reset) begin
    if (reset == 1) begin
        keyboard_num <= 0;   
    end else if (key_posedge) begin
		if (key_posedge[0]) keyboard_num <= 'hd;
		else if (key_posedge[1]) keyboard_num <= 'hc;
		else if (key_posedge[2]) keyboard_num <= 'hb;
		else if (key_posedge[3]) keyboard_num <= 'ha;
		else if (key_posedge[4]) keyboard_num <= 'hf;
		else if (key_posedge[5]) keyboard_num <= 'h9;
		else if (key_posedge[6]) keyboard_num <= 'h6;
		else if (key_posedge[7]) keyboard_num <= 'h3;
		else if (key_posedge[8]) keyboard_num <= 'h0;
		else if (key_posedge[9]) keyboard_num <= 'h8;
		else if (key_posedge[10]) keyboard_num <= 'h5;
		else if (key_posedge[11]) keyboard_num <= 'h2;
		else if (key_posedge[12]) keyboard_num <= 'he;
		else if (key_posedge[13]) keyboard_num <= 'h7;
		else if (key_posedge[14]) keyboard_num <= 'h4;
		else if (key_posedge[15]) keyboard_num <= 'h1;
	end else begin
		keyboard_num <= 0;
	end
end

always @(posedge clk, posedge reset) begin
    if (reset == 1) begin
        keyboard_en <= 0;
    end else if (key_posedge) begin
		keyboard_en <= 1;
	end else begin
		keyboard_en <= 0;
	end
end

always @(posedge clk, posedge reset) begin
    if (reset == 1)
        keyboard_led <= 0;
    else 
        keyboard_led <= key;
end

endmodule