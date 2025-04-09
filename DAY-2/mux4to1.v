// File: mux4to1.v
module mux4to1 (
    input  [3:0] in,      // Data inputs: in[3], in[2], in[1], in[0]
    input  [1:0] sel,     // 2-bit select
    output       out      // Output
);
    assign out = (sel == 2'b00) ? in[0] :
                 (sel == 2'b01) ? in[1] :
                 (sel == 2'b10) ? in[2] :
                                 in[3];
endmodule


testbench

// File: tb_mux4to1.v
`timescale 1ns/1ps

module tb_mux4to1;
    reg  [3:0] in;
    reg  [1:0] sel;
    wire       out;

    // Instantiate the multiplexer
    mux4to1 uut (
        .in(in),
        .sel(sel),
        .out(out)
    );

    initial begin
        // VCD Dump
        $dumpfile("mux4to1.vcd");
        $dumpvars(0, tb_mux4to1);

        // Test different select values with static inputs
        in = 4'b1010;

        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;

        // Test dynamic input values with same selects
        sel = 2'b01;
        in = 4'b0000; #10;
        in = 4'b1111; #10;
        in = 4'b1001; #10;

        $finish;
    end
endmodule
