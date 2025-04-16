module register (
    input wire clk,
    input wire rst,
    input wire [7:0] d,
    output reg [7:0] q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 8'b0;
    else
        q <= d;
end

endmodule


testbench


`timescale 1ns / 1ps

module tb_register;

    reg clk;
    reg rst;
    reg [7:0] d;
    wire [7:0] q;

    // Instantiate the register module
    register uut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Create VCD dump file
        $dumpfile("register.vcd");
        $dumpvars(0, tb_register);

        // Initialize signals
        rst = 1;
        d = 8'h00;
        #10;

        rst = 0;
        d = 8'hA5;
        #10;

        d = 8'h3C;
        #10;

        rst = 1;
        #10;

        rst = 0;
        d = 8'hF0;
        #10;

        $finish;
    end

endmodule
