`timescale 1ns/1ns

module MUX(input[9:0] a, b, c, input sel1, sel2, output reg[9:0] w);
  always@(*) begin
    if(sel1 == 1'b0 && sel2 == 1'b1)
      w = a;
    else if(sel1 == 1'b1 && sel2 == 1'b0)
      w = b;
    else if(sel1 == 1'b0 && sel2 == 1'b0)
      w = c;
  end
endmodule



module MUX2(input[15:0] a, b, input sel, output reg[15:0] w);
  always @(*) begin
    if(sel == 1'b0)
	    w = a;
    else if(sel == 1'b1)
		  w = b;
		else 
		  w = 16'bz;
	end
endmodule


 
module MUX3(input[15:0] a, b, c, input[1:0] sel, output reg[15:0] w);
  always@(*) begin
    if(sel == 2'b00)
	    w = a;
    else if(sel == 2'b01)
		  w = b;
		else if(sel == 2'b10)
		  w = c;
		else
		  w = 16'bz;
	end
endmodule
