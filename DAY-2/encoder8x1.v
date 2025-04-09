// File: encoder8to1.v
module encoder8to1 (
    input  [7:0] in,
    output reg [2:0] out,
    output reg valid
);
    always @(*) begin
        valid = 1'b1;
        case (in)
            8'b00000001: out = 3'b000;
            8'b00000010: out = 3'b001;
            8'b00000100: out = 3'b010;
            8'b00001000: out = 3'b011;
            8'b00010000: out = 3'b100;
            8'b00100000: out = 3'b101;
            8'b01000000: out = 3'b110;
            8'b10000000: out = 3'b111;
            default: begin
                out = 3'b000;
                valid = 1'b0;  // Invalid input (more than one bit high or all zero)
            end
        endcase
    end
endmodule



testbench

// File: tb_encoder8to1.v
`timescale 1ns/1ps

module tb_encoder8to1;
    reg [7:0] in;
    wire [2:0] out;
    wire valid;

    // Instantiate the encoder
    encoder8to1 uut (
        .in(in),
        .out(out),
        .valid(valid)
    );

    initial begin
        // Dump VCD waveform file
        $dumpfile("encoder8to1.vcd");
        $dumpvars(0, tb_encoder8to1);

        // Test all single-bit inputs
        in = 8'b00000001; #10;
        in = 8'b00000010; #10;
        in = 8'b00000100; #10;
        in = 8'b00001000; #10;
        in = 8'b00010000; #10;
        in = 8'b00100000; #10;
        in = 8'b01000000; #10;
        in = 8'b10000000; #10;

        // Test invalid input (more than one high bit)
        in = 8'b00000110; #10;

        // Test invalid input (all zeros)
        in = 8'b00000000; #10;

        $finish;
    end
endmodule

