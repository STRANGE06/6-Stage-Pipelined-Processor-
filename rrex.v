`timescale 1ns / 1ps
module rrex(
     input clk,reset,
     input [4:0] idrr_rs,idrr_rt, idrr_rd,
     input [5:0] idrr_opcode,idrr_func,
     input idrr_regwrite,idrr_regdst,idrr_aluop,idrr_memread,idrr_memwrite,idrr_memtoreg,idrr_branch,
     input [31:0] idrr_pc,data1,data2,extended16,
     input [25:0] idrr_address,
     output reg  rrex_regwrite,rrex_regdst,rrex_aluop,rrex_memread,rrex_memwrite,rrex_memtoreg,rrex_branch,
     output reg [31:0] rrex_pc,rrex_data1,rrex_data2,rrex_extended16,
     output reg [4:0] rrex_rs,rrex_rt,rrex_rd,
     output reg [25:0] rrex_address
    );
    
    
    always @ (posedge clk)
     if (reset)
      begin
       rrex_regwrite <= 0;
       rrex_regdst <= 0;
       rrex_aluop <= 0;
       rrex_memread <= 0;
       rrex_memwrite <= 0;
       rrex_memtoreg <= 0;
       rrex_branch <= 0;
       rrex_pc <= 32'b0;
       rrex_data1 <= 32'b0;
       rrex_data2 <= 32'b0;
       rrex_extended16 <= 32'b0;       
       rrex_rt <= 5'b0;
       rrex_rd <= 5'b0;
       rrex_rs <= 5'b0;
       rrex_address <= 26'b0;
      end
     else
      begin
       rrex_regwrite <= idrr_regwrite;
       rrex_regdst <= idrr_regdst;
       rrex_aluop <= idrr_aluop;
       rrex_memread <= idrr_memread;
       rrex_memwrite <= idrr_memwrite;
       rrex_memtoreg <= idrr_memtoreg;
       rrex_branch <= idrr_branch;
       rrex_pc <= idrr_pc;
       rrex_data1 <= data1;
       rrex_data2 <= data2;
       rrex_extended16 <= extended16;       
       rrex_rt <= idrr_rt;
       rrex_rd <= idrr_rd;
       rrex_rs <= idrr_rs;
       rrex_address <= idrr_address;
      end 
endmodule
