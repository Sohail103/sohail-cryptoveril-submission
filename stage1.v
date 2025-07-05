module stage1(
    input wire clk1,
    input wire rst,
    input wire [4:0] key_bits,
    input wire [15:0] input_data,
    input wire ld,
    input wire start,
    output reg done,
    output reg [15:0] stg1_out
);
    reg [15:0] shift_reg;

    always @(posedge clk1 or posedge rst) 
    begin
        if (rst) 
        begin
            shift_reg <= 16'b0;
            done <= 1'b0;
        end 
        else 
        begin
            if (ld) 
            begin
                shift_reg <= input_data;
                done <= 1'b0;
            end 
            else if (start) 
            begin
                stg1_out <= (shift_reg << key_bits[4:2]) + 16'd3;
                done <= 1'b1;
            end 
            else 
            begin
                done <= 1'b0;
            end
        end
    end
endmodule