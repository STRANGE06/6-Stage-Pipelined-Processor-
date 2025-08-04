`timescale 1ns / 1ps
module ifid(
    input clk,
    input reset,
    input [31:0] code,
    input [31:0] pc,
    output reg [31:0] ifid_code,
    output reg [31:0] ifid_pc
    );
    
     always @ (posedge clk)
     begin
      if (reset ==1 )
      begin
       ifid_code <= 32'b0;
       ifid_pc <= 32'b0;
      end 
      else
      begin
       ifid_code <= code; 
       ifid_pc <= pc;
      end 
     end
     
endmodule
