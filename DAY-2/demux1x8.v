module demux1x8 (
    input wire din,
    input wire [2:0] sel,
    output reg [7:0] out
);

always @(*) begin
    out = 8'b00000000;
    out[sel] = din;
end

endmodule


testbench

`timescale 1ns/1ps

module tb_demux1x8;

reg din;
reg [2:0] sel;
wire [7:0] out;

demux1x8 uut (
    .din(din),
    .sel(sel),
    .out(out)
);

initial begin
    // VCD waveform dump
    $dumpfile("demux1x8.vcd");
    $dumpvars(0, tb_demux1x8);

    $display("Time | Din Sel | Output");
    $display("------------------------");

    din = 1;

    sel = 3'b000; #10;
    $display("%4t |  %b   %3b | %b", $time, din, sel, out);

    sel = 3'b001; #10;
    $display("%4t |  %b   %3b | %b", $time, din, sel, out);

    sel = 3'b010; #10;
    $display("%4t |  %b   %3b | %b", $time, din, sel, out);

    sel = 3'b011; #10;
    $display("%4t |  %b   %3b | %b", $time, din, sel, out);

    sel = 3'b100; #10;
    $display("%4t |  %b   %3b | %b", $time, din, sel, out);

    sel = 3'b101; #10;
    $display("%4t |  %b   %3b | %b", $time, din, sel, out);

    sel = 3'b110; #10;
    $display("%4t |  %b   %3b | %b", $time, din, sel, out);

    sel = 3'b111; #10;
    $display("%4t |  %b   %3b | %b", $time, din, sel, out);

    din = 0; sel = 3'b011; #10;  // test with din = 0
    $display("%4t |  %b   %3b | %b", $time, din, sel, out);

    $finish;
end

endmodule

