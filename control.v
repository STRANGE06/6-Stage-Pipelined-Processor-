`timescale 1ns / 1ps
module control(
input [5:0]opcode,
output reg regwrite,regdst,aluop,memread,memwrite,memtoreg,branch

    );
    
      always @ (*)
     begin
      case (opcode)
       6'b100011: //lw
        begin
         regwrite = 1;
         regdst = 0;
         aluop = 0;
         memread = 1;
         memwrite = 0;
         memtoreg = 1;
         branch = 0;
        end
       6'b101011: //sw
        begin
         regwrite = 0;
         regdst = 0;
         aluop = 0;
         memread = 0;
         memwrite = 1;
         memtoreg = 0;
         branch = 0;
        end 
       6'b000000: //sub
        begin
         regwrite = 1;
         regdst = 1;
         aluop = 0;
         memread = 0;
         memwrite = 0;
         memtoreg = 0;
         branch = 0;
        end
       6'b001110: //xori
        begin
         regwrite = 1;
         regdst = 0;
         aluop = 1;
         memread = 0;
         memwrite = 0;
         memtoreg = 0;
         branch = 0;
        end 
       6'b000010: //j
        begin
         regwrite = 0;
         regdst = 0;
         aluop = 0;
         memread = 0;
         memwrite = 0;
         memtoreg = 0;
         branch = 1;
        end 
      endcase  
     end
endmodule
