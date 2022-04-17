`timescale 1ns/1ps

module tb (

);

    initial begin
       $dumpfile("wave.vcd");
       $dumpvars(0, tb);
       #10000 $finish;
    end

    wire 	open;
    wire 	error;

    reg clk = 0, reset = 1;
    always 
        #10 clk <= ~clk;

    initial begin
        #20 reset <= ~reset;
        #20 reset <= ~reset;
    end

    always @(*) begin
        if (open || error) begin
            #30 reset = 1'b0;
            #30 reset = 1'b1;
        end 
    end

    reg [2:0] in;
    wire b1, b2, b3, b4;

    always 
        #20 in <= {$random}%5;

    assign b1 = (in == 3'd1) ? 1'b1 : 1'b0;
    assign b2 = (in == 3'd2) ? 1'b1 : 1'b0;
    assign b3 = (in == 3'd3) ? 1'b1 : 1'b0;
    assign b4 = (in == 3'd4) ? 1'b1 : 1'b0;

    lock #(
        .IDLE  		( 3'd0 		),
        .S1    		( 3'd1 		),
        .S2    		( 3'd2 		),
        .S3    		( 3'd3 		),
        .S4    		( 3'd4 		),
        .OPEN  		( 3'd5 		),
        .ERROR 		( 3'd6 		))
    u_lock(
        //ports
        .clk   		( clk   		),
        .reset 		( reset 		),
        .b1    		( b1    		),
        .b2    		( b2    		),
        .b3    		( b3    		),
        .b4    		( b4    		),
        .open  		( open  		),
        .error 		( error 		)
    );

endmodule