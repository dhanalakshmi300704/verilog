module d_latch (
    input D,       // Data input
    input En,      // Enable signal (when high, latch is transparent)
    output Q,
    output Qn      // Complement of Q
);

    reg q;

    assign Q = q;
    assign Qn = ~q;

    always @ (D or En) begin
        if (En)
            q <= D;
    end

endmodule


testbench

`timescale 1ns / 1ps

module tb_d_latch;

    reg D, En;
    wire Q, Qn;

    d_latch uut (
        .D(D),
        .En(En),
        .Q(Q),
        .Qn(Qn)
    );

    initial begin
        // Set up waveform dump
        $dumpfile("d_latch.vcd");
        $dumpvars(0, tb_d_latch);

        // Apply test inputs
        D = 0; En = 0; #10;
        D = 1; En = 0; #10;  // No change, latch is closed
        D = 1; En = 1; #10;  // Latch open, Q should update
        D = 0; En = 1; #10;  // Q should follow D
        D = 1; En = 0; #10;  // Latch closed again
        D = 0; En = 0; #10;

        $finish;
    end

endmodule
