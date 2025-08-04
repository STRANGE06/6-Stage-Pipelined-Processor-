`timescale 1ns / 1ps
module forwarding(
    input [4:0] rrex_rs, rrex_rt, memwb_rt,
    input memwb_regwrite,
    output wire fwd_rs, fwd_rt
);

assign fwd_rs = (memwb_regwrite && (memwb_rt == rrex_rs) && (memwb_rt != 5'b0 && rrex_rt != 5'b0)) ? 1'b1 : 1'b0;
assign fwd_rt = (memwb_regwrite && (memwb_rt == rrex_rt) && (memwb_rt != 5'b0 && rrex_rt != 5'b0)) ? 1'b1 : 1'b0;

endmodule
