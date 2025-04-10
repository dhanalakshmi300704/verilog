module sr_flipflop (
    input wire s,
    input wire r,
    input wire clk,
    output reg q,
    output wire q_bar
);

assign q_bar = ~q;

always @(posedge clk) begin
    case ({s, r})
        2'b00: q <= q;      // No change
        2'b01: q <= 0;      // Reset
        2'b10: q <= 1;      // Set
        2'b11: q <= 1'bx;   // Invalid state
    endcase
end

endmodule


testbench

`timescale 1ns / 1ps

module tb_sr_flipflop;

reg s, r, clk;
wire q, q_bar;

// Instantiate SR flip-flop
sr_flipflop uut (
    .s(s),
    .r(r),
    .clk(clk),
    .q(q),
    .q_bar(q_bar)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
end

// Stimulus
initial begin
    $dumpfile("sr_flipflop.vcd");
    $dumpvars(0, tb_sr_flipflop);

    // Apply test inputs
    s = 0; r = 0; #10;  // No change
    s = 1; r = 0; #10;  // Set
    s = 0; r = 1; #10;  // Reset
    s = 0; r = 0; #10;  // No change
    s = 1; r = 1; #10;  // Invalid
    s = 1; r = 0; #10;  // Set
    s = 0; r = 1; #10;  // Reset

    $finish;
end

endmodule
