/*
 * T flip-flop with synchronous reset
 *
 * The reset is active high and sets 'q' to zero.
 *
 */
module tff (input wire t, clk, reset, output reg q, output wire q_n);
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            q <= 1'b0;
        end
        else if (t == 1'b0) begin
            //q <= q;
        end
        //else if (t == 1'b1) begin
        else begin
            q <= ~q;
        end
    end

    assign q_n = ~q;
endmodule
