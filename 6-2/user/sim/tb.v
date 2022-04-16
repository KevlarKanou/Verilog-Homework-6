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

    wire Z;

    string01011_moore u_string01011_moore(
        //ports
        .clk   		( clk   		),
        .reset 		( reset 		),
        .X     		( X     		),
        .Z     		( Z     		)
    );

endmodule