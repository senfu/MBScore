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
    wire                        reg_we,reg_re;
    wire [15:0]	                imm;
	wire [25:0]				    jump_addr;
    wire [1:0]                  WB_sel;
    wire [`DATA_WIDTH-1:0]      WB_to_reg,WB_to_mem;
    wire                        jump;

/***********DEBUG***************/
    wire [3:0] state;
/******************************/

    MBScore_ctrl                CTRL(clk,rst,inst,pc_we,IR_we,alu_sel_a,alu_sel_b,alu_op_type,rs_addr,
                                    rd_addr,rt_addr,reg_we,reg_re,imm,jump_addr,WB_sel,state);
    MBScore_alu                 ALU(alu_in_a,alu_in_b,alu_op_type,alu_out);
    MBScore_alu_operator_mux    ALU_MUX(imm,alu_sel_a,alu_sel_b,rs,rt,alu_in_a,alu_in_b);
    MBScore_WB_mux              WB_MUX(WB_sel,alu_out,WB_to_reg,WB_to_mem,jump);

endmodule