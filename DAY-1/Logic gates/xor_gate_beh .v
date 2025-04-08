module xor_gate_beh (
    input wire a,
    input wire b,
    output reg y
);

// Behavioral modeling using always block
always @(*) begin
    if ((a == 1'b0 && b == 1'b1) || (a == 1'b1 && b == 1'b0))
        y = 1'b1;
    else
        y = 1'b0;
end

endmodule



testbench

`timescale 1ns / 1ps

module tb_xor_gate_beh;

    reg a;
    reg b;
    wire y;

    // Instantiate the DUT (Device Under Test)
    xor_gate_beh uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Generate VCD dump file
        $dumpfile("xor_gate_beh.vcd");
        $dumpvars(0, tb_xor_gate_beh);

        // Monitor signal values in the console
        $monitor("Time = %0t | a = %b, b = %b => y = %b", $time, a, b, y);

        // Apply all possible inputs
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule
