module t_flipflop (
    input wire t,
    input wire clk,
    output reg q,
    output wire q_bar
);

assign q_bar = ~q;

always @(posedge clk) begin
    if (t)
        q <= ~q;  // Toggle
    else
        q <= q;   // Hold
end

endmodule


testbench

`timescale 1ns / 1ps

module tb_t_flipflop;

reg t, clk;
wire q, q_bar;

// Instantiate the T flip-flop
t_flipflop uut (
    .t(t),
    .clk(clk),
    .q(q),
    .q_bar(q_bar)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Clock period = 10ns
end

// Stimulus
initial begin
    $dumpfile("t_flipflop.vcd");
    $dumpvars(0, tb_t_flipflop);

    // Apply test inputs
    t = 0; #10;
    t = 1; #10;
    t = 1; #10;
    t = 0; #10;
    t = 1; #10;
    t = 1; #10;
    t = 0; #10;
    t = 1; #10;

    $finish;
end

endmodule
