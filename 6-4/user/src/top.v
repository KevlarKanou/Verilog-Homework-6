module lock(clk, reset, b1, b2, b3, b4, open, error);
    input clk, reset, b1, b2, b3, b4;
    output open, error;

    parameter   IDLE    = 3'd0,
                S1      = 3'd1,
                S2      = 3'd2,
                S3      = 3'd3,
                S4      = 3'd4,
                OPEN    = 3'd5,
                ERROR   = 3'd6;

    reg [15:0]  buffer;
    reg [2:0]   state, next_state;

    reg [3:0] in;

    always @(*) begin
        case ({b1, b2, b3, b4})
            4'b1000 :
                in = 4'h1;
            4'b0100 :
                in = 4'h2;
            4'b0010 :
                in = 4'h3;
            4'b0001 :
                in = 4'h4;
            default :
                in = 4'b0;
        endcase
    end

    always @(posedge clk, negedge reset) begin
        if (reset == 1'b0)
            state <= IDLE;
        else 
            state <= next_state;
    end

    always @(posedge clk, negedge reset) begin
        if (reset == 1'b0)
            buffer <= 16'h0;
        else if ((state == OPEN) || (state == ERROR))
            buffer <= 16'h0;
        else if (in != 4'b0)
            buffer <= {buffer[11:0], in};
    end

    always @(*) begin
        case (state)
            IDLE :
                if (in != 4'b0)
                    next_state = S1;
                else
                    next_state = IDLE;
            S1 :
                if (in != 4'b0)
                    next_state = S2;
                else
                    next_state = S1;
            S2 :
                if (in != 4'b0)
                    next_state = S3;
                else
                    next_state = S2;
            S3 :
                if (in != 4'b0)
                    next_state = S4;
                else
                    next_state = S3;
            S4 :
                if ((buffer == 16'h2431) || (buffer == 16'h1443))
                    next_state = OPEN;
                else
                    next_state = ERROR;
            OPEN :
                next_state = OPEN;
            ERROR :
                next_state = ERROR;
            default: 
                next_state = IDLE;
        endcase
    end

    assign open = (state == OPEN) ? 1'b1 : 1'b0;
    assign error = (state == ERROR) ? 1'b1 : 1'b0;
endmodule