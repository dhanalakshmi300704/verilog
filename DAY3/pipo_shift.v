module pipo_shift #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire rst,
    input wire load,
    input wire [WIDTH-1:0] pin,
    output reg [WIDTH-1:0] pout
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            pout <= 0;
        else if (load)
            pout <= pin;
    end

endmodule



testbench

`timescale 1ns / 1ps

module tb_pipo_shift;

    reg clk;
    reg rst;
    reg load;
    reg [7:0] pin;
    wire [7:0] pout;

    // Instantiate the PIPO register
    pipo_shift #(8) uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .pin(pin),
        .pout(pout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    initial begin
        $dumpfile("pipo_shift.vcd");
        $dumpvars(0, tb_pipo_shift);

        // Initialize
        rst = 1;
        load = 0;
        pin = 8'b00000000;
        #10;

        rst = 0;

        // Load first data
        pin = 8'b10101010;
        load = 1;
        #10;
        load = 0;

        // Hold output
        #20;

        // Load second data
        pin = 8'b11001100;
        load = 1;
        #10;
        load = 0;

        #20;

        $finish;
    end

endmodule
