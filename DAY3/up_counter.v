module up_counter #(
    parameter WIDTH = 4
)(
    input wire clk,
    input wire rst,
    output reg [WIDTH-1:0] count
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else
            count <= count + 1;
    end

endmodule


testbench

`timescale 1ns / 1ps

module tb_up_counter;

    reg clk;
    reg rst;
    wire [3:0] count;

    // Instantiate the counter
    up_counter #(4) uut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Clock generation: 10ns clock period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        $dumpfile("up_counter.vcd");
        $dumpvars(0, tb_up_counter);

        rst = 1;         // Apply reset
        #12;

        rst = 0;         // Release reset
        #100;            // Let the counter run

        rst = 1;         // Reset again
        #10;
        rst = 0;

        #50;

        $finish;
    end

endmodule
