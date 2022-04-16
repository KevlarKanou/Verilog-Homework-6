`define ENABLE  1'b1
`define ENABLE_ 1'b0

module clk_div_even (
    input   wire    clk,
    input   wire    rst_n,

    output  reg     clk_div
);

    parameter DIV   = 50000;
    parameter DIV_W = 15;

    reg [DIV_W-1:0] counter;

    always @(posedge clk, negedge rst_n) begin
        if (rst_n == `ENABLE_) begin
            counter <= 16'b0;
            clk_div <= 1'b0;
        end
        else if (counter == DIV/2-1) begin
            counter <= 16'b0;
            clk_div <= ~clk_div;
        end
        else 
            counter <= counter + 1'b1;
    end
    
endmodule