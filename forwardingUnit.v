`timescale 1ns/1ns
module forwardUnit(readReg1_EXM,readReg1_MWB,readReg1_IDEX,readReg2_IDEX, M_EXM, WB_MWB,window_EXM,window_MWB, ForwardA, ForwardB);
  input[1:0] readReg1_IDEX,readReg2_IDEX,readReg1_EXM,readReg1_MWB;  
  //4ta signal meshki
   input M_EXM, WB_MWB; 
   //2ta signal narenji
   //bara window
   input window_EXM,window_MWB;
   output[1:0] ForwardA, ForwardB;
   //2ta signal kontoroli muxha 
   reg[1:0] ForwardA, ForwardB;
//Forward A 
   always@(M_EXM or readReg1_EXM or readReg1_IDEX or WB_MWB or readReg1_MWB) 
   begin 
      if((M_EXM)&&(readReg1_EXM != 0)&&(readReg1_EXM == readReg1_IDEX)) 
         ForwardA = 2'b10; 
      else if((WB_MWB)&&(readReg1_MWB != 0)&&(readReg1_MWB == readReg1_IDEX)&&(readReg1_EXM != readReg1_IDEX) ) 
         ForwardA = 2'b01; 
      else 
         ForwardA = 2'b00; 
   end 
   //Forward B 
   always@(WB_MWB or readReg1_MWB or readReg2_IDEX or readReg1_EXM or M_EXM) 
   begin 
      if((WB_MWB)&&(readReg1_MWB != 0)&&(readReg1_MWB == readReg2_IDEX)&&(readReg1_EXM != readReg2_IDEX) ) 
         ForwardB = 2'b01; 
      else if((M_EXM)&&(readReg1_EXM != 0)&&(readReg1_EXM== readReg2_IDEX)) 
         ForwardB = 2'b10; 
      else  
         ForwardB = 2'b00; 
   end 
 
endmodule