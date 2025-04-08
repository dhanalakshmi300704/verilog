module not_gate_beh (
    input wire a,
    output reg y
);

// Behavioral modeling using always block
always @(*) begin
    if (a == 1'b0)
        y = 1'b1;
    else
        y = 1'b0;
end

endmodule


testbench
`timescale 1ns / 1ps

module tb_not_gate_beh;

    reg a;
    wire y;

    // Instantiate the Device Under Test (DUT)
    not_gate_beh uut (
        .a(a),
        .y(y)
    );

    initial begin
        // Create VCD dump file
        $dumpfile("not_gate_beh.vcd");       // Name of the VCD file
        $dumpvars(0, tb_not_gate_beh);       // Dump all variables in this module

        // Monitor output on console
        $monitor("Time = %0t | a = %b => y = %b", $time, a, y);

        // Apply test inputs
        a = 0; #10;
        a = 1; #10;

        // Finish simulation
        $finish;
    end

endmodule
