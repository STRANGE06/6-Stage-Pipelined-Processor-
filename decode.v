`timescale 1ns / 1ps
module decode(
    input [31:0] ifid_code,
    output reg [4:0] rs, rt, rd,
    output reg [5:0] opcode,func,
    output reg [15:0] offset,
    output reg [25:0] address
);
    
always @(*) begin

    opcode = ifid_code[31:26];
    
    rs = 5'b0;
    rt = 5'b0;
    rd = 5'b0;
    offset = 16'b0;
    address = 26'b0;
    func = 6'b0;
    
    case(opcode)
        // lw, sw, xori
        6'b100011, 6'b101011, 6'b001110: begin
            rs = ifid_code[25:21];
            rt = ifid_code[20:16];
            offset = ifid_code[15:0];
        end
        
        // R-type instructions
        6'b000000: begin
            rs = ifid_code[25:21];
            rt = ifid_code[20:16];
            rd = ifid_code[15:11];
            func = ifid_code[5:0];  
        end
        
        // j-type
        6'b000010: begin
            address = ifid_code[25:0];
        end
        
        default: begin
      
        end
    endcase
end
endmodule