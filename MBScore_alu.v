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
        `ALU_OP_AND:    {cf,alu_out} = {1'b0,alu_in_a & alu_in_b};
        `ALU_OP_OR:     {cf,alu_out} = {1'b0,alu_in_a | alu_in_b};
        `ALU_OP_XOR:    {cf,alu_out} = {1'b0,alu_in_a ^ alu_in_b};
        `ALU_OP_NOR:    {cf,alu_out} = {1'b0,~(alu_in_a | alu_in_b)};
        `ALU_OP_SLL:    {cf,alu_out} = {1'b0,alu_in_a << alu_in_b};
        `ALU_OP_SRL:    {cf,alu_out} = {1'b0,alu_in_a >> alu_in_b};
        `ALU_OP_SRA:    {cf,alu_out} = {1'b0,$signed(alu_in_a) >>> alu_in_b};
        `ALU_OP_EQ:     {cf,alu_out} = {1'b0,(alu_in_a == alu_in_b) ? 32'd1 : 32'd0};
        `ALU_OP_NE:     {cf,alu_out} = {1'b0,(alu_in_a != alu_in_b) ? 32'd1 : 32'd0};
        `ALU_OP_LT:     {cf,alu_out} = {1'b0,( $signed(alu_in_a) < $signed(alu_in_b) ) ? 32'd1 : 32'd0}; 
        `ALU_OP_LTU:    {cf,alu_out} = {1'b0,( $unsigned(alu_in_a) < $unsigned(alu_in_b) ) ? 32'd1 : 32'd0}; 
        default:        {cf,alu_out} = {1'b0,32'b0};
        endcase

    end


endmodule 