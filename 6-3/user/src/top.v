module string01011_mealy (clk, reset, X, Z);
    input clk, reset, X;
    output Z;
  
    parameter   IDLE    = 5'b00000,  
                S1      = 5'b00001,     // 0
                S2      = 5'b00010,     // 01 
                S3      = 5'b00100,     // 010
                S4      = 5'b01000;     // 0101
                // S5      = 5'b10000;     // 01011

    reg [4:0] state, next_state;

    always @(posedge clk, negedge reset) begin
        if (reset == 1'b0)
            state <= S1;
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            IDLE :
                if (X == 0)
                    next_state = S1;
                else
                    next_state = IDLE;
            S1 :
                if (X == 1)
                    next_state = S2;
                else if (X == 0)
                    next_state = S1;
                else
                    next_state = IDLE;
            S2 :
                if (X == 0)
                    next_state = S3;
                else
                    next_state = IDLE;
            S3 :
                if (X == 1)
                    next_state = S4;
                else if (X == 0)
                    next_state = S1;
                else
                    next_state = IDLE;
            S4 : 
                if (X == 0)
                    next_state = S3;
                else
                    next_state = IDLE;
            default :
                next_state = IDLE;
        endcase
    end

    assign Z = ((state == S4) & (X == 1)) ? 1'b1 : 1'b0;

endmodule