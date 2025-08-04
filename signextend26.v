`timescale 1ns / 1ps
module signextend26(
     input [25:0] address,
     input [31:0] pc,
     output reg [31:0] extended26
    );
    
    always @ (*)
    extended26 <= {pc[31:28], address, 2'b00};

endmodule
