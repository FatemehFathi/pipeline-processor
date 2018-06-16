`timescale 1ns/1ns

module dataMemory(input clk, rst, memWrite, memRead, input[9:0] adr, input[15:0] writeData, output reg[15:0] data); 
  reg[7:0] datamem[0:1023];
  
  always@(posedge rst)
    $readmemb("data.dat", datamem);
    
  always@(posedge clk) begin
    if(memWrite) 
      datamem[adr] <= writeData;
    end
  
  always@(memRead or adr) begin
    if(memRead) begin
      data = datamem[adr];
    end
  end
endmodule







module dataMemory_TB();
  
  reg clk, rst, memRead, memWrite;
  reg[9:0] addr;
  reg[15:0] writeData;
  wire[15:0] data;
  
  dataMemory data_memory(clk, rst, memWrite, memRead, addr, writeData, data);
  
  initial begin
      #100 clk=1;
      #100 clk = 0;
      #100 clk = 1;
      #100 clk=0;
      #100 clk = 1;
      #100 clk=0;
      #100 clk = 1;
      #100 clk=0;
      #100 clk = 1;
      #100 clk=0;
      #100 clk = 1;
      #100 clk=0;
      #100 clk = 1;
      #100 clk=0;
      repeat(40) #40 clk = ~clk;
    end
    
    initial  begin
      #10 rst = 1;
      #100 addr = 16'b0000000000000000;
      #100 addr = addr + 1;
      #100 addr = addr + 1;
      #100 addr = addr + 1;
      #100 addr = addr + 1;
      #100 rst = 0;
      #100 memRead = 1;
      #100 addr = 16'b0000000000000000;
      #100 addr = addr + 1;
      #100 memRead = 0;
      #100 writeData =16'b 0000000000001100;
      #100 addr = 16'b0000000000000000;
      #100 memWrite = 1;
    end
 endmodule

