module cryptoveril (
    input wire clk1,     // Stage 1 clock
    input wire clk2,     // Stage 2 clock
    input wire clk3,     // Stage 3 clock
    input wire rst,      // Global reset
    input wire [15:0] input_data, // Input data
    input wire [4:0] key_bits,    // 6-bit key
    output wire [15:0] output_data // Final result
);
    wire ld, start;
    wire [15:0] stg1_out;
    wire [16:0] stg2_out;
    wire stg1_done, stg2_done;

    stage1 stg1(
    clk1,
    rst,
    key_bits,
    input_data,
    ld,
    start,
    stg1_done,
    stg1_out);

    stage2 stg2(
    clk2,
    rst,
    key_bits,
    stg1_out,
    stg1_done,
    stg2_done,
    stg2_out);

    stage3 stg3(
        clk3,
        rst,
        stg2_out,
        stg3_out
    );



endmodule