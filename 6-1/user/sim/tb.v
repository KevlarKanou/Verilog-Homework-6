`timescale 1ns/1ps

module tb ();

    initial begin
       $dumpfile("wave.vcd");
       $dumpvars(0, tb);
       #500 $finish;
    end

    reg rst_n = 1;
    initial begin
        #10 rst_n = 0;
        #10 rst_n = 1;
    end

    reg clk_100MHz = 0;
    always 
        #5 clk_100MHz <= ~clk_100MHz;

    wire 	clk_10MHz;
    wire 	clk_6667KHz;

    clock_div u_clock_div(
        //ports
        .reset       		( rst_n       		),
        .clk_100MHz  		( clk_100MHz  		),
        .clk_10MHz   		( clk_10MHz   		),
        .clk_6667KHz 		( clk_6667KHz 		)
    );

    // clk_div_odd #(
    //     .DIV   		( 15 		),
    //     .DIV_W 		( 4  		))
    // u_clk_div_odd(
    //     //ports
    //     .clk     		( clk_100MHz  	),
    //     .rst_n   		( rst_n   		),
    //     .clk_div 		( clk_6667KHz 	)
    // );

endmodule