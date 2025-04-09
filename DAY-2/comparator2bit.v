// File: comparator2bit.v
module comparator2bit (
    input  [1:0] A,
    input  [1:0] B,
    output       A_greater,
    output       A_less,
    output       A_equal
);
    assign A_greater = (A > B);
    assign A_less    = (A < B);
    assign A_equal   = (A == B);
endmodule



testbench

// File: tb_comparator2bit.v
`timescale 1ns/1ps

module tb_comparator2bit;
    reg [1:0] A, B;
    wire A_greater, A_less, A_equal;

    // Instantiate the comparator
    comparator2bit uut (
        .A(A),
        .B(B),
        .A_greater(A_greater),
        .A_less(A_less),
        .A_equal(A_equal)
    );

    initial begin
        // VCD dump
        $dumpfile("comparator2bit.vcd");
        $dumpvars(0, tb_comparator2bit);

        // Test all combinations of A and B
        A = 2'b00; B = 2'b00; #10;
        A = 2'b00; B = 2'b01; #10;
        A = 2'b01; B = 2'b00; #10;
        A = 2'b01; B = 2'b01; #10;
        A = 2'b10; B = 2'b01; #10;
        A = 2'b11; B = 2'b10; #10;
        A = 2'b10; B = 2'b11; #10;
        A = 2'b11; B = 2'b11; #10;

        $finish;
    end
endmodule
