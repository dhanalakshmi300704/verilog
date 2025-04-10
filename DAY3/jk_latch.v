module jk_latch (
    input wire j,
    input wire k,
    input wire clk,
    output reg q,
    output wire q_bar
);

assign q_bar = ~q;

always @(clk or j or k) begin
    if (clk) begin
        case ({j, k})
            2'b00: q <= q;        // No change
            2'b01: q <= 0;        // Reset
            2'b10: q <= 1;        // Set
            2'b11: q <= ~q;       // Toggle
        endcase
    end
end

endmodule


testbench

`timescale 1ns / 1ps

module tb_jk_latch;

reg j, k, clk;
wire q, q_bar;

// Instantiate the JK latch
jk_latch uut (
    .j(j),
    .k(k),
    .clk(clk),
    .q(q),
    .q_bar(q_bar)
);

// Clock generator
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
end

// Stimulus
initial begin
    // Create VCD dump file
    $dumpfile("jk_latch.vcd");
    $dumpvars(0, tb_jk_latch);

    // Test sequence
    j = 0; k = 0; #10;
    j = 1; k = 0; #10;
    j = 0; k = 1; #10;
    j = 1; k = 1; #10;
    j = 0; k = 0; #10;
    j = 1; k = 1; #10;
    j = 1; k = 0; #10;
    j = 0; k = 1; #10;

    $finish;
end

endmodule



