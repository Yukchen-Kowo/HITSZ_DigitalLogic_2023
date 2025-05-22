module calculator (clk, rst_n, flag, key_data, s2_out, valid_s2,bin_data);

  input clk;
  input rst_n;
  input flag;
  input [3:0] key_data;
  input s2_out;
  input valid_s2;

  output reg [19:0] bin_data;

  reg [1:0] c_state;
  reg [1:0] n_state;
  reg [19:0] num1;
  reg [3:0] opcode;

  always @(posedge clk or negedge rst_n) begin
    if(rst_n) begin
      c_state <= 0;
    end else begin
      c_state <= n_state;
    end
  end
always @ (*)
    begin
        begin
          case (c_state)
            0 : begin
                if (flag)
                  begin
                    if (key_data >= 10)
                      begin
                        if (s2_out)
                          begin
                            n_state = 0;
                          end
                        else
                          begin
                            n_state = 1;
                          end
                      end
                  end
                else
                  begin
                    n_state = 0;
                  end
              end

            1 : begin
                if (flag)
                  begin
                    if (key_data >= 10)
                      begin
                        n_state = 1;
                      end
                  end
                else if (valid_s2) begin
                  n_state = 2; 
                  end
                else
                  begin
                    n_state = 1;
                  end
              end

            2 : begin
                if (flag)
                  begin
                    if (key_data < 10)
                      begin
                        n_state = 0;
                      end
                    else
                      begin
                        if (s2_out)
                          begin
                            n_state = 2;
                          end
                        else
                          begin
                            n_state =1;
                          end
                      end
                  end
                else
                  begin
                    n_state = 2;
                  end
              end
          endcase
        end
    end

always @(posedge clk or negedge rst_n) begin
    begin
      if (rst_n)
        begin
          num1 <= 0;
          bin_data <= 0;
          opcode <= 0;
        end
      else
        begin
          case (c_state)
            0 : begin
                if (flag)
                  begin
                    if (key_data < 10)
                      begin
                        bin_data <= bin_data * 10 + key_data;
                      end
                    else
                      begin
                        if (!s2_out)
                          begin
                            opcode <= key_data;
                            num1 <= bin_data;
                            bin_data <= 0;
                          end
                      end
                  end
              end

            1 : begin     
                if (flag)
                  begin
                    if (key_data < 10)
                      begin
                        bin_data <= bin_data * 10 + key_data;
                      end
                  end
                else if (valid_s2) begin
                    case (opcode)
                      10 :  begin bin_data <= num1 + bin_data;end
                      11 :  begin bin_data <= num1 - bin_data;end
                      12 :  begin bin_data <= num1 * bin_data;end
                      13 :   begin bin_data <= num1 / bin_data;end
                      default : bin_data <= 0;
                    endcase 
                  end
              end
            2 : begin
                if (flag)
                  begin
                    if (key_data < 10)
                      begin
                        bin_data <= {16'd0,key_data};
                      end
                    else
                      begin
                        if (!s2_out)
                          begin
                            num1 <= bin_data;
                            opcode <= key_data;
                            bin_data <= 0;
                          end
                      end
                  end
              end
          endcase
        end
    end

endmodule