`resetall
`include "MBScore_const.v"
module MBScore_IR(clk,IR_we,in_data,out_data);
	input 							clk,IR_we;
	input 	  [`DATA_WIDTH-1:0] 	in_data;
	output reg [`DATA_WIDTH-1:0] 	out_data;
	
	always @(negedge clk)
	begin
		if(IR_we)
		out_data = in_data;
	end
	
endmodule
