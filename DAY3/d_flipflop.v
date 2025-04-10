module d_flipflop (
    input wire d,
    input wire clk,
    output reg q,
    output wire q_bar
);

assign q_bar = ~q;

always @(posedge clk) begin
    q <= d;
end

endmodule



testbench

`timescale 1ns / 1ps

module tb_d_flipflop;

reg d, clk;
wire q, q_bar;

// Instantiate D flip-flop
d_flipflop uut (
    .d(d),
    .clk(clk),
    .q(q),
    .q_bar(q_bar)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Clock period = 10ns
end

// Test sequence
initial begin
    $dumpfile("d_flipflop.vcd");
    $dumpvars(0, tb_d_flipflop);

    d = 0; #10;
    d = 1; #10;
    d = 0; #10;
    d = 1; #10;
    d = 1; #10;
    d = 0; #10;

    $finish;
end

endmodule
