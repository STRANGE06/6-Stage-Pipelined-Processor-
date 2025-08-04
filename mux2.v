`timescale 1ns / 1ps
module mux2(input [31:0] in0,in1,
            input ctrl,
            output wire [31:0]out 

    );
    
    assign out = ctrl ? in1 : in0;
endmodule
