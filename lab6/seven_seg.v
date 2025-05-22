module seven_seg (clk, rst_n, data_in, sel, seg);

  input clk;
  input rst_n;
  input [23:0] data_in;

  output [7:0] sel;
  output [7:0] seg;

  wire clk_1k;

  freq freq_dut(
      .clk(clk), 
      .rst_n(rst_n),
      .clk_1k(clk_1k)
    );

  sel_seg_encode sel_seg_encode_dut(
      .clk(clk_1k), 
      .rst_n(rst_n), 
      .data_in(data_in), 
      .sel(sel), 
      .seg(seg)
    );


endmodule

module freq (clk, rst_n, clk_1k);

  input clk;
  input rst_n;

  output reg clk_1k;

  reg [14:0] cnt;

  always @ (posedge clk or negedge rst_n)
    begin
      if (rst_n)
        begin
          clk_1k <= 1;
          cnt <= 0;
        end
      else
        begin
          if (cnt < 24_999)
            begin
              cnt <= cnt + 1;
            end
          else
            begin
              cnt <= 0;
              clk_1k <= ~clk_1k;
            end
        end
    end

endmodule

module sel_seg_encode (clk, rst_n, data_in, sel, seg);

  input clk;
  input rst_n;
  input [23:0] data_in;

  output [7:0] sel;
  output [7:0] seg;

  wire [3:0] num;

  seg_encode seg_encode_dut(
        .rst_n(rst_n),
        .num(num),
        .seg(seg)
      );

  sel_encode sel_encode_dut(
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .num(num),
        .sel(sel)
      );


endmodule

module seg_encode (rst_n, num, seg);

  input rst_n;
  input [3:0] num;

  output reg [7:0] seg;

  always @ (*)
    begin
      if (rst_n)
        begin
          seg = 8'b0000_0000;
        end
      else
        begin
          case (num)
            0 : seg = 8'b1100_0000;
            1 : seg = 8'b1111_1001;
            2 : seg = 8'b1010_0100;
            3 : seg = 8'b1011_0000;
            4 : seg = 8'b1001_1001;
            5 : seg = 8'b1001_0010;
            6 : seg = 8'b1000_0010;
            7 : seg = 8'b1111_1000;
            8 : seg = 8'b1000_0000;
            9 : seg = 8'b1001_0000;
            default : seg = 8'b0000_0000;
          endcase
        end
    end

endmodule

module sel_encode (clk, rst_n, data_in, num, sel);

  input clk;
  input rst_n;
  input [23:0] data_in;

  output reg [3:0] num;
  output reg [7:0] sel;

  always @ (posedge clk or negedge rst_n)
    begin
      if (rst_n)
        begin
          sel <= 8'b1111_1110;
        end
      else
        begin
          sel <= {sel[6:0],sel[7]};
        end
    end

  always@(*)
    begin
      if (rst_n)
        begin
          num = 0;
        end
      else
        begin
          case (sel)
            8'b1111_1110 : num = data_in[23:20];
            8'b1111_1101 : num = data_in[19:16];
            8'b1111_1011 : num = data_in[15:12];
            8'b1111_0111 : num = data_in[11:8];
            8'b1110_1111 : num = data_in[7:4];
            8'b1101_1111 : num = data_in[3:0];
            default : num = 0;
          endcase
        end
    end

endmodule