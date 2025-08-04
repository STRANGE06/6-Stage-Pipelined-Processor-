`timescale 1ns / 1ps
module memwb(
       input clk,
       input reset,
       input [31:0] exmem_extended26,exmem_result,readdata,
       input exmem_branch,exmem_memtoreg,exmem_regdst,exmem_regwrite,
       input [4:0] exmem_rd,exmem_rt,
       output reg [31:0] memwb_extended26,memwb_result,memwb_readdata,
       output reg memwb_branch,memwb_memtoreg,memwb_regdst,memwb_regwrite,
       output reg [4:0] memwb_rd,memwb_rt
    );
    
    always @ (posedge clk)
     if (reset)
      begin 
       memwb_extended26 <= 32'b0;
       memwb_result <= 32'b0;
       memwb_readdata <= 32'b0;
       memwb_branch <= 0;
       memwb_memtoreg <= 0;
       memwb_regdst <= 0;
       memwb_regwrite <= 0;
       memwb_rd <= 5'b0;
       memwb_rt <= 5'b0;
      end
     else
      begin
       memwb_extended26 <= exmem_extended26;
       memwb_result <= exmem_result;
       memwb_readdata <= readdata;
       memwb_branch <= exmem_branch;
       memwb_memtoreg <= exmem_memtoreg;
       memwb_regdst <= exmem_regdst;
       memwb_regwrite <= exmem_regwrite; 
       memwb_rd <= exmem_rd;
       memwb_rt <= exmem_rt;
      end 
endmodule
