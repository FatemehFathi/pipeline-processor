`timescale 1ns/1ns

module PC(pc, pcWrite, pcRes);
  input[9:0] pc;
  input pcWrite;
  output reg[9:0] pcRes;
  
  always@(*) begin
    if(pcWrite)
      pcRes = pc;
  end
endmodule
