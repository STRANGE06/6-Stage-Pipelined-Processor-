`timescale 1ns / 1ps
module datamem(
    input [31:0] address,
    input [4:0] exmem_rs,
    input [31:0] writedata,
    input memread,
    input memwrite,
    output reg [31:0] readdata

    );
    
     reg [7:0] dmem [0:100];
     integer k;
     wire [31:0] effective_address;
     
     assign effective_address = address + {{27{0}}, exmem_rs[4:0]};

     
    initial 
     begin
        for (k = 0; k < 101; k = k + 1)
            dmem[k] = k;  
    end
   always @(*) 
     begin
     if (memread) 
      begin
       readdata [31:24] = dmem[effective_address];
        readdata [23:16]= dmem[effective_address + 1];
         readdata [15:8]= dmem[effective_address + 2];
          readdata [7:0]=dmem[effective_address + 3];    
      end 
     else
      begin
       readdata = 32'b0;
      end
    end
    
     always @(*) 
      begin
        if (memwrite) 
         begin
            dmem[effective_address]= writedata[31:24];
            dmem[effective_address + 1] = writedata[23:16];
            dmem[effective_address + 2] = writedata[15:8];
            dmem[effective_address + 3] = writedata[7:0];
         end
      end
endmodule
