`define ENABLE  1'b1
`define ENABLE_ 1'b0

module clk_div_odd (
    input   wire    clk,
    input   wire    rst_n,

    output  wire    clk_div
);

    parameter DIV   = 15;
    parameter DIV_W = 4;

    reg [DIV_W-1:0] counter_p, counter_n;
    reg clk_div_p, clk_div_n;

    always @(posedge clk, negedge rst_n) begin
        if (rst_n == `ENABLE_) begin
            counter_p   <= 16'b0;
            clk_div_p   <= 1'b0;
        end 
        else if (clk_div_p == 0) begin
            if (counter_p == DIV/2) begin
                counter_p   <= 16'b0;
                clk_div_p   <= ~clk_div_p;
            end
            else
                counter_p   <= counter_p + 1;
        end
        else begin
            if (counter_p == DIV/2-1) begin
                counter_p   <= 16'b0;
                clk_div_p   <= ~clk_div_p;
            end
            else
                counter_p   <= counter_p + 1;
        end
    end

    always @(negedge clk, negedge rst_n) begin
        if (rst_n == `ENABLE_) begin
            counter_n   <= 16'b0;
            clk_div_n   <= 1'b0;
        end
        else if (clk_div_n == 0) begin
            if (counter_n == DIV/2) begin
                counter_n   <= 16'b0;
                clk_div_n   <= ~clk_div_n;
            end
            else
                counter_n   <= counter_n + 1;
        end
        else begin
            if (counter_n == DIV/2-1) begin
                counter_n   <= 16'b0;
                clk_div_n   <= ~clk_div_n;
            end
            else
                counter_n   <= counter_n + 1;
        end
    end

    assign clk_div = clk_div_p | clk_div_n;

endmodule