`include "MBScore_const.v"
module MBScore_alu(
    input                            rst,
    input      [`DATA_WIDTH-1:0]     alu_in_a,
    input      [`DATA_WIDTH-1:0]     alu_in_b,
    input      [`ALU_OP_WIDTH-1:0]   alu_op_type,
    output reg [`DATA_WIDTH-1:0]     alu_out,
    output reg                       cf
);

    always @(alu_op_type or rst)
    begin
        if(rst)
        {cf,alu_out} = {1'b0,32'b0};
        else
        case(alu_op_type)
        `ALU_OP_ADD:    {cf,alu_out} = {1'b0 + alu_in_a} + {1'b0 + alu_in_b};
        `ALU_OP_ADDU:   {cf,alu_out} = {1'b0,alu_in_a + alu_in_b};
        `ALU_OP_SUB:    {cf,alu_out} = {1'b0 + alu_in_a} - {1'b0 + alu_in_b};
        `ALU_OP_SUBU:   {cf,alu_out} = {1'b0,alu_in_a - alu_in_b};
        `ALU_OP_AND:    alu_out = alu_in_a & alu_in_b;
        `ALU_OP_OR:     alu_out = alu_in_a | alu_in_b;
        `ALU_OP_XOR:    alu_out = alu_in_a ^ alu_in_b;
        `ALU_OP_NOR:    alu_out = ~(alu_in_a | alu_in_b);
        `ALU_OP_SLL:    alu_out = alu_in_a << alu_in_b;
        `ALU_OP_SRL:    alu_out = alu_in_a >> alu_in_b;
        `ALU_OP_SRA:    alu_out = $signed(alu_in_a) >>> alu_in_b;
        `ALU_OP_EQ:     alu_out = (alu_in_a == alu_in_b) ? 32'd1 : 32'd0;
        `ALU_OP_NE:     alu_out = (alu_in_a != alu_in_b) ? 32'd1 : 32'd0;
        `ALU_OP_LT:     alu_out = ( $signed(alu_in_a) < $signed(alu_in_b) ) ? 32'd1 : 32'd0; 
        `ALU_OP_LTU:    alu_out = ( $unsigned(alu_in_a) < $unsigned(alu_in_b) ) ? 32'd1 : 32'd0; 
        default:        {cf,alu_out} = {cf,alu_out};
        endcase

    end


endmodule