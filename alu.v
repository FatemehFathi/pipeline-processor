`timescale 1ns/1ns            


module ALU1(input[15:0] a, b, output[15:0] w);
  assign w = a + b;
endmodule



module ALU2(input[15:0] a, b, input[3:0] aluOp, output reg[15:0] w);
  always@(*) begin
    case (aluOp)
      0000: w <= b; //move
      0001: w <= a + b; //add
      0010: w <= a - b; //sub
      0011: w <= a & b; //and
      0100: w <= a | b; //or
      0101: w <= ~a; //not
      0110: begin end //nop
      0111: w <= a + b; //addi
      1000: w <= a - b; //subi
      1001: w <= a & b; //andi
      1010: w <= a | b; //ori
    endcase
  end
endmodule











module ALU2TB();
   reg[15:0] a, b;
   reg[3:0] aluOp;
   wire[15:0] w;
   
   ALU2 a2(a, b, aluOp, w);
   
   initial begin
     #10 a = 16'b0;
     b = 16'b0000000000000111;
     aluOp = 0001;
     
     #40 aluOp = 0010;
     b = 16'b0;
     a = 16'b0000000000000111;
   end

endmodule