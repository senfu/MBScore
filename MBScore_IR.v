`include "MBScore_const.v"
module MBScore_IR(
	input							clk,
	input 							rst,
	input 							IR_we,
	input 							next,
	input							JAL_or_J,
	input							BEQ_or_BNE,
	input							JR,
	input							hlt,
	input		[`DATA_WIDTH-1:0]	next_addr,
	input  		[`DATA_WIDTH-1:0]	inst_in,
	output  	[`DATA_WIDTH-1:0]	inst_out,
	output 		[`DATA_WIDTH-1:0]	pc_out,
);

	reg [`DATA_WIDTH-1:0]			pc,inst;
	assign pc_out = pc;
	assign inst_out = inst;

	always @(posedge clk)
	begin
		if(rst)
			{pc,inst} = {32'b0,32'b0};
		else
		begin
			if(IR_we)
			inst = inst_in;
		end
	end

	always @(posedge next)
	begin
		if(hlt)
		pc = pc;
		else
		if(JAL_or_J)
		pc = {(pc + 4)[31:28],inst[25:0],0,0};
		else
		if(BEQ_or_BNE)
		pc = pc + 4 + $signed(inst[15:0]) << 2;
		else
		if(JR)
		pc = next_addr;
		else
		pc = pc + 4;
	end
	
endmodule
