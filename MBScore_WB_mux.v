`include "MBScore_const.v"
`define WB_SEL_WIDTH    2
`define WB_SEL_ALUtoReg `WB_SEL_WIDTH'd1
`define WB_SEL_ALUtoMEM `WB_SEL_WIDTH'd2
`define WB_SEL_MEMtoReg `WB_SEL_WIDTH'd3

module MBScore_WB_mux(
    input       [1:0]                 WB_sel,
    input       [`DATA_WIDTH-1:0]     alu_out,
    input       [`DATA_WIDTH-1:0]     mem_data_in,
    output reg  [`DATA_WIDTH-1:0]     WB_to_reg,WB_to_mem,
    output reg                        jump
);

    always @(WB_sel)
    begin
        case(WB_sel)
        `WB_SEL_ALUtoReg: WB_to_reg = alu_out;
        `WB_SEL_ALUtoMEM: WB_to_mem = alu_out;
        `WB_SEL_MEMtoReg: WB_to_reg = mem_data_in;
        `WB_SEL_ALUtoIR : jump      = alu_out[0];
        default:;
        endcase
    end

endmodule