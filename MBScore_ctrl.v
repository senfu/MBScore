`include "MBScore_const.v"
module MBScore_ctrl(
	input 									clk,
	input 									rst,
	input [`DATA_WIDTH-1:0] 				inst,
	output reg								pc_we,
	output reg								IR_we,
	output reg [`ALU_SEL_WIDTH-1:0]			alu_sel_a,
	output reg [`ALU_SEL_WIDTH-1:0]			alu_sel_b,
	output reg 								alu_sel_shamt,
	output reg [`ALU_OP_WIDTH-1:0]			alu_op_type,
	output [3:0]							state
);
	reg [3:0] curState,nextState;
	
/************Debug*****************/
	assign state = curState;
/**********************************/
	
	
	always @(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			curState <= `IDLE;
		end
		else
			curState <= nextState;
		
	end
	
	always @(curState or inst)
	begin
		if(rst)
		begin
			nextState <= `IF;
		end
		else
		begin
			case(curState)
				`IDLE:			nextState = `IF;
				`IF: 			nextState = `ID;
				`ID:
				begin
					if( (inst[31:26] == `OPCODE_CALC && inst[5:0] == `FUNCT_JR) ||
						  inst[31:26] == `OPCODE_J ||
						  inst[31:26] == `OPCODE_JAL ||
						  inst[31:26] == `OPCODE_HLT)
								nextState = `IF;
						else
								nextState = `EXE;
					
				end
				`EXE:
				begin
					if(inst[31:26] == `OPCODE_BEQ || inst[31:26] == `OPCODE_BNE)
								nextState = `IF;
						else
								nextState = `WB;
				end
				`WB: 			nextState = `IF;
			default: 			nextState = `IF;
			endcase
		end
	end
	
	always @(curState)
	begin
		inst_re = 1'b0;
		pc_we = 1'b0;
		IR_we = 1'b0;
		alu_sel_a = 2'd0;
		alu_sel_b = 2'd0;
		alu_op_type = 4'd0;
		alu_start = 1'b0;
		if(!rst)
		begin
			case(curState)
				`IF:
				begin
					inst_re 	= 1'b1;
					pc_we 		= 1'b1;
					IR_we		= 1'b1;
				end
				`ID: 	
				begin
					if(inst[31:26] == `OPCODE_CALC)
						begin
							case(inst[5:0])
								`FUNCT_ADD,`FUNCT_ADDU,`FUNCT_SUB,`FUNCT_SUBU,`FUNCT_AND,
								`FUNCT_OR,`FUNCT_XOR,`FUNCT_NOR,`FUNCT_SLT,`FUNCT_SLTU,
								`FUNCT_SLLV,`FUNCT_SRLV,`FUNCT_SRAV:
									begin
										alu_sel_a = `ALU_SEL_RS;
										alu_sel_b = `ALU_SEL_RT;
									end
							
								`FUNCT_SLL,`FUNCT_SRL,`FUNCT_SRA:
									begin
										alu_sel_a = `ALU_SEL_IMM;
										alu_sel_b = `ALU_SEL_RT;
									end
								default: ;
							endcase
							
							case(inst[5:0])
								`FUNCT_ADD				:	alu_op_type = `ALU_OP_ADD;
								`FUNCT_ADDU				:	alu_op_type = `ALU_OP_ADDU;
								`FUNCT_SUB				:	alu_op_type = `ALU_OP_SUB;
								`FUNCT_SUBU				:	alu_op_type = `ALU_OP_SUBU;
								`FUNCT_AND				: 	alu_op_type = `ALU_OP_AND;
								`FUNCT_OR				:	alu_op_type = `ALU_OP_OR;
								`FUNCT_XOR				:  	alu_op_type = `ALU_OP_XOR;
								`FUNCT_NOR				:  	alu_op_type = `ALU_OP_NOR;
								`FUNCT_SLT				:  	alu_op_type = `ALU_OP_LT;
								`FUNCT_SLTU				:	alu_op_type = `ALU_OP_LTU;
								`FUNCT_SLLV,`FUNCT_SLL	:	alu_op_type = `ALU_OP_SLL;
								`FUNCT_SRLV,`FUNCT_SRL	:	alu_op_type = `ALU_OP_SRL;
								`FUNCT_SRAV,`FUNCT_SRA  :	alu_op_type = `ALU_OP_SRA;
								default:	;
							endcase
						end
					else
					if(inst[31:26] == `OPCODE_ADDI || inst[31:26] == `OPCODE_ADDIU ||
					   inst[31:26] == `OPCODE_ANDI || inst[31:26] == `OPCODE_ORI   ||
					   inst[31:26] == `OPCODE_XORI)
						begin
							alu_sel_a = `ALU_SEL_RS;
							alu_sel_b = `ALU_SEL_IMM;
							case(inst[31:26])
								`OPCODE_ADDI 	: alu_op_type = `ALU_OP_ADD;
								`OPCODE_ADDIU	: alu_op_type = `ALU_OP_ADD;
								`OPCODE_ANDI	: alu_op_type = `ALU_OP_AND;
								`OPCODE_ORI		: alu_op_type = `ALU_OP_OR;
								`OPCODE_XORI	: alu_op_type = `ALU_OP_XOR;
							default:;
							endcase
						end
					else
					if(inst[31:26] == `OPCODE_BEQ)
						begin
							alu_sel_a 	= `ALU_SEL_RS;
							alu_sel_b 	= `ALU_SEL_RT;
							alu_op_type = `ALU_OP_EQ;
						end
					else
					if(inst[31:26] == `OPCODE_BNE)
						begin
							alu_sel_a 	= `ALU_SEL_RS;
							alu_sel_b 	= `ALU_SEL_RT;
							alu_op_type = `ALU_OP_NE;
						end
					else
					if(inst[31:26] == `OPCODE_SLTI)
						begin
							alu_sel_a 	= `ALU_SEL_RS;
							alu_sel_b 	= `ALU_SEL_IMM;
							alu_op_type = `ALU_OP_LT; 
						end
					else
					if(inst[31:26] == `OPCODE_SLTIU)
						begin
					  		alu_sel_a 	= `ALU_SEL_RS;
							alu_sel_b 	= `ALU_SEL_IMM;
							alu_op_type = `ALU_OP_LTU; 
						end
					else
						begin
						  
						end
				end
				`EXE: alu_start = 1'b1;
				`MEM: ;
				`WB:;
			default:;
			endcase
		end
	end


endmodule

