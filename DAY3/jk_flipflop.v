module jk_flipflop (
    input wire j,
    input wire k,
    input wire clk,
    output reg q,
    output wire q_bar
);

assign q_bar = ~q;

always @(posedge clk) begin
    case ({j, k})
        2'b00: q <= q;      // No change
        2'b01: q <= 0;      // Reset
        2'b10: q <= 1;      // Set
        2'b11: q <= ~q;     // Toggle
    endcase
end

endmodule


testbench

`timescale 1ns / 1ps

module tb_jk_flipflop;

reg j, k, clk;
wire q, q_bar;

// Instantiate the JK flip-flop
jk_flipflop uut (
    .j(j),
    .k(k),
    .clk(clk),
    .q(q),
    .q_bar(q_bar)
);

// Clock generator
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
end

// Test sequence
initial begin
    $dumpfile("jk_flipflop.vcd");
    $dumpvars(0, tb_jk_flipflop);

    // Test patterns
    j = 0; k = 0; #10;  // No change
    j = 1; k = 0; #10;  // Set
    j = 0; k = 1; #10;  // Reset
    j = 1; k = 1; #10;  // Toggle
    j = 0; k = 0; #10;  // No change
    j = 1; k = 1; #10;  // Toggle
    j = 1; k = 0; #10;  // Set
    j = 0; k = 1; #10;  // Reset

    $finish;
end

endmodule
