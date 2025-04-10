module sr_latch (
    input S,    // Set
    input R,    // Reset
    output Q,
    output Qn   // Q not
);

    reg q;

    assign Q = q;
    assign Qn = ~q;

    always @ (S or R) begin
        if (S && ~R)
            q <= 1;
        else if (~S && R)
            q <= 0;
        else if (S && R)
            q <= 1'bx;  // Invalid condition
    end

endmodule


testbench

`timescale 1ns / 1ps

module tb_sr_latch;

    reg S, R;
    wire Q, Qn;

    sr_latch uut (
        .S(S),
        .R(R),
        .Q(Q),
        .Qn(Qn)
    );

    initial begin
        // Dumpfile setup
        $dumpfile("sr_latch.vcd");
        $dumpvars(0, tb_sr_latch);

        // Test cases
        S = 0; R = 0; #10;
        S = 1; R = 0; #10; // Set
        S = 0; R = 0; #10;
        S = 0; R = 1; #10; // Reset
        S = 0; R = 0; #10;
        S = 1; R = 1; #10; // Invalid
        S = 0; R = 0; #10;

        $finish;
    end

endmodule
