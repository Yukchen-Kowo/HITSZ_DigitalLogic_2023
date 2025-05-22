module key_board (clk, rst_n, row, col, data, valid, clk_1k);

  input clk;
  input rst_n;
  input [3:0] row;

  output reg [3:0] col;
  output reg [3:0] data;
  output reg valid;
  output reg clk_1k;

  reg [14:0] cnt;

  parameter T1ms = 24999;

  always @ (posedge clk or negedge rst_n)
    begin
      if (rst_n)
        begin
          clk_1k <= 1'b1;
          cnt <= 15'd0;
        end
      else
        begin
          if (cnt < T1ms)
            begin
              cnt <= cnt + 15'd1;
            end
          else
            begin
              cnt <= 15'd0;
              clk_1k <= ~clk_1k;
            end
        end  
    end

  reg [7:0] row_col;
  reg [1:0] c_state;
  reg [1:0] n_state;
  reg [4:0] count;

  always @ (posedge clk_1k or negedge rst_n)
    if (rst_n) begin
      c_state <= 0;
    end
    else begin
      c_state <= n_state;
    end

  always @ (*)
    begin
        begin
          case (c_state)
            0 : begin
                if (row != 4'b1111)
                  begin
                    n_state = 1;
                  end
              end

            1 : begin
                if (row == 4'b1111)
                  begin
                    n_state = 0;
                  end
                else
                      begin
                        n_state = 2;
                      end
              end

            2 : begin
                if (row == 4'b1111)
                  begin
                    n_state = 2;
                  end
                else
                  begin
                    n_state = 3;
                  end
              end

            3 : begin
                if (row == 4'b1111)
                  begin
                    n_state = 0;
                  end
                else
                  begin
                    n_state = 3;
                  end
              end


            default : n_state = 0;

          endcase
        end
    end  

always @(posedge clk or negedge rst_n) begin
  if(rst_n) begin
    col <= 4'b0000;
    row_col <= 8'd0;
    valid <= 0;
    count <= 0;
  end else begin
    case (c_state)
      1 : begin
                if (row == 4'b1111)
                  begin
                    count <= 0;
                  end
                else
                  begin
                    if (count < 19)
                      begin
                        count <= count + 1;
                      end
                    else
                      begin
                        count <= 0;
                        col <= 4'b0111;
                      end
                  end  
              end

            2 : begin
                if (row == 4'b1111)
                  begin
                    col <= {col[2:0],col[3]};
                  end
                else
                  begin
                    row_col <= {row,col};
                    valid <= 1;
                  end
              end

            3 : begin
                if (row == 4'b1111)
                  begin
                    n_state <= 0;
                    valid <= 0;
                  end
                else
                  begin
                    valid <= 0;
                  end
              end
      default : 
      begin
            col <= 4'b0000;
            row_col <= 8'd0;
            valid <= 0;
            count <= 0;
      end
    endcase
  end
end
  always @ (*)
    begin
      case (row_col)
        8'b0111_0111 : data = 4'h1;
        8'b0111_1011 : data = 4'h2;
        8'b0111_1101 : data = 4'h3;
        8'b0111_1110 : data = 4'ha;

        8'b1011_0111 : data = 4'h4;
        8'b1011_1011 : data = 4'h5;
        8'b1011_1101 : data = 4'h6;
        8'b1011_1110 : data = 4'hb;

        8'b1101_0111 : data = 4'h7;
        8'b1101_1011 : data = 4'h8;
        8'b1101_1101 : data = 4'h9;
        8'b1101_1110 : data = 4'hc;

        8'b1110_0111 : data = 4'he;//*
        8'b1110_1011 : data = 4'h0;
        8'b1110_1101 : data = 4'hf;//#
        8'b1110_1110 : data = 4'hd;

        default : data = 4'h0;
      endcase
    end


endmodule