`timescale 1ns / 1ps
module mux1(
       input [31:0] extended16,data2,
       input op,
       output reg [31:0] out

    );
    
  always @ (*)
   if (op == 0)
    out = data2;
   else 
    out = extended16;
endmodule
