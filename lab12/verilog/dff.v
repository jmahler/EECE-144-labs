/*
 * D flip-flop with synchronous reset
 *
 * The reset is active high and sets 'q' to zero.
 *
 */
module dff (input wire d, clk, reset, output reg q, output wire q_n);
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            q <= 1'b0;
        end
        else begin
            q <= d;
        end
    end

    assign q_n = ~q;
endmodule
