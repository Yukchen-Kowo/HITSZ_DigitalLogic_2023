`timescale 1ns/1ps         

module keyboard_sim();    

reg        clk;
reg        reset;
reg  [3:0] row;
wire [3:0] col;
wire [15:0] keyboard_led;
wire [3:0]  keyboard_num;
wire        keyboard_en;
wire        cnt_end;

reg [7:0] keycase_cnt;   //按键个数计数
wire keycase_inc;

parameter CNT_THRESHOLD=4;

counter #(CNT_THRESHOLD, 24) u_test_counter(     //用于生成时序匹配的row信号
    .clk(clk), 
    .reset(reset), 
    .cnt_inc(1), 
    .cnt_end(cnt_end)
);

keyboard_SM #(CNT_THRESHOLD) u_keyboard(   
    .clk(clk), 
    .reset(reset), 
    .row(row), 
    .col(col), 
    .keyboard_en(keyboard_en), 
    .keyboard_num(keyboard_num),
    .keyboard_led(keyboard_led)
);
   
always #1 clk = ~clk;

initial begin
    reset = 1'b1;  
    clk = 0; 
    row = 4'b1111;
    # 10
    reset = 1'b0;
    # 10000
    $finish;
end
    

assign keycase_inc = cnt_end;

always @(posedge clk, posedge reset) begin
    if (reset) keycase_cnt <= 0;
    else if (keycase_inc) keycase_cnt <= keycase_cnt + 1;
end
        reg [3:0] number;
        reg [6:0] led_display;
    always @(posedge clk, posedge reset) begin
    if (reset == 1) begin
        number <= 0;   
    end else begin
		     if (keyboard_led[0])  number <= 'hd;
		else if (keyboard_led[1])  number <= 'hc;
		else if (keyboard_led[2])  number <= 'hb;
		else if (keyboard_led[3])  number <= 'ha;
		else if (keyboard_led[4])  number <= 'hf;
		else if (keyboard_led[5])  number <= 'h9;
		else if (keyboard_led[6])  number <= 'h6;
		else if (keyboard_led[7])  number <= 'h3;
		else if (keyboard_led[8])  number <= 'h0;
		else if (keyboard_led[9])  number <= 'h8;
		else if (keyboard_led[10]) number <= 'h5;
		else if (keyboard_led[11]) number <= 'h2;
		else if (keyboard_led[12]) number <= 'he;
		else if (keyboard_led[13]) number <= 'h7;
		else if (keyboard_led[14]) number <= 'h4;
		else if (keyboard_led[15]) number <= 'h1;
	 else begin
		number <= 0;
	end
	end
end

        always @(*) begin
        case (number)
         4'h0:   led_display = 7'b0000001;
         4'h1  : led_display =7'b1001111    ;
         4'h2  : led_display =7'b0010010    ;
         4'h3  : led_display =7'b0000110    ;
         4'h4  : led_display =7'b1001100    ;
         4'h5  : led_display =7'b0100100    ;
         4'h6  : led_display =7'b0100000    ;
         4'h7  : led_display =7'b0001111    ;
         4'h8  : led_display =7'b0000000    ;
         4'h9  : led_display =7'b0000100    ;
         4'ha  : led_display = 7'b0001000   ;
         4'hb  : led_display = 7'b1100000   ;
         4'hc  : led_display = 7'b1110010   ;
         4'hd  : led_display = 7'b1000010   ;
         4'he  : led_display = 7'b0110000   ;
         4'hf  : led_display = 7'b0111000   ;
         
    endcase
    end

            
 // 输入行信号           
always @(posedge clk) begin
    case(keycase_cnt[7:2])  //每轮4次扫描，去掉低2位即第几个测试用例计数
        8'b0000_00:
            if(col==4'b1110) row = 4'b1110;  // 测试右边第一列按键输入
            else row = 4'b1111;
        8'b0000_01: 
            if(col==4'b1110) row = 4'b1101;
            else row = 4'b1111;
        8'b0000_10:
            if(col==4'b1110) row = 4'b1011;
            else row = 4'b1111;
        8'b0000_11: 
            if(col==4'b1110) row = 4'b0111;
            else row = 4'b1111;      
        8'b0001_00:                           //测试右边第二列按键输入
            if(col==4'b1101) row = 4'b1110;
            else row = 4'b1111;
        8'b0001_01:
            if(col==4'b1101) row = 4'b1101;
            else row = 4'b1111;
        8'b0001_10: 
            if(col==4'b1101) row = 4'b1011;
            else row = 4'b1111; 
        8'b0001_11: 
            if(col==4'b1101) row = 4'b0111;
            else row = 4'b1111; 
        8'b0010_00:
            if(col==4'b1011) row = 4'b1110;
            else row = 4'b1111;
        8'b0010_01:
            if(col==4'b1011) row = 4'b1101;
            else row = 4'b1111;
          8'b0010_10:
            if(col==4'b1011) row = 4'b1011;
            else row = 4'b1111;
         8'b0010_11:
            if(col==4'b1011) row = 4'b0111;
            else row = 4'b1111;
            
        8'b0011_00:
            if(col==4'b0111) row = 4'b1110;
            else row = 4'b1111;
        8'b0011_01:
            if(col==4'b0111) row = 4'b1101;
            else row = 4'b1111;
          8'b0011_10:
            if(col==4'b0111) row = 4'b1011;
            else row = 4'b1111;
         8'b0011_11:
            if(col==4'b0111) row = 4'b0111;
            else row = 4'b1111;
        default:
            row = 4'b1111; 
    endcase
end

   
endmodule
