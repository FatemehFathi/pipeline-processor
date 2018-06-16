`timescale 1ns/1ns

module Concat(input[1:0] a, input[7:0] b, output[9:0] w);
  assign w = {a, b};
endmodule
