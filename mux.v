`timescale 1ns / 1ps
module mux(input [4:0] in0,in1,
           input regdst,
           output reg [4:0]out

    );
    always @ (*)
    out <= regdst ? in1 : in0;
endmodule
