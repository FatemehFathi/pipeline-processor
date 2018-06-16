`timescale 1ns/1ns

module dataPath(clk, rst,
                memWrite, memRead, regWrite, jump, branch, flush, ldWnd, selA, selB, dataSel, aluOp, handler, wndSel, //controller in
                ForwardA, ForwardB, //forwarding in
                pcWrite, IFID_write, handlerSel, //hazard in
                is_equal, opc, func, //controller out
                window_EXMEM, window_MEMWB, WB_EXMEM, readReg1_IDX, readReg2_IDEX, readReg1_EXMEM, readReg1_MEMWB, //forwarding out
                M_IDEX); //hazard out
       
       
  //controller           
  input clk, rst;
  input memWrite, memRead, regWrite, jump, branch, flush, ldWnd, selA, selB, dataSel, handler, wndSel; //handler??????????
  input[3:0] aluOp;
  output is_equal;
  output reg[3:0] opc; //opc
  output reg[7:0] func; //func
  
  //forwarding
  input ForwardA, ForwardB;
  output[1:0] window_EXMEM, window_MEMWB;
  output WB_EXMEM; /////////////
  output[1:0] readReg1_IDX, readReg2_IDEX, readReg1_EXMEM, readReg1_MEMWB;
  
  //hazard
  input pcWrite, IFID_write, handlerSel;
  output M_IDEX; /////////////
  

  wire[15:0] inst, instReg;
  wire[9:0] pc, pcRes, pc1Res, pc1, concatRes;
  wire[1:0] pc98;
  wire[15:0] readData1, readData1_IDEX;
  wire[15:0] readData2, readData2_IDEX;
  wire[15:0] SignedExt, SignedExt_IDEX;
  wire[1:0] readReg1_IDEX, readReg1_EXMEM, readReg1_MEMWB;
  wire[1:0] readReg2_IDEX, readReg2_EXMEM;
  wire[1:0] wnd, window_IDEX, window_EXMEM, window_MEMWB;
  wire[9:0] adr_IDEX, adr_EXMEM;
  wire[15:0] muxOut1, muxOut2, muxOut3, muxOut4, muxOut5, muxOut3_EXMEM;
  wire[15:0] aluOut, aluOut_EXMEM, aluOut_MEMWB;
  wire[15:0] data, data_MEMWB;
  wire WB, M, EX, WB_IDEX, M_IDEX, EX_IDEX, WB_EXMEM, M_EXMEM, muxOut6; //////////// chand biti?
  
  reg[1:0] window;
  
  
  always@(*) begin
    assign opc = instReg[15:13];
    assign func = instReg[7:0];
  end
  
  PC p1(pc, pcWrite, pcRes);
  MUX mux1(instReg[9:0], concatRes, pc1, jump, branch, pc);
  instructionMemory instruction_memory(clk, rst, pcRes, inst);
  ALU1 alu1(clk, pcRes, 1, pc1Res);
  IFID IF_ID(clk, flush, IFID_write, inst, pcRes, pc1Res, instReg, pc98, pc1);
  
  always@(*) begin
    if(ldWnd) window = instReg[1:0];
  end
  MUX2 mux8(window, window_MEMWB, wndSel, wnd);
  
  Concat c(pc98, instReg[7:0], concatRes);
  registerFile register_file(clk, rst, instReg[11:10], instReg[9:8], readReg1_MEMWB, muxOut5, wnd, readData1, readData2, regWrite);
  signExtend se(instReg[7:0], SignedExt);
  MUX2 mux2(handler, 0, handlerSel, muxOut6);
  IDEX ID_EX(clk, instReg[9:0], instReg[11:10], instReg[9:8], readData1, readData2, SignedExt, window, WB, M, EX, adr_IDEX, readReg1_IDEX, readReg2_IDEX, readData1_IDEX, readData2_IDEX, SignedExt_IDEX, window_IDEX, WB_IDEX, M_IDEX, EX_IDEX);
  MUX3 mux3(0, readData1_IDEX, SignedExt, selA, muxOut1);
  MUX3 mux4(0, readData2_IDEX, SignedExt, selB, muxOut2);
  MUX3 mux5(muxOut1, 1, muxOut5, ForwardA, muxOut3);
  MUX3 mux6(muxOut2, 1, muxOut5, ForwardB, muxOut4);
  ALU2 alu2(clk, muxOut3, muxOut4, aluOp, aluOut);
  EXMEM EX_MEM(clk, adr_IDEX, muxOut3, aluOut, readReg1_IDEX, readReg2_IDEX, window_IDEX, WB_IDEX, M_IDEX, adr_EXMEM, muxOut3_EXMEM, aluOut_EXMEM, readReg1_EXMEM, readReg2_EXmem, windowEXMEM, WB_EXMEM, M_EXMEM);
  dataMemory data_memory(clk, rst, memWrite, memRead, adr_EXMEM, muxOut3_EXMEM, data);
  MEMWB MEM_WB(clk, data, readReg1_EXMEM, readReg2_EXMEM, aluOut_EXMEM, window_EXMEM, WB_EXMEM, data_MEMWB, readReg1_MEMWB, aluOut_MEMWB, window_MEMWB, regWrite);
  MUX2 mux7(data_MEMWB, aluOut_MEMWB, dataSel, muxOut5);
endmodule



