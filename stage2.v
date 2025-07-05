module stage2(
    input wire clk2,
    input wire rst,
    input wire [4:0] key_bits,
    input wire [15:0] stg1_out,
    input wire stg1_done,
    output reg done,
    output reg [16:0] stg2_out
);
    always @(posedge clk2 or posedge rst)
    begin
        if(rst)
        begin
            stg2_out <= 17'b0;
            done <= 1'b0;
        end
        else 
        begin
        if(stg1_done)
        begin 
            stg2_out[16:1] <= stg1_out;
            case(key_bits[1:0])
            2'b00: stg2_out[0] <= ~(^stg2_out[16:1]);
            2'b01: stg2_out[0] <= |stg2_out[16:1];
            2'b10: stg2_out[0] <= &stg2_out[16:1];
            2'b11: stg2_out[0] <= |stg2_out[16:1]; 
            endcase
        end
        end
    end
endmodule
