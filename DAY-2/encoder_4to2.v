// File: encoder_4to2.v
module encoder_4to2 (
    input  [3:0] din,      // 4 input lines
    output reg [1:0] out,  // 2-bit output
    output reg       valid // High when any input is active
);
    always @(*) begin
        valid = 1'b1;
        casex (din)
            4'b1xxx: out = 2'b11; // Highest priority: input 3
            4'b01xx: out = 2'b10; // input 2
            4'b001x: out = 2'b01; // input 1
            4'b0001: out = 2'b00; // input 0
            default: begin
                out = 2'b00;
                valid = 1'b0;      // No valid input
            end
        endcase
    end
endmodule



testbench

// File: tb_encoder_4to2.v
`timescale 1ns/1ps

module tb_encoder_4to2;
    reg  [3:0] din;
    wire [1:0] out;
    wire       valid;

    // Instantiate encoder
    encoder_4to2 uut (
        .din(din),
        .out(out),
        .valid(valid)
    );

    initial begin
        // VCD setup
        $dumpfile("encoder_4to2.vcd");
        $dumpvars(0, tb_encoder_4to2);

        // Test cases
        din = 4'b0000; #10;
        din = 4'b0001; #10;
        din = 4'b0010; #10;
        din = 4'b0100; #10;
        din = 4'b1000; #10;
        din = 4'b1010; #10;
        din = 4'b0110; #10;
        din = 4'b1111; #10;

        $finish;
    end
endmodule
