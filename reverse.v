module reverse(
    input  wire [15:0] stg3_out,
    input  wire [4:0]  key_bits,
    output wire [15:0] result
);

    wire [15:0] subtracted;
    wire [2:0]  shift_amt;

    assign subtracted = stg3_out - 16'd3;
    assign shift_amt  = key_bits[4:2];
    assign result     = subtracted >> shift_amt;

endmodule