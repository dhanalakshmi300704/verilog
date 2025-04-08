module xnor_gate_beh (
    input wire a,
    input wire b,
    output reg y
);

// Behavioral modeling using always block
always @(*) begin
    if (a == b)
        y = 1'b1;
    else
        y = 1'b0;
end

endmodule


testbench

`timescale 1ns / 1ps

module tb_xnor_gate_beh;

    reg a;
    reg b;
    wire y;

    // Instantiate the DUT (Device Under Test)
    xnor_gate_beh uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Generate VCD file for GTKWave
        $dumpfile("xnor_gate_beh.vcd");
        $dumpvars(0, tb_xnor_gate_beh);

        // Display signal values
        $monitor("Time = %0t | a = %b, b = %b => y = %b", $time, a, b, y);

        // Test all input combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule
