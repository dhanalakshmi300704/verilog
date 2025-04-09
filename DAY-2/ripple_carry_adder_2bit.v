// File: ripple_carry_adder_2bit.v
module ripple_carry_adder_2bit (
    input  [1:0] A,
    input  [1:0] B,
    input        Cin,
    output [1:0] Sum,
    output       Cout
);
    wire c1;

    // Full Adder 0 (LSB)
    assign Sum[0] = A[0] ^ B[0] ^ Cin;
    assign c1     = (A[0] & B[0]) | (A[0] & Cin) | (B[0] & Cin);

    // Full Adder 1 (MSB)
    assign Sum[1] = A[1] ^ B[1] ^ c1;
    assign Cout   = (A[1] & B[1]) | (A[1] & c1) | (B[1] & c1);
endmodule



testbench

// File: tb_ripple_carry_adder_2bit.v
`timescale 1ns/1ps

module tb_ripple_carry_adder_2bit;
    reg [1:0] A, B;
    reg       Cin;
    wire [1:0] Sum;
    wire       Cout;

    // Instantiate the adder
    ripple_carry_adder_2bit uut (
        .A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout)
    );

    initial begin
        // Setup VCD
        $dumpfile("ripple_carry_adder_2bit.vcd");
        $dumpvars(0, tb_ripple_carry_adder_2bit);

        // Test all possible combinations
        Cin = 0;
        for (A = 0; A < 4; A = A + 1) begin
            for (B = 0; B < 4; B = B + 1) begin
                #10;
            end
        end

        Cin = 1;
        for (A = 0; A < 4; A = A + 1) begin
            for (B = 0; B < 4; B = B + 1) begin
                #10;
            end
        end

        $finish;
    end
endmodule
