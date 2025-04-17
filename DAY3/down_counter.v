module down_counter #(
    parameter WIDTH = 4
)(
    input wire clk,
    input wire rst,
    output reg [WIDTH-1:0] count
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= {WIDTH{1'b1}}; // e.g. 4'b1111 for WIDTH=4
        else
            count <= count - 1;
    end

endmodule


testbench

`timescale 1ns / 1ps

module tb_down_counter;

    reg clk;
    reg rst;
    wire [3:0] count;

    // Instantiate the counter
    down_counter #(4) uut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        $dumpfile("down_counter.vcd");
        $dumpvars(0, tb_down_counter);

        rst = 1;         // Apply reset
        #12;

        rst = 0;         // Start counting down
        #100;

        rst = 1;         // Reset again
        #10;

        rst = 0;         // Resume counting
        #40;

        $finish;
    end

endmodule
