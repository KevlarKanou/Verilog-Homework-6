`timescale 1ns/1ps
module tb ();

    initial begin
       $dumpfile("wave.vcd");
       $dumpvars(0, tb);
       #6000 $finish;
    end

    reg X, clk = 1'b0, reset = 1'b1;

    always 
        #10 clk <= ~clk;

    always 
        #20 X <= $random();

    initial begin
        #10 reset = 1'b0;
        #10 reset = 1'b1;
    end

    wire 	Z;

    string01011_mealy #(
        .IDLE 		( 5'b00000 		),
        .S1   		( 5'b00001 		),
        .S2   		( 5'b00010 		),
        .S3   		( 5'b00100 		),
        .S4   		( 5'b01000 		))
    u_string01011_mealy(
        //ports
        .clk   		( clk   		),
        .reset 		( reset 		),
        .X     		( X     		),
        .Z     		( Z     		)
    );

endmodule