module stage3(
    input wire clk3,
    input wire rst,
    input wire [16:0] stg2_out,
    output wire [15:0] stg3_out
);

always @(*)
begin
    if(rst) stg3_out <= 16'b0;
    else stg3_out <= stg2_out[16:1];
end
endmodule