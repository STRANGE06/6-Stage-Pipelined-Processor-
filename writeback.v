`timescale 1ns / 1ps
module writeback(
       input [31:0] readdata,result,
       input memtoreg,
       output [31:0]writedata
    );
    
    assign writedata = memtoreg ? readdata : result;
endmodule
