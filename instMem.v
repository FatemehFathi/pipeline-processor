`timescale 1ns/1ns

module instructionMemory(input clk, rst, input[9:0] addr, output reg[15:0] inst);
  reg[15:0]instmem[0:1023];

  always@(*) begin
    if (rst)
      $readmemb("inst.dat", instmem);
    else
      inst = instmem[addr];
    end
    
endmodule
  
  
  
  
  
  

module instructionMemory_TB();
  reg clk, rst;
  reg [9:0] addr;
  wire [15:0] inst;
  
  instructionMemory instruction_memory(clk, rst, addr, inst);
  
  initial  begin
    #10 rst = 0;
    #100 rst = 1;
    #100 addr = 16'b0000000000000000;
    #100 addr = addr + 1;
    #100 addr = addr + 1;
    #100 addr = addr + 1;
    #100 addr = addr + 1;
  end
endmodule

