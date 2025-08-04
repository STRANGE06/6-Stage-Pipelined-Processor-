`timescale 1ns / 1ps
module stalling(
       input [31:0] ifid_code,code,
       output reg stall

    );
    
    always @ (*)
     if ((ifid_code [31:26] == 6'b100011)&&(ifid_code [20:16] == code[25:21] || ifid_code [20:16] == code [20:16]))
      stall = 1;
     else 
      stall = 0; 
    
endmodule
