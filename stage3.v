module stage3(
    input wire clk3,
    input wire rst,                     // module to remove last bit
    input wire [16:0] stg2_out,
    output wire [15:0] stg3_out
);
    assign stg3_out = stg2_out[16:1];
endmodule