`timescale 1ns/1ns

module registerFile(clk, rst, readReg1, readReg2, writeReg, writeData, wind, readData1, readData2, regWrite); 
  reg[15:0] REGISTER_BANK[7:0]; 
  reg[2:0] reg1, reg2;
  
  input clk, rst, regWrite; 
  input[2:0] readReg1, readReg2, writeReg; 
  input[15:0] writeData;
  input[1:0] wind;
  output reg[15:0] readData1, readData2;
  
  initial begin
    REGISTER_BANK[0] = 16'd0; 
    REGISTER_BANK[1] = 16'd0;
    REGISTER_BANK[2] = 16'd0;
    REGISTER_BANK[3] = 16'd0;
    REGISTER_BANK[4] = 16'd0;
    REGISTER_BANK[5] = 16'd0;
    REGISTER_BANK[6] = 16'd0;
    REGISTER_BANK[7] = 16'd0;
  end

  always@(*) begin
    reg1 = $signed(readRegister1);
    reg2 = $signed(readRegister2);
  end
  
  always@(wind) begin
    case(wind)
      00: begin reg1 = $signed(readRegister1); reg2 = $signed(readRegister2); end
      01: begin reg1 = $signed(readRegister1); reg2 = $signed(readRegister2);
        if(reg1 < 2)
          reg1 = $signed(readRegister1)+2;
        if(reg2 < 2)
          reg2 = $signed(readRegister2)+2 ;
      end
      10: begin reg1 = $signed(readRegister1); reg2 = $signed(readRegister2);
        if(reg1 < 4)
          reg1 = $signed(readRegister1)+4;
        if(reg2 < 4)
          reg2 = $signed(readRegister2)+4;
      end
      11: begin reg1 = $signed(readRegister1); reg2 = $signed(readRegister2);
        if(reg1==0) reg1 = $signed(readRegister1)+6;
        else if(reg1==1) reg1 = $signed(readRegister1)+6;
        else if(reg1==2) reg1 = $signed(readRegister1)-2;
        else if(reg1==3) reg1 = $signed(readRegister1)-2;
         
        if(reg2==0) reg2 = $signed(readRegister2)+6;
        else if(reg2==1) reg2 = $signed(readRegister2)+6;
        else if(reg2==2) reg2 = $signed(readRegister2)-2;
        else if(reg2==3) reg2 = $signed(readRegister2)-2;
      end
    endcase 
  end
  
  
  always@(negedge clk) begin
    if(regWrite == 1)
      REGISTER_BANK[reg1] = writeData;
  end
  
  always@(*) begin
    readData1 = REGISTER_BANK[reg1];
  end
  
  always@(*) begin
    readData2 = REGISTER_BANK[reg2];
  end

  
endmodule









module registerFileTB();
  reg clk, regWrite;
  reg[1:0] readRegister1, readRegister2, wind;
  reg[15:0] writeData;
   
  wire[15:0] readData1, readData2;
  
  registerFile rf(clk, readRegister1, readRegister2, writeData, regWrite, wind, readData1, readData2);
  
  initial begin
    #120 clk = 0;
    #120 clk = 1;
    #120 clk = 0;
    #120 clk = 1;
    #120 clk = 0;
    #120 clk = 1;
    #120 clk = 0;
    #120 clk = 1;
    #120 clk = 0;
    #120 clk = 1;
    #120 clk = 0;
    #120 clk = 1;
  end
  
  initial begin
    #200
		writeData = 16'b0;
		wind = 2'b0;
		readRegister1 = 2'b00;
		readRegister2 = 2'b01;
		#300
		wind = 2'b01;
		readRegister1 = 2'b01;
		regWrite = 1;
		writeData = 16'b1100001101101111; 
  end
endmodule
