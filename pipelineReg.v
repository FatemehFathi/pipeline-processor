`timescale 1ns/1ns
module  IFID(clk, flush, IFID_write, inst, pcRes, pc1Res, instReg, pc98, pc1); 
  input clk, flush, IFID_write; 
  input [15:0]inst;
  input [9:0] pcRes, pc1Res;
  output [15:0]instReg;
  output[9:0] pc1;
  output [1:0]pc98;
  reg [15:0]instReg;
  reg [9:0] pc1;
  reg [1:0]pc98;
  
    initial begin 
        instReg = 0; 
        pc1 = 0; 
    end 
     
    always@(posedge clk) 
    begin 
        if(flush) 
        begin 
           instReg <= 0; 
           pc1 <= 0; 
        end 
        else if(IFID_write) 
        begin 
           instReg <= inst; 
           pc98 <=pc1Res[9:8];
           pc1<=pc1Res;
        end 
    end 
 
endmodule



////////////////////////////////////////////////////////////////////////////////////////////////////



module IDEX(clk, instReg[9:0], readReg1,readReg2,readData1,readData2,SignedExt,window,WB,M,EX,adr_IDEX,
 readReg1_IDEX, readReg2_IDEX, readData1_IDEX, readData2_IDEX, SignedExt_IDEX, window_IDEX, WB_IDEX, M_IDEX, EX_IDEX); 

  input clk;
  input[9:0]instReg;
  input[1:0]readReg1,readReg2;
  input[15:0] readData1, readData2, SignedExt;
  input[1:0] window, WB;
  input[2:0] M;
  input[3:0] EX;
  
  output [9:0]adr_IDEX;
  output [1:0]readReg1_IDEX, readReg2_IDEX;
  output[15:0] readData1_IDEX, readData2_IDEX, SignedExt_IDEX;
  output[1:0] window_IDEX;
  output WB_IDEX, M_IDEX, EX_IDEX; //////////////////////////nemidonim
 
  reg [9:0]adr_IDEX;
  reg [1:0]readReg1_IDEX, readReg2_IDEX;
  reg[15:0] readData1_IDEX, readData2_IDEX, SignedExt_IDEX;
  reg[1:0] window_IDEX;
  reg WB_IDEX, M_IDEX, EX_IDEX; ///////////////////////////////nemidonim
     
    initial begin 
     adr_IDEX=0;
     readReg1_IDEX=0;
     readReg2_IDEX=0;
     readData1_IDEX=0;
     readData2_IDEX=0;
     SignedExt_IDEX=0;
     window_IDEX=0;
     WB_IDEX=0;
     M_IDEX=0;
     EX_IDEX=0;  
    end 
     
    always@(posedge clk) 
    begin 
     adr_IDEX<= instReg;
     readReg1_IDEX<=readReg1;
     readReg2_IDEX<=readReg2;
     readData1_IDEX<=readData1;
     readData2_IDEX<=readData2;
     SignedExt_IDEX<=SignedExt;
     window_IDEX<=window;
     WB_IDEX<=WB;
     M_IDEX<=M;
     EX_IDEX<=EX;
    end    
endmodule 



////////////////////////////////////////////////////////////////////////////////////////////////////



module EXMEM(clk, adr_IDEX, muxOut3, aluOut, readReg1_IDEX, readReg2_IDEX, window_IDEX, WB_IDEX, M_IDEX, adr_EXMEM,
 muxOut3_EXMEM, aluOut_EXMEM, readReg1_EXMEM, readReg2_EXmem, windowEXMEM, WB_EXMEM, M_EXMEM);
 
 input clk;
 input[9:0] adr_IDEX;
 input[15:0] muxOut3, aluOut;
 input[1:0] readReg1_IDEX, readReg2_IDEX, window_IDEX;
 input WB_IDEX, M_IDEX;////////////////////////////????????????????????????????//
 
 output [9:0]adr_EXMEM;
 output[15:0] muxOut3_EXMEM, aluOut_EXMEM;
 output[1:0] readReg1_EXMEM, readReg2_EXmem, windowEXMEM;
 output WB_EXMEM, M_EXMEM;///////////////////////////////////???????????????????????????????///
 
 reg [9:0]adr_EXMEM;
 reg[15:0] muxOut3_EXMEM, aluOut_EXMEM;
 reg[1:0] readReg1_EXMEM, readReg2_EXmem, windowEXMEM;
 reg WB_EXMEM, M_EXMEM;///////////////////////////////////???????????????????????????????/// 
 
  
    
   initial begin 
       adr_EXMEM=0;
       muxOut3_EXMEM=0;
       aluOut_EXMEM=0;
       readReg1_EXMEM=0;
       readReg2_EXmem=0;
       windowEXMEM=0;
       WB_EXMEM=0;
       M_EXMEM=0; 
   end 
    
    
    always@(posedge clk) 
    begin 
         adr_EXMEM <=adr_IDEX;
         muxOut3_EXMEM <=muxOut3;
         aluOut_EXMEM <=aluOut;
         readReg1_EXMEM <=readReg1_IDEX;
         readReg2_EXmem <=readReg2_IDEX;
          windowEXMEM<=window_IDEX;
    end 
 
endmodule 



////////////////////////////////////////////////////////////////////////////////////////////////////



module MEMWB(clk, data, readReg1_EXMEM, readReg2_EXMEM, aluOut_EXMEM, window_EXMEM, WB_EXMEM, data_MEMWB, readReg1_MEMWB, aluOut_MEMWB, window_MEMWB, regWrite); 
    
   input clk;
   input[15:0] data;
   input[1:0] readReg1_EXMEM, readReg2_EXMEM;
   input[15:0] aluOut_EXMEM;
   input[1:0] window_EXMEM;
   input WB_EXMEM;//////////////////////?????????????????????????????????
   
   
    output[15:0] data_MEMWB;
    output[1:0] readReg1_MEMWB;
    output[15:0] aluOut_MEMWB;
    output[1:0] window_MEMWB;
    output regWrite;/////////////////////////chandbit?????????????
    
    reg[15:0] data_MEMWB;
    reg[1:0] readReg1_MEMWB;
    reg[15:0] aluOut_MEMWB;
    reg[1:0] window_MEMWB;
    reg regWrite; 
    
    
   initial begin 
       data_MEMWB=0;
       readReg1_MEMWB=0;
       aluOut_MEMWB=0;
       window_MEMWB=0;
       regWrite=0;       
   end 
    
    always@(posedge clk) 
    begin 
       data_MEMWB<=data;
     readReg1_MEMWB<=readReg1_EXMEM;
     aluOut_MEMWB<=aluOut_EXMEM;
    window_MEMWB<=window_EXMEM;
     regWrite<= WB_EXMEM;
    end 
    
endmodule
