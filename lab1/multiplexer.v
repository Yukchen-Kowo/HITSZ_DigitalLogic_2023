`timescale 1ns / 1ps

module multiplexer(
     input wire enable,
     input wire select,
     input wire [3:0] input_a,
     input wire [3:0] input_b,
     output reg [3:0] led
);

always @ (*) begin
    if (enable == 1'b0) led = 4'b1111;
    else if (select == 1'b1) led = input_a-input_b;
    else led = input_a+input_b;     
end 

endmodule
