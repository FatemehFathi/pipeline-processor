`timescale 1ns/1ns

module shiftLeft2(input[9:0] a, output reg[9:0] b);
  always@(*) begin
    b = a << 2;
  end
endmodule
