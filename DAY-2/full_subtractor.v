module full_subtractor (
    input wire a,
    input wire b,
    input wire bin,
    output wire diff,
    output wire bout
);

assign diff = a ^ b ^ bin;
assign bout = (~a & b) | (b & bin) | (~a & bin);

endmodule


testbench

`timescale 1ns/1ps

module tb_full_subtractor;

reg a, b, bin;
wire diff, bout;

full_subtractor uut (
    .a(a),
    .b(b),
    .bin(bin),
    .diff(diff),
    .bout(bout)
);

initial begin
    // VCD waveform dump
    $dumpfile("full_subtractor.vcd");
    $dumpvars(0, tb_full_subtractor);

    $display("A B Bin | Diff Bout");
    $display("-------------------");

    a = 0; b = 0; bin = 0; #10;
    $display("%b %b  %b  |   %b    %b", a, b, bin, diff, bout);

    a = 0; b = 0; bin = 1; #10;
    $display("%b %b  %b  |   %b    %b", a, b, bin, diff, bout);

    a = 0; b = 1; bin = 0; #10;
    $display("%b %b  %b  |   %b    %b", a, b, bin, diff, bout);

    a = 0; b = 1; bin = 1; #10;
    $display("%b %b  %b  |   %b    %b", a, b, bin, diff, bout);

    a = 1; b = 0; bin = 0; #10;
    $display("%b %b  %b  |   %b    %b", a, b, bin, diff, bout);

    a = 1; b = 0; bin = 1; #10;
    $display("%b %b  %b  |   %b    %b", a, b, bin, diff, bout);

    a = 1; b = 1; bin = 0; #10;
    $display("%b %b  %b  |   %b    %b", a, b, bin, diff, bout);

    a = 1; b = 1; bin = 1; #10;
    $display("%b %b  %b  |   %b    %b", a, b, bin, diff, bout);

    $finish;
end

endmodule

