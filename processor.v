`timescale 1ns / 1ps
module processor(
    input clk,
    input reset);
    
    wire stall;
    stalling stal (.ifid_code(ifid_code),.code(code),.stall(stall));
    
    wire jump;
    jump j (.opcode(code[31:26]),.j(jump));
    
    wire [31:0] code;
    wire [31:0] pc_out;
    Instruction_Fetch Fetch (.clk(clk),.reset(reset),.jump(jump),.stall(stall),.PC_in(extended26),.Instruction_Code(code),.PC_new(pc_out));
    
    wire [31:0] ifid_code;
    wire [31:0] ifid_pc;
    ifid ifid (.clk(clk),.reset(reset),.code (code),.pc(pc_out),.ifid_code(ifid_code),.ifid_pc(ifid_pc));
    
     wire [4:0] rs,rt,rd;
     wire [15:0] offset;
     wire [5:0] opcode,func;
     wire [25:0] address;
     decode decode (.ifid_code(ifid_code),.rs(rs),.rt(rt),.rd(rd),.opcode(opcode),.offset(offset),.address(address),.func(func));
     
     wire [31:0] extended26;
     signextend26 extend26 (.address(code[25:0]),.pc(pc_out),.extended26(extended26));
     
     wire regwrite,regdst,aluop,memread,memwrite,memtoreg,branch;
     control control (.opcode(opcode),.regwrite(regwrite),.regdst(regdst),.aluop(aluop),.memread(memread),.memwrite(memwrite),.memtoreg(memtoreg),.branch(branch));
     
     wire [4:0] idrr_rs, idrr_rt, idrr_rd;
     wire [5:0] idrr_opcode,idrr_func;
     wire [15:0] idrr_offset;
     wire [25:0] idrr_address;
     wire [31:0] idrr_pc;
     wire idrr_regwrite,idrr_regdst,idrr_aluop,idrr_memread,idrr_memwrite,idrr_memtoreg,idrr_branch;
     idrr idrr (.clk(clk),.reset(reset),.rs(rs),.rt(rt),.rd(rd),.offset(offset),.opcode(opcode),.func(func),.address(address),.idrr_rs(idrr_rs),.idrr_rt(idrr_rt),.idrr_rd(idrr_rd),.idrr_offset(idrr_offset),.idrr_opcode(idrr_opcode),.idrr_func(idrr_func),.idrr_address(idrr_address),.ifid_pc(ifid_pc),.idrr_pc(idrr_pc),.regwrite(regwrite),.idrr_regwrite(idrr_regwrite)
     ,.regdst(regdst),.idrr_regdst(idrr_regdst),.aluop(aluop),.memread(memread),.memwrite(memwrite),.memtoreg(memtoreg),.branch(branch),.idrr_aluop(idrr_aluop),.idrr_memread(idrr_memread),.idrr_memwrite(idrr_memwrite),.idrr_memtoreg(idrr_memtoreg),.idrr_branch(idrr_branch));
     
     wire [4:0] out;
     mux m1 (.in0(memwb_rt),.in1(memwb_rd),.regdst(memwb_regdst),.out(out));
     
     wire [31:0] data1,data2;
     regfile regf (.readreg1(idrr_rs),.readreg2(idrr_rt),.writereg(out),.writedata(writedata),.data1(data1),.data2(data2),.regwrite(memwb_regwrite),.clk(clk));
     
     wire [31:0] extended16;
     signextend16 extend16 (.offset(idrr_offset),.extended16(extended16));
     
     wire  rrex_regwrite,rrex_regdst,rrex_aluop,rrex_memread,rrex_memwrite,rrex_memtoreg,rrex_branch;
     wire [31:0] rrex_pc,rrex_data1,rrex_data2,rrex_extended16;
     wire [4:0] rrex_rs,rrex_rt,rrex_rd;
     wire [25:0] rrex_address;
     rrex rrex (.clk(clk),.reset(reset),.idrr_rt(idrr_rt),.idrr_rs(idrr_rs),.idrr_rd(idrr_rd),.idrr_opcode(idrr_opcode),.idrr_regwrite(idrr_regwrite),.idrr_regdst(idrr_regdst),.idrr_aluop(idrr_aluop),.idrr_memread(idrr_memread),.idrr_memwrite(idrr_memwrite),.idrr_memtoreg(idrr_memtoreg),.idrr_branch(idrr_branch),.idrr_pc(idrr_pc),.data1(data1),.data2(data2),.extended16(extended16),.idrr_address(idrr_address)
     ,.rrex_regwrite(rrex_regwrite),.rrex_regdst(rrex_regdst),.rrex_aluop(rrex_aluop),.rrex_memread(rrex_memread),.rrex_memwrite(rrex_memwrite),.rrex_memtoreg(rrex_memtoreg),.rrex_branch(rrex_branch),.rrex_pc(rrex_pc),.rrex_data1(rrex_data1),.rrex_data2(rrex_data2),.rrex_extended16(rrex_extended16),.rrex_rt(rrex_rt),.rrex_rs(rrex_rs),.rrex_rd(rrex_rd),.rrex_address(rrex_address));
     
     wire [31:0] re_d1,re_d2;
     mux2 m2 (.in0(rrex_data1),.in1(memwb_readdata),.ctrl(fwd_rs),.out(re_d1));
     
     mux1 m3 (.extended16(rrex_extended16),.data2(rrex_data2),.out(re_d2),.op(rrex_aluop));
     
     wire [31:0] result;
     execute exe (.data1(re_d1),.data2(re_d2),.aluop(rrex_aluop),.result(result));
     
     
    
     wire [31:0] exmem_extended26,exmem_result,exmem_extended16,exmem_data2,exmem_data1;
     wire exmem_branch,exmem_memread,exmem_memtoreg,exmem_memwrite,exmem_regwrite;
     wire [4:0] exmem_rs,exmem_rd,exmem_rt;
     exmem exmem (.clk(clk),.reset(reset),.rrex_extended16(rrex_extended16),.extended26(extended26),.result(result),.rrex_data2(rrex_data2),.rrex_data1(rrex_data1),.rrex_branch(rrex_branch),.rrex_memread(rrex_memread),.rrex_memtoreg(rrex_memtoreg),.rrex_memwrite(rrex_memwrite),.rrex_regdst(rrex_regdst),.rrex_regwrite(rrex_regwrite),.rrex_rd(rrex_rd),.rrex_rt(rrex_rt),.rrex_rs(rrex_rs)
     ,.exmem_extended26(exmem_extended26),.exmem_result(exmem_result),.exmem_extended16(exmem_extended16),.exmem_data2(exmem_data2),.exmem_data1(exmem_data1),.exmem_branch(exmem_branch),.exmem_memread(exmem_memread),.exmem_memtoreg(exmem_memtoreg),.exmem_memwrite(exmem_memwrite),.exmem_regdst(exmem_regdst),.exmem_regwrite(exmem_regwrite),.exmem_rd(exmem_rd),.exmem_rt(exmem_rt),.exmem_rs(exmem_rs));
     
     wire [31:0] readdata;
     datamem dmem (.address(exmem_extended16),.exmem_rs(exmem_rs),.writedata(exmem_data2),.memread(exmem_memread),.memwrite(exmem_memwrite),.readdata(readdata)); 
     
     wire [31:0] memwb_extended26,memwb_result,memwb_readdata;
     wire memwb_branch,memwb_memtoreg,memwb_regdst,memwb_regwrite;
     wire [4:0] memwb_rd,memwb_rt;
     memwb memwb (.clk(clk),.reset(reset),.exmem_extended26(exmem_extended26),.exmem_result(exmem_result),.readdata(readdata),.exmem_branch(exmem_branch),.exmem_memtoreg(exmem_memtoreg),.exmem_regdst(exmem_regdst),.exmem_regwrite(exmem_regwrite),.exmem_rd(exmem_rd),.exmem_rt(exmem_rt)
     ,.memwb_extended26(memwb_extended26),.memwb_result(memwb_result),.memwb_readdata(memwb_readdata),.memwb_branch(memwb_branch),.memwb_memtoreg(memwb_memtoreg),.memwb_regdst(memwb_regdst),.memwb_regwrite(memwb_regwrite),.memwb_rd(memwb_rd),.memwb_rt(memwb_rt));
     
     wire [31:0] writedata;
     writeback wb (.readdata(memwb_readdata),.result(memwb_result),.memtoreg(memwb_memtoreg),.writedata(writedata));
     
     wire fwd_rs, fwd_rt;
     forwarding forward (.rrex_rs(rrex_rs),.rrex_rt(rrex_rt),.memwb_rt(memwb_rt),.memwb_regwrite(exmem_regwrite),.fwd_rs(fwd_rs),.fwd_rt(fwd_rt));
     
     
endmodule
