module bin2bcd_12bit(bin, bcd);

  input [19:0] bin;
  output reg [23:0] bcd;

  always @ (*)
    begin
      bcd[3:0] = bin%10;
      bcd[7:4] = bin/10%10;
      bcd[11:8] = bin/100%10;
      bcd [15:12] = bin/1000%10;
      bcd[19:16] = bin/10000%10;
      bcd[23:20] = bin/100000%10;
    end

endmodule