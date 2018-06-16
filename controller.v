`timescale 1ns/1ns
module controlUnit(rst,clk,opc,func,is_equal,out,aluOp,jump,branch,flush,wind,ldWdn,handler);
  
  input rst,is_equal,clk;
  input[3:0]opc;
  input[7:0]func;
  
  output out,aluOp,wind,jump,branch,flush,ldWdn,handler;
  
  reg[7:0]out;
  reg[3:0]aluOp;
  reg[1:0]wind;
  reg jump,branch,flush,handler;
  
  reg memRead,memWrite,regWrite;
  reg [1:0]selA,selB;
  reg ldWdn;
  reg dataSel;
  reg [1:0]M;
  reg [1:0]WB;
  reg [3:0]EX;

  
  
  always@(*) begin
    if(rst)begin
       case(opc)
      0000: begin jump<=0; regWrite<=1;  memRead<=1; memWrite<=0;branch=0;selA=00;selB=10;flush=0;aluOp<=4'b0001;dataSel=0;  end //load
      0001: begin jump<=0; regWrite<=0;  memRead<=0; memWrite<=1;branch=0;selA=01;selB=00;flush=0;aluOp<=4'b0001;dataSel=0;  end //store
      0010: begin jump<=1; regWrite<=0;  memRead<=0; memWrite<=0;branch=0;selA=00;selB=00;flush=0;aluOp<=4'b0110;dataSel=0;  end //jump
      0100: begin jump<=0; regWrite<=0; memRead<=0; memWrite<=0;
      if(is_equal)begin
       branch=1;flush=1;end
       else begin branch=0;flush=0; end 
       selA=00;selB=00;dataSel=0;  end //branch
      
      1000: begin
             if(func==8'b00000001) begin jump<=0;  regWrite<=0;  memRead<=0; memWrite<=0;  aluOp<=4'b0000;
             branch=0;flush=0;selA=00;selB=01;dataSel=1; end //move
        else if(func==8'b00000010) begin jump<=0;  regWrite<=1;  memRead<=0; memWrite<=0;  aluOp<=4'b0001;
        branch=0;flush=0;selA=01;selB=01;dataSel=1; end //add
        else if(func==8'b00000100) begin jump<=0;  regWrite<=1;  memRead<=0; memWrite<=0;  aluOp<=4'b0010;
        branch=0;flush=0;selA=01;selB=01;dataSel=1; end //sub
        else if(func==8'b00001000) begin jump<=0;  regWrite<=1;  memRead<=0; memWrite<=0;  aluOp<=4'b0011;
        branch=0;flush=0;selA=01;selB=01;dataSel=1; end //and
        else if(func==8'b00010000) begin jump<=0;  regWrite<=1;  memRead<=0; memWrite<=0;  aluOp<=4'b0100;
        branch=0;flush=0;selA=01;selB=01;dataSel=1; end //or   
        else if(func==8'b00100000) begin jump<=0;  regWrite<=1;  memRead<=0; memWrite<=0;  aluOp<=4'b0101;
        branch=0;flush=0;selA=00;selB=01;dataSel=1; end //not
        else if(func==8'b01000000) begin jump<=0;  regWrite<=0;  memRead<=0; memWrite<=0;  aluOp<=4'b0110;
        branch=0;flush=0;selA=00;selB=00;dataSel=1; end //NOP
        else if(func==8'b10000000) begin jump<=0;  regWrite<=0;  memRead<=0; memWrite<=0;  wind<=2'b00;
        branch=0;flush=0;selA=00;selB=00;ldWdn=1; end //wind0
        else if(func==8'b10000001) begin jump<=0;  regWrite<=0;  memRead<=0; memWrite<=0;  wind<=2'b01;
        branch=0;flush=0;selA=00;selB=00;ldWdn=1; end //wind1
        else if(func==8'b10000010) begin jump<=0;  regWrite<=0;  memRead<=0; memWrite<=0;  wind<=2'b10;
        branch=0;flush=0;selA=00;selB=00;ldWdn=1; end //wind2
        else if(func==8'b10000011) begin jump<=0;  regWrite<=0;  memRead<=0; memWrite<=0;  wind<=2'b11;
        branch=0;flush=0;selA=00;selB=00;ldWdn=1; end //wind3
    end
      
      1100: begin jump<=0; regWrite<=1; memRead<=0; memWrite<=0; aluOp<=4'b0111;
      branch<=0;flush<=0;selA<=10;selB<=01;aluOp<=4'b0001;dataSel=1; end //addi
      1101: begin jump<=0; regWrite<=1; memRead<=0; memWrite<=0; aluOp<=4'b1000;
      branch<=0;flush<=0;selA<=10;selB<=01;aluOp<=4'b0010;dataSel=1; end //subi
      1110: begin jump<=0; regWrite<=1; memRead<=0; memWrite<=0; aluOp<=4'b1001;
      branch<=0;flush<=0;selA<=10;selB<=01;aluOp<=4'b0011;dataSel=1; end //andi
      1111: begin jump<=0; regWrite<=1; memRead<=0; memWrite<=0; aluOp<=4'b1010;
      branch<=0;flush<=0;selA<=10;selB<=01;aluOp<=4'b0100;dataSel=1; end //ori
      
      
    endcase
  end//if
end//alwayas
  
  always@(*)begin
   EX[0]=selA[0];
   EX[1]=selA[1];
   EX[2]=selB[0];
   EX[3]=selB[1];
 
   M[0]=memRead;
   M[1]=memWrite;
  
   WB[0]=regWrite;
   WB[1]=dataSel;
   
  
   out[3:0]=EX;
   out[5:4]=M;
   out[7:6]=WB; 
end
  
  

endmodule

