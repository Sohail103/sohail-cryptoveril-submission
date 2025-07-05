`timescale 1ns/1ps

module cryptoveril_tb;
    reg clk1, clk2, clk3, rst, start, ld;
    reg [15:0] input_data;
    reg [4:0] key_bits;
    wire [15:0] output_data;

    wire [15:0] stg1_out;
    wire [16:0] stg2_out;
    wire [15:0] stg3_out;
    wire stg1_done, stg2_done;

    cryptoveril uut (
        .clk1(clk1),
        .clk2(clk2),
        .clk3(clk3),
        .rst(rst),
        .input_data(input_data),
        .key_bits(key_bits),
        .ld(ld),
        .start(start),
        .output_data(output_data)
    );

    assign stg1_out = uut.stg1_out;
    assign stg2_out = uut.stg2_out;
    assign stg3_out = uut.stg3_out;
    assign stg1_done = uut.stg1_done;
    assign stg2_done = uut.stg2_done;

    // clock generation
    initial begin
        clk1 = 0; clk2 = 0; clk3 = 0;
        forever begin
            #1 clk1 = ~clk1; // clock 1 has fastest frequency
        end
    end
    initial begin
        forever begin
            #3 clk2 = ~clk2;            //clock 2 has frequency of 1/3 of clk1
        end
    end
    initial begin
        forever begin
            #9 clk3 = ~clk3;        // clock 3 has frequency of 1/9 of clk1
        end
    end

    initial begin
        $dumpfile("cryptoveril_tb.vcd");
        $dumpvars(0, cryptoveril_tb);

        rst = 1;
        start = 0;
        ld = 0;
        input_data = 16'b0000000011111111;
        key_bits = 5'b11001;

        #20;
        rst = 0;
        #10;
        ld = 1;    // pulse ld for one cycle
        #10;
        ld = 0;
        start = 1; // keep start high

        #200;

        $finish;
    end

endmodule