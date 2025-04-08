module not_gate_df (
    input wire a,
    output wire y
);

// Dataflow modeling using assign statement
assign y = ~a;

endmodule


testbench

`timescale 1ns / 1ps

module tb_not_gate_df;

    reg a;
    wire y;

    // Instantiate the DUT
    not_gate_df uut (
        .a(a),
        .y(y)
    );

    initial begin
        // Dumpfile for waveform viewer
        $dumpfile("not_gate_df.vcd");
        $dumpvars(0, tb_not_gate_df);

        $monitor("Time = %0t | a = %b => y = %b", $time, a, y);

        // Apply test vectors
        a = 0; #10;
        a = 1; #10;

        $finish;
    end

endmodule
