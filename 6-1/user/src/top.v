module clock_div(reset, clk_100MHz, clk_10MHz, clk_6667KHz);
    input reset, clk_100MHz;
    output clk_10MHz, clk_6667KHz;

    clk_div_even #(
        .DIV   		( 10     		),
        .DIV_W 		( 3     		))
    u_clk_div_even(
        //ports
        .clk     		( clk_100MHz	),
        .rst_n   		( reset   		),
        .clk_div 		( clk_10MHz 	)
    );
    
    clk_div_odd #(
        .DIV   		( 15 		),
        .DIV_W 		( 4  		))
    u_clk_div_odd(
        //ports
        .clk     		( clk_100MHz    ),
        .rst_n   		( reset   		),
        .clk_div 		( clk_6667KHz 	)
    );

endmodule