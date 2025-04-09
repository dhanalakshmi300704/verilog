// File: cla_adder_4bit.v
module cla_adder_4bit (
    input  [3:0] A,
    input  [3:0] B,
    input        Cin,
    output [3:0] Sum,
    output       Cout,
    output       P, // Group Propagate
    output       G  // Group Generate
);
    wire [3:0] P_i, G_i;
    wire [4:0] C;

    assign C[0] = Cin;

    // Propagate and Generate
    assign P_i = A ^ B;
    assign G_i = A & B;

    // Carry Look-Ahead Logic
    assign C[1] = G_i[0] | (P_i[0] & C[0]);
    assign C[2] = G_i[1] | (P_i[1] & G_i[0]) | (P_i[1] & P_i[0] & C[0]);
    assign C[3] = G_i[2] | (P_i[2] & G_i[1]) | (P_i[2] & P_i[1] & G_i[0]) | (P_i[2] & P_i[1] & P_i[0] & C[0]);
    assign C[4] = G_i[3] | (P_i[3] & G_i[2]) | (P_i[3] & P_i[2] & G_i[1]) | (P_i[3] & P_i[2] & P_i[1] & G_i[0]) | 
                  (P_i[3] & P_i[2] & P_i[1] & P_i[0] & C[0]);

    // Sum calculation
    assign Sum = P_i ^ C[3:0];

    // Final outputs
    assign Cout = C[4];
    assign P = &P_i; // Group propagate (P = P0 & P1 & P2 & P3)
    assign G = G_i[3] | (P_i[3] & G_i[2]) | (P_i[3] & P_i[2] & G_i[1]) | (P_i[3] & P_i[2] & P_i[1] & G_i[0]);
endmodule



testbench

// File: tb_cla_adder_4bit.v
`timescale 1ns/1ps

module tb_cla_adder_4bit;
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] Sum;
    wire       Cout, P, G;

    // Instantiate CLA
    cla_adder_4bit uut (
        .A(A), .B(B), .Cin(Cin),
        .Sum(Sum), .Cout(Cout), .P(P), .G(G)
    );

    initial begin
        // VCD dump
        $dumpfile("cla_adder_4bit.vcd");
        $dumpvars(0, tb_cla_adder_4bit);

        // Test cases
        Cin = 0;
        A = 4'b0000; B = 4'b0000; #10;
        A = 4'b0011; B = 4'b0001; #10;
        A = 4'b0101; B = 4'b0011; #10;
        A = 4'b1111; B = 4'b0001; #10;

        Cin = 1;
        A = 4'b0001; B = 4'b0001; #10;
        A = 4'b1001; B = 4'b1001; #10;
        A = 4'b1111; B = 4'b1111; #10;

        $finish;
    end
endmodule
