`timescale 1ns / 1ps
module exmem(
    input clk,
    input reset,
    input [31:0] rrex_extended16,extended26,result,rrex_data2,rrex_data1,
    input rrex_branch,rrex_memread,rrex_memtoreg,rrex_memwrite,rrex_regdst,rrex_regwrite,
    input [4:0] rrex_rs,rrex_rd,rrex_rt,
    output reg [31:0] exmem_extended26,exmem_result,exmem_extended16,exmem_data2,exmem_data1,
    output reg exmem_branch,exmem_memread,exmem_memtoreg,exmem_memwrite,exmem_regdst,exmem_regwrite,
    output reg [4:0] exmem_rs,exmem_rd,exmem_rt
    );
    
    always @ (posedge clk)
     if (reset)
     begin
      exmem_extended26 <= 32'b0;
      exmem_result <= 32'b0;
      exmem_extended16 <= 32'b0;
      exmem_branch <= 0;
      exmem_memread <= 0;
      exmem_memtoreg <= 0;
      exmem_memwrite <= 0;
      exmem_regwrite <= 0;
      exmem_regdst <= 0;
      exmem_rd <= 5'b0;
      exmem_rt <= 5'b0;
      exmem_rs <= 5'b0;
      exmem_data2 <= 32'b0;
      exmem_data1 <= 32'b0;
     end
     else
     begin 
      exmem_extended26 <= extended26;
      exmem_result <= result;
      exmem_extended16 <= rrex_extended16;
      exmem_branch <= rrex_branch;
      exmem_memread <= rrex_memread;
      exmem_memtoreg <= rrex_memtoreg;
      exmem_memwrite <= rrex_memwrite;
      exmem_regdst <= rrex_regdst;
      exmem_regwrite <= rrex_regwrite;
      exmem_rd <= rrex_rd;
      exmem_rt <= rrex_rt;
      exmem_rs <= rrex_rs;
      exmem_data2 <= rrex_data2;
      exmem_data1 <= rrex_data1;
     end 
endmodule
