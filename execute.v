`timescale 1ns / 1ps
module execute(
    input [31:0] data1,
    input [31:0] data2,
    input aluop,
    output reg [31:0] result
    );
    
    always @ (*)
     if (aluop == 0)
      result <= data1 - data2;
     else 
      result <= data1 ^ data2; 
endmodule
