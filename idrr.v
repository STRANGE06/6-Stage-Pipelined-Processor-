`timescale 1ns / 1ps
module idrr(
     input clk,reset,
     input [4:0] rs, rt, rd,
     input [5:0] opcode,func,
     input [15:0] offset,
     input [25:0] address,
     input [31:0] ifid_pc,
     input regwrite,regdst,aluop,memread,memwrite,memtoreg,branch,
     output reg [4:0] idrr_rs, idrr_rt, idrr_rd,
     output reg [5:0] idrr_opcode,idrr_func,
     output reg [15:0] idrr_offset,
     output reg [25:0] idrr_address,
     output reg [31:0] idrr_pc,
     output reg idrr_regwrite,idrr_regdst,idrr_aluop,idrr_memread,idrr_memwrite,idrr_memtoreg,idrr_branch
    );
    
    always @(posedge clk)
       if (reset == 1)
          begin          
           idrr_rs <= 5'b0;
           idrr_rd <= 5'b0;
           idrr_rt <= 5'b0;
           idrr_offset <= 16'b0;
           idrr_opcode <= 6'b0;
           idrr_func <= 6'b0;
           idrr_address <= 26'b0;
           idrr_pc <= 32'b0;
           idrr_regwrite  <= 0;
           idrr_regdst <= 0;
           idrr_aluop <= 0;
           idrr_memread <= 0;
           idrr_memwrite <= 0;
           idrr_memtoreg <= 0;
           idrr_branch <= 0;
          end
         else
          begin          
           idrr_rs <= rs;
           idrr_rt <= rt;
           idrr_rd <= rd;
           idrr_offset <= offset;
           idrr_opcode <= opcode;
           idrr_func <= func;
           idrr_address <= address;
           idrr_pc <= ifid_pc;
           idrr_regwrite <= regwrite;
           idrr_regdst <= regdst;
           idrr_regdst <= regdst;
           idrr_aluop <= aluop;
           idrr_memread <= memread;
           idrr_memwrite <= memwrite;
           idrr_memtoreg <= memtoreg;
           idrr_branch <= branch;
          end
          
endmodule          
