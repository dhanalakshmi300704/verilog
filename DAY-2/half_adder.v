module half_adder (
    input wire a,
    input wire b,
    output wire sum,
    output wire carry
);

// Dataflow modeling using assign
assign sum = a ^ b;
assign carry = a & b;

endmodule


testbench

`timescale 1ns / 1ps

module tb_half_adder;

    reg a;
    reg b;
    wire sum;
    wire carry;

    // Instantiate the DUT
    half_adder uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        // VCD file generation for waveform analysis
        $dumpfile("half_adder.vcd");
        $dumpvars(0, tb_half_adder);

        // Display output
        $monitor("Time = %0t | a = %b, b = %b => sum = %b, carry = %b", 
                  $time, a, b, sum, carry);

        // Apply all input combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule
