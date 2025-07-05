`timescale 1ns/1ps

module cryptoveril_tb;
    reg clk1, clk2, clk3, rst, start;
    reg [15:0] input_data;
    reg [4:0] key_bits;
    wire [15:0] output_data;

    // Internal signals to observe stage outputs
    wire [15:0] stg1_out;
    wire [16:0] stg2_out;
    wire [15:0] stg3_out;
    wire stg1_done, stg2_done;

    // Instantiate DUT
    cryptoveril uut (
        .clk1(clk1),
        .clk2(clk2),
        .clk3(clk3),
        .rst(rst),
        .input_data(input_data),
        .key_bits(key_bits),
        .output_data(output_data),
        .start(start)
    );

    // Probes for internal signals
    assign stg1_out = uut.stg1_out;
    assign stg2_out = uut.stg2_out;
    assign stg3_out = uut.stg3_out;
    assign stg1_done = uut.stg1_done;
    assign stg2_done = uut.stg2_done;

    // Clock generation
    initial begin
        clk1 = 0; clk2 = 0; clk3 = 0;
        forever begin
            #1 clk1 = ~clk1;
        end
    end
    initial begin
        forever begin
            #3 clk2 = ~clk2;
        end
    end
    initial begin
        forever begin
            #9 clk3 = ~clk3;
        end
    end

    // Stimulus
    initial begin
        $dumpfile("cryptoveril_tb.vcd");
        $dumpvars(0, cryptoveril_tb);

        rst = 1;
        start = 0;
        input_data = 16'b0000000000000001;
        key_bits = 5'b00110; // shift by 1, key_bits[1:0]=10

        #20;
        rst = 0;
        #10;
        start = 1;
        #10;
        start = 0;

        // Wait for all stages to finish
        #200;

        $finish;
    end

endmodule