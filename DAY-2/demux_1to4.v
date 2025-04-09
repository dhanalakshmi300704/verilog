// File: demux_1to4.v
module demux_1to4 (
    input        din,         // Single input
    input  [1:0] sel,         // 2-bit select lines
    output reg [3:0] dout     // 4 output lines
);
    always @(*) begin
        dout = 4'b0000; // Default all outputs to 0
        case (sel)
            2'b00: dout[0] = din;
            2'b01: dout[1] = din;
            2'b10: dout[2] = din;
            2'b11: dout[3] = din;
        endcase
    end
endmodule



testbench

// File: tb_demux_1to4.v
`timescale 1ns/1ps

module tb_demux_1to4;
    reg        din;
    reg  [1:0] sel;
    wire [3:0] dout;

    // Instantiate the module
    demux_1to4 uut (
        .din(din),
        .sel(sel),
        .dout(dout)
    );

    initial begin
        // VCD file generation
        $dumpfile("demux_1to4.vcd");
        $dumpvars(0, tb_demux_1to4);

        // Test with din = 1
        din = 1;
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;

        // Test with din = 0 (should turn all outputs off)
        din = 0;
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;

        $finish;
    end
endmodule
