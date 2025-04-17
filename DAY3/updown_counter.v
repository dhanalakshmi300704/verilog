module updown_counter #(
    parameter WIDTH = 4
)(
    input wire clk,
    input wire rst,
    input wire updn,                // 1 = count up, 0 = count down
    output reg [WIDTH-1:0] count
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else if (updn)
            count <= count + 1;
        else
            count <= count - 1;
    end

endmodule



testbench

`timescale 1ns / 1ps

module tb_updown_counter;

    reg clk;
    reg rst;
    reg updn;
    wire [3:0] count;

    // Instantiate the counter
    updown_counter #(4) uut (
        .clk(clk),
        .rst(rst),
        .updn(updn),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // Stimulus
    initial begin
        $dumpfile("updown_counter.vcd");
        $dumpvars(0, tb_updown_counter);

        rst = 1;
        updn = 1;     // start with count up
        #10;

        rst = 0;

        // Count up
        #60;

        // Switch to count down
        updn = 0;
        #60;

        // Switch to count up again
        updn = 1;
        #40;

        $finish;
    end

endmodule
