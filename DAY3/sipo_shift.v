module sipo_shift #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire rst,
    input wire sin,
    output reg [WIDTH-1:0] pout
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            pout <= 0;
        else
            pout <= {pout[WIDTH-2:0], sin}; // shift left, MSB last
    end

endmodule



testbench

`timescale 1ns / 1ps

module tb_sipo_shift;

    reg clk;
    reg rst;
    reg sin;
    wire [7:0] pout;

    // Instantiate the SIPO shift register
    sipo_shift #(8) uut (
        .clk(clk),
        .rst(rst),
        .sin(sin),
        .pout(pout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // Test pattern
    reg [7:0] test_data = 8'b10110011;
    integer i;

    initial begin
        $dumpfile("sipo_shift.vcd");
        $dumpvars(0, tb_sipo_shift);

        rst = 1;
        sin = 0;
        #12;

        rst = 0;

        // Shift in test_data serially, LSB first
        for (i = 0; i < 8; i = i + 1) begin
            sin = test_data[i];
            #10;
        end

        // Hold for a few cycles
        sin = 0;
        #30;

        $finish;
    end

endmodule
