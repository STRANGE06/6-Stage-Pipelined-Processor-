`timescale 1ns / 1ps
module jump(input [5:0] opcode,
            output reg j
           

    );
    
 always @ (opcode)
  if (opcode == 6'b000010)
   j =1;
  else 
   j = 0; 
endmodule
