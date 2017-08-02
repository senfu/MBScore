`include "MBScore_const.v"
module MBScore_rf(
    input                           rst,
    input [`REG_ADDR_WIDTH-1:0]     rs_addr,
    input [`REG_ADDR_WIDTH-1:0]     rd_addr,
    input [`REG_ADDR_WIDTH-1:0]     rt_addr,
    input                           reg_we,
    input                           spr_sel,
    input                           spr_re,
    input                           spr_we,
    input  [`DATA_WIDTH-1:0]        data_in,
    output [`DATA_WIDTH-1:0]        rs_out,
    output [`DATA_WIDTH-1:0]        rt_out,               
);

    reg [31:0] gr  [0:31];
    reg [31:0] spr [0:31];
    assign rs_out = (spr_sel == 1'b1)? spr[rs_addr] : gr[rs_addr];
    assign rt_out = gr[rt_addr];

    always @(posedge rst)
    begin
        gr[0] = 32'b0;  
    end

    always @(posedge reg_we)
    begin
        if(rd_addr != 0)
        gr[rd_addr] = data_in;  
    end