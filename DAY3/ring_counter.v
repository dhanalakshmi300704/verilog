module ring_counter #(
    parameter WIDTH = 4
)(
    input wire clk,
    input wire rst,
    output reg [WIDTH-1:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1;  // Set initial state: 0001
        else
            q <= {q[WIDTH-2:0], q[WIDTH-1]}; // Rotate left
    end

endmodule


testbench

`timescale 1ns / 1ps

module tb_ring_counter;

    reg clk;
    reg rst;
    wire [3:0] q;

    // Instantiate ring counter
    ring_counter #(4) uut (
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    // Generate clock: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("ring_counter.vcd");
        $dumpvars(0, tb_ring_counter);

        rst = 1;    // Assert reset
        #10;

        rst = 0;    // Deassert reset
        #100;

        rst = 1;    // Apply reset again
        #10;

        rst = 0;    // Run again
        #50;

        $finish;
    end

endmodule
