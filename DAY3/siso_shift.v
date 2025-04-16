module siso_shift #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire rst,
    input wire sin,
    output wire sout
);

    reg [WIDTH-1:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst)
            shift_reg <= 0;
        else
            shift_reg <= {shift_reg[WIDTH-2:0], sin}; // shift left
    end

    assign sout = shift_reg[WIDTH-1]; // MSB as output

endmodule



testbench

`timescale 1ns / 1ps

module tb_siso_shift;

    reg clk;
    reg rst;
    reg sin;
    wire sout;

    // Instantiate the SISO shift register
    siso_shift #(8) uut (
        .clk(clk),
        .rst(rst),
        .sin(sin),
        .sout(sout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // Test sequence
    initial begin
        $dumpfile("siso_shift.vcd");
        $dumpvars(0, tb_siso_shift);

        rst = 1;
        sin = 0;
        #10;

        rst = 0;

        // Shift in 8-bit pattern: 10110011
        sin = 1; #10;
        sin = 0; #10;
        sin = 1; #10;
        sin = 1; #10;
        sin = 0; #10;
        sin = 0; #10;
        sin = 1; #10;
        sin = 1; #10;

        // Stop shifting
        sin = 0;
        #40;

        $finish;
    end

endmodule
