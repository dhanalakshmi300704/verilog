module full_adder (
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

// Dataflow modeling
assign sum  = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule



testbench

`timescale 1ns / 1ps

module tb_full_adder;

    reg a;
    reg b;
    reg cin;
    wire sum;
    wire cout;

    // Instantiate the Device Under Test
    full_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Dump file for GTKWave
        $dumpfile("full_adder.vcd");
        $dumpvars(0, tb_full_adder);

        // Monitor outputs
        $monitor("Time = %0t | a = %b, b = %b, cin = %b => sum = %b, cout = %b", 
                  $time, a, b, cin, sum, cout);

        // Apply all input combinations
        a = 0; b = 0; cin = 0; #10;
        a = 0; b = 0; cin = 1; #10;
        a = 0; b = 1; cin = 0; #10;
        a = 0; b = 1; cin = 1; #10;
        a = 1; b = 0; cin = 0; #10;
        a = 1; b = 0; cin = 1; #10;
        a = 1; b = 1; cin = 0; #10;
        a = 1; b = 1; cin = 1; #10;

        $finish;
    end

endmodule
