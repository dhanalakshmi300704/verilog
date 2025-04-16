module piso_shift #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire rst,
    input wire load,
    input wire [WIDTH-1:0] pin,
    output wire sout
);

    reg [WIDTH-1:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst)
            shift_reg <= 0;
        else if (load)
            shift_reg <= pin;
        else
            shift_reg <= {1'b0, shift_reg[WIDTH-1:1]}; // shift right
    end

    assign sout = shift_reg[0]; // LSB first out

endmodule


testbench

`timescale 1ns / 1ps

module tb_piso_shift;

    reg clk;
    reg rst;
    reg load;
    reg [7:0] pin;
    wire sout;

    // Instantiate PISO register
    piso_shift #(8) uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .pin(pin),
        .sout(sout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period
    end

    initial begin
        $dumpfile("piso_shift.vcd");
        $dumpvars(0, tb_piso_shift);

        // Reset
        rst = 1;
        load = 0;
        pin = 8'b0;
        #10;

        rst = 0;

        // Load parallel data
        pin = 8'b11010101;
        load = 1;
        #10;

        // Start shifting out
        load = 0;
        #80; // Shift 8 bits out

        $finish;
    end

endmodule

