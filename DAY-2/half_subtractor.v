module half_subtractor (
    input wire a,
    input wire b,
    output wire diff,
    output wire borrow
);

// Dataflow modeling
assign diff = a ^ b;         // Difference output
assign borrow = ~a & b;      // Borrow output

endmodule


testbench

`timescale 1ns / 1ps

module tb_half_subtractor;

    reg a;
    reg b;
    wire diff;
    wire borrow;

    // Instantiate the DUT
    half_subtractor uut (
        .a(a),
        .b(b),
        .diff(diff),
        .borrow(borrow)
    );

    initial begin
        // Create dump file for GTKWave
        $dumpfile("half_subtractor.vcd");
        $dumpvars(0, tb_half_subtractor);

        // Display signal values
        $monitor("Time = %0t | a = %b, b = %b => diff = %b, borrow = %b", 
                 $time, a, b, diff, borrow);

        // Test all input combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule


