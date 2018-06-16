`timescale 1ns/1ns

module signExtend(input[7:0]a, output reg[15:0]b);
  always@(*) begin
    b = $signed(a);
  end
endmodule

