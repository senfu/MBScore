`resetall
`include "MBScore_const.v"
module MBScore_pipeline(
    input clk,
    input rst
);

    wire [`DATA_WIDTH-1:0]      inst;
    wire                        pc_we,IR_we;
    wire [`DATA_WIDTH-1:0]      alu_sel_a,alu_sel_b,alu_out;
    wire [`ALU_OP_WIDTH-1:0]    alu_op_type;
    wire [4:0]                  rs_addr,rd_addr,rt_addr;
    wire                        reg_we;
    wire [15:0]	                imm;
	wire [25:0]				    jump_addr;
    wire [1:0]                  WB_sel;
    wire [`DATA_WIDTH-1:0]      WB_to_reg,WB_to_mem;
    wire                        jump;

/***********DEBUG***************/
    wire [3:0] state;
/******************************/
endmodule