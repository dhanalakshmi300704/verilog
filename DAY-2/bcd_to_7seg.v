// File: bcd_to_7seg.v
module bcd_to_7seg (
    input  [3:0] bcd,
    output reg [6:0] seg
);
    // seg[6:0] = {a, b, c, d, e, f, g}
    always @(*) begin
        case (bcd)
            4'd0: seg = 7'b1111110;
            4'd1: seg = 7'b0110000;
            4'd2: seg = 7'b1101101;
            4'd3: seg = 7'b1111001;
            4'd4: seg = 7'b0110011;
            4'd5: seg = 7'b1011011;
            4'd6: seg = 7'b1011111;
            4'd7: seg = 7'b1110000;
            4'd8: seg = 7'b1111111;
            4'd9: seg = 7'b1111011;
            default: seg = 7'b0000000; // blank for invalid BCD
        endcase
    end
endmodule


testbench

// File: tb_bcd_to_7seg.v
`timescale 1ns/1ps

module tb_bcd_to_7seg;
    reg  [3:0] bcd;
    wire [6:0] seg;

    // Instantiate the module
    bcd_to_7seg uut (
        .bcd(bcd),
        .seg(seg)
    );

    initial begin
        // VCD setup
        $dumpfile("bcd_to_7seg.vcd");
        $dumpvars(0, tb_bcd_to_7seg);

        // Test 0 to 9
        for (bcd = 0; bcd < 10; bcd = bcd + 1) begin
            #10;
        end

        // Test invalid BCD values (10–15)
        for (bcd = 10; bcd < 16; bcd = bcd + 1) begin
            #10;
        end

        $finish;
    end
endmodule
