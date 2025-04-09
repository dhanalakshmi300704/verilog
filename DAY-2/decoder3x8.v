// File: decoder3to8.v
module decoder3to8 (
    input  [2:0] in,
    input        enable,
    output reg [7:0] out
);
    always @(*) begin
        if (enable)
            out = 8'b00000001 << in; // One-hot encoding
        else
            out = 8'b00000000;
    end
endmodule



testbench

// File: tb_decoder3to8.v
`timescale 1ns/1ps

module tb_decoder3to8;
    reg [2:0] in;
    reg       enable;
    wire [7:0] out;

    // Instantiate the decoder
    decoder3to8 uut (
        .in(in),
        .enable(enable),
        .out(out)
    );

    initial begin
        // VCD waveform setup
        $dumpfile("decoder3to8.vcd");
        $dumpvars(0, tb_decoder3to8);

        // Test with enable low
        enable = 0;
        in = 3'b000; #10;
        in = 3'b001; #10;

        // Test with enable high
        enable = 1;
        in = 3'b000; #10;
        in = 3'b001; #10;
        in = 3'b010; #10;
        in = 3'b011; #10;
        in = 3'b100; #10;
        in = 3'b101; #10;
        in = 3'b110; #10;
        in = 3'b111; #10;

        // Disable again
        enable = 0; in = 3'b101; #10;

        $finish;
    end
endmodule
