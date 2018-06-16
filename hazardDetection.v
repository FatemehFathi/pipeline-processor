`timescale 1ns/1ns

module hazardUnit(readReg1,readReg2,readReg2_IDEX,M_IDEX,pcWrite,IFID_write,handlerSel); 
    input [3:0] readReg1,readReg2,readReg2_IDEX; 
    input M_IDEX; 
    output pcWrite, IFID_write, handlerSel; 
     
    reg pcWrite, IFID_write, handlerSel; 
     
    always@(readReg1,readReg2,readReg2_IDEX,M_IDEX) 
    if(M_IDEX&((readReg2_IDEX == readReg1)|(readReg2_IDEX  == readReg2))) 
       begin//stall 
           pcWrite = 0; 
           IFID_write = 0; 
           handlerSel = 0; 
       end 
    else 
       begin//no stall 
           pcWrite = 1; 
           IFID_write = 1; 
           handlerSel = 1; 
     
       end 
 
endmodule