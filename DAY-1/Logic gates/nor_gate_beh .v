module nor_gate_beh (
    input wire a,
    input wire b,
    output reg y
);

// Behavioral modeling using always block
always @(*) begin
    if (a == 1'b0 && b == 1'b0)
        y = 1'b1;
    else
        y = 1'b0;
end

endmodule


testbench

module nor_gate_beh (
    input wire a,
    input wire b,
    output reg y
);

// Behavioral modeling using always block
always @(*) begin
    if (a == 1'b0 && b == 1'b0)
        y = 1'b1;
    else
        y = 1'b0;
end

endmodule
