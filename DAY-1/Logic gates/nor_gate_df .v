module nor_gate_df (
    input wire a,
    input wire b,
    output wire y
);

// Dataflow modeling using assign statement
assign y = ~(a | b);

endmodule

testbench

`timescale 1ns / 1ps

module tb_nor_gate_df;

    reg a;
    reg b;
    wire y;

    // Instantiate the DUT (Device Under Test)
    nor_gate_df uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Create VCD file for waveform viewing
        $dumpfile("nor_gate_df.vcd");
        $dumpvars(0, tb_nor_gate_df);

        // Display signal values in console
        $monitor("Time = %0t | a = %b, b = %b => y = %b", $time, a, b, y);

        // Apply test combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule

