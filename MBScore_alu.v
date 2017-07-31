`include "MBScore_const.v"
module MBScore_alu(
    input                            alu_start,
    input      [`DATA_WIDTH-1:0]     alu_in_a,
    input      [`DATA_WIDTH-1:0]     alu_in_b,
    input      [`ALU_OP_WIDTH-1:0]   alu_op_type,
    output reg [`DATA_WIDTH-1:0]     alu_out,
);

always @(alu_op_type)
begin
    case(alu_op_type)
    `ALU_OP_ADD:    alu_out = $signed(alu_in_a) + $signed(alu_in_b);
    `ALU_OP_ADDU:   alu_out = $unsigned(alu_in_a) + $unsigned(alu_in_b);
    `ALU_OP_SUB:    alu_out = $signed(alu_in_a) + $signed(alu_in_b);
    `ALU_OP_SUBU:   alu_out = $unsigned(alu_in_a) + $unsigned(alu_in_b);
    `ALU_OP_AND:    alu_out = alu_in_a & alu_in_b;
    `ALU_OP_OR:     alu_out = alu_in_a | alu_in_b;
    `ALU_OP_XOR:    alu_out = alu_in_a ^ alu_in_b;
    `ALU_OP_NOR:    alu_out = ~(alu_in_a | alu_in_b);
    `ALU_OP_SLL:    alu_out = alu_in_a << alu_in_b;
    `ALU_OP_SRL:    alu_out = alu_in_a >> alu_in_b;
    `ALU_OP_SRA:    alu_out = alu_in_a >>> alu_in_b;
    `ALU_OP_EQ:     alu_out = (alu_in_a == alu_in_b) ? 32'd1 : 32'd0;
    `ALU_OP_NE:     alu_out = (alu_in_a != alu_in_b) ? 32'd1 : 32'd0;
    `ALU_OP_LT:     alu_out = ( $signed(alu_in_a) < $signed(alu_in_b) ) ? 32'd1 : 32'd0; 
    `ALU_OP_LTU:    alu_out = ( $unsigned(alu_in_a) < $unsigned(alu_in_b) ) ? 32'd1 : 32'd0; 
end


endmodule