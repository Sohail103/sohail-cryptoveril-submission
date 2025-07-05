module stage1(
    input wire clk1,
    input wire [4:0] key_bits,
    input wire [15:0] input_data,
    input wire ld,
    output wire done,
    output wire [15:0] stg1_out
);
    reg [15:0] shift_reg;
    