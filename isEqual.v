`timescale 1ns/1ns

module isEqual(input[15:0] a, b, output reg c); 
  always@(*) begin
    if(a == b)
      c = 1;
    else
      c = 0;
  end  
endmodule
