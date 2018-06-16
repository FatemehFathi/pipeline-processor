`timescale 1ns/1ns

module cpu(clk, rst);
  input clk, rst;
  
   //controller
  wire memWrite, memRead, regWrite, jump, branch, flush, ldWnd, selA, selB, dataSel, handler, wndSel; //handler??????????
  wire[3:0] aluOp;
  wire is_equal;
  wire[3:0] opc;
  wire[7:0] func;
  
  //forwarding
  wire ForwardA, ForwardB;
  wire[1:0] window_EXMEM, window_MEMWB;
  wire WB_EXMEM; /////////////
  wire[1:0] readReg1_IDX, readReg2_IDEX, readReg1_EXMEM, readReg1_MEMWB;
  
  //hazard
  wire pcWrite, IFID_write, handlerSel;
  wire M_IDEX; /////////////
    
  
  dataPath dp(clk, rst,
                memWrite, memRead, regWrite, jump, branch, flush, ldWnd, selA, selB, dataSel, aluOp, handler, wndSel, //controller in
                ForwardA, ForwardB, //forwarding in
                pcWrite, IFID_write, handlerSel, //hazard in
                is_equal, opc, func, //controller out
                window_EXMEM, window_MEMWB, WB_EXMEM, readReg1_IDX, readReg2_IDEX, readReg1_EXMEM, readReg1_MEMWB, //forwarding out
                M_IDEX); //hazard out
              
  controlUnit cu(rst, clk, opc, func, is_equal, out, aluOp, jump, branch, flush, wind);
  forwardUnit fu(readReg1_EXM, readReg1_MWB, readReg1_IDEX, readReg2_IDEX, M_EXM, WB_MWB, window_EXM, window_MWB, ForwardA, ForwardB);
  hazardUnit hu(readReg1, readReg2, readReg2_IDEX, M_IDEX, pcWrite, IFID_write, handlerSel); 

  //out .. wind .. 
endmodule