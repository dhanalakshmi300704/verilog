module and_gate_beh (
    input wire a,
    input wire b,
    output reg y
);

always @(*) begin
    if (a == 1'b1 && b == 1'b1)
        y = 1'b1;
    else
        y = 1'b0;
end

endmodule


testbench

`timescale 1ns / 1ps

module tb_and_gate_beh;

    reg a;
    reg b;
    wire y;

    // Instantiate the DUT (Device Under Test)
    and_gate_beh uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Generate dump file for waveform viewing
        $dumpfile("and_gate_beh.vcd");  // Dump file name
        $dumpvars(0, tb_and_gate_beh);  // Dump all variables in this module

        $monitor("Time = %0t | a = %b, b = %b => y = %b", $time, a, b, y);

        // Test all input combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule
