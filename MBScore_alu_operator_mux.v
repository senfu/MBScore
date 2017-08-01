`resetall
`include "MBScore_const.v"

module MBScore_alu_operator_mux(
    input [15:0]                        imm,
    input [`ALU_SEL_WIDTH-1:0]			alu_sel_a,
	input [`ALU_SEL_WIDTH-1:0]			alu_sel_b,
    input [`DATA_WIDTH-1:0]             rs,
    input [`DATA_WIDTH-1:0]             rt,
    output [`DATA_WIDTH-1:0]            alu_in_a,
    output [`DATA_WIDTH-1:0]            alu_in_b
);

    assign alu_in_a = (alu_sel_a == `ALU_SEL_RS)? rs : imm;
    assign alu_in_b = (alu_sel_b == `ALU_SEL_RT)? rt : imm;

endmodule


