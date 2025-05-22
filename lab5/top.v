`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/19 10:59:00
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input         clk,
    input         reset,
    input  [3:0]  row,
    output [3:0]  col,
    output        keyboard_en,
    output [15:0] keyboard_led,
    output [3:0]  keyboard_num,
    output reg [6:0] led_display,
    output reg [7:0] led_en
);

keyboard u_keyboard(
    .clk(clk), 
    .reset(reset), 
    .row(row), 
    .col(col), 
    .keyboard_en(keyboard_en), 
    .keyboard_led(keyboard_led),   //按键DCBA#9630852*741对应GLD0-GLD7:YLD0-YLD7
    .keyboard_num(keyboard_num)    // 因只亮一个周期，直接送到led显示将看不到灯亮
);
    reg [3:0] number;
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
    
        always@(posedge clk or posedge reset) begin
        if(reset)   
            led_en = 8'b1111_1111;
        else if(keyboard_led == 0)
            led_en = 8'b1111_1111;
        else
            led_en = 8'b0111_1111;
    
    end
endmodule