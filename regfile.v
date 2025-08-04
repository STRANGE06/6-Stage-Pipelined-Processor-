`timescale 1ns / 1ps
module regfile(
    input [4:0] readreg1, readreg2, writereg,
    input [31:0] writedata,
    output reg [31:0] data1, data2,  
    input regwrite,clk
);

    reg [31:0] regmem [31:0]; 
    integer k;
    
    initial begin
        for (k = 0; k < 32; k = k + 1)
            regmem[k] = 0;  
    end

 
    always @(negedge clk) begin
        data1 <= regmem[readreg1];  
        data2 <= regmem[readreg2];
    end

   
    always @(posedge clk) begin
      if (regwrite && writereg != 5'b00000) begin
            regmem[writereg] <= writedata;  
        end
    end

endmodule
