`timescale 1ns / 1ps

module multiplexer(
    input [2:0] sel,
    input [7:0] r0,
    input [7:0] r1,
    input [7:0] r2,
    input [7:0] r3,
    input [7:0] r4,
    input [7:0] r5,
    input [7:0] r6,
    input [7:0] r7,
    output reg [7:0] q
    
);
    always @(*) begin
        case (sel)
            3'h0: q = r0;
            3'h1: q = r1;
            3'h2 :q = r2 ;
            3'h3 :q = r3 ;
            3'h4 :q = r4 ;
            3'h5 :q = r5 ;
            3'h6 :q = r6 ;
            3'h7 :q = r7 ;
            default : q = 0;
        
        endcase
    
    end

endmodule
