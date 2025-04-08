module nand_gate_df (
    input wire a,
    input wire b,
    output wire y
);

// Dataflow modeling using assign statement
assign y = ~(a & b);

endmodule


testbench

`timescale 1ns / 1ps

module tb_nand_gate_df;

    reg a;
    reg b;
    wire y;

    // Instantiate the DUT (Device Under Test)
    nand_gate_df uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Generate dump file for waveform analysis
        $dumpfile("nand_gate_df.vcd");
        $dumpvars(0, tb_nand_gate_df);

        // Display signal activity
        $monitor("Time = %0t | a = %b, b = %b => y = %b", $time, a, b, y);

        // Apply all input combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule
