module mux8x1 (
    input wire [7:0] in,
    input wire [2:0] sel,
    output wire out
);

assign out = in[sel];

endmodule


testbench

`timescale 1ns/1ps

module tb_mux8x1;

reg [7:0] in;
reg [2:0] sel;
wire out;

mux8x1 uut (
    .in(in),
    .sel(sel),
    .out(out)
);

initial begin
    // Dump file setup
    $dumpfile("mux8x1.vcd");
    $dumpvars(0, tb_mux8x1);

    $display("Time | Input      Sel | Out");
    $display("----------------------------");

    in = 8'b10101010;  // Example pattern: alternating 1s and 0s

    sel = 3'b000; #10;
    $display("%4t | %b %3b |  %b", $time, in, sel, out);

    sel = 3'b001; #10;
    $display("%4t | %b %3b |  %b", $time, in, sel, out);

    sel = 3'b010; #10;
    $display("%4t | %b %3b |  %b", $time, in, sel, out);

    sel = 3'b011; #10;
    $display("%4t | %b %3b |  %b", $time, in, sel, out);

    sel = 3'b100; #10;
    $display("%4t | %b %3b |  %b", $time, in, sel, out);

    sel = 3'b101; #10;
    $display("%4t | %b %3b |  %b", $time, in, sel, out);

    sel = 3'b110; #10;
    $display("%4t | %b %3b |  %b", $time, in, sel, out);

    sel = 3'b111; #10;
    $display("%4t | %b %3b |  %b", $time, in, sel, out);

    $finish;
end

endmodule
