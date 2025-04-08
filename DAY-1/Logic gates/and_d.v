//Design code
module and_gate (
    input wire a,
    input wire b,
    output wire y
);

assign y = a & b;

endmodule

//Testbench
module tb_and_gate;

    // Testbench signals
    reg a;
    reg b;
    wire y;

    // Instantiate the AND gate
    and_gate uut (
        .a(a),
        .b(b),
        .y(y)
    );
    initial begin
      $dumpfile("and_gate.vcd");
      $dumpvars(1,tb_and_gate);
    end

    initial begin
        // Monitor the signals
        $monitor("Time = %0t | a = %b, b = %b => y = %b", $time, a, b, y);

        // Test cases
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule
