module t_latch (
    input wire t,
    input wire clk,
    output reg q,
    output wire q_bar
);

assign q_bar = ~q;

always @(clk or t) begin
    if (clk) begin
        if (t)
            q <= ~q;  // Toggle
        else
            q <= q;   // Hold
    end
end

endmodule



testbench


`timescale 1ns / 1ps

module tb_t_latch;

reg t, clk;
wire q, q_bar;

// Instantiate the T latch
t_latch uut (
    .t(t),
    .clk(clk),
    .q(q),
    .q_bar(q_bar)
);

// Clock signal
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns period
end

// Stimulus
initial begin
    // Create VCD dump file
    $dumpfile("t_latch.vcd");
    $dumpvars(0, tb_t_latch);

    // Test sequence
    t = 0; #10;
    t = 1; #10;
    t = 1; #10;
    t = 0; #10;
    t = 1; #10;
    t = 0; #10;
    t = 1; #10;
    t = 1; #10;

    $finish;
end

endmodule

