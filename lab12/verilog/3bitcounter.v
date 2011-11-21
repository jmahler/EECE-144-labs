`include "jkff.v"
`include "dff.v"
`include "tff.v"

/*
 * 3 bit up down counter with synchronous reset.
 *
 * The reset is active high and sets all outputs to zero.
 *
 */
module threebitudc (input wire x, clk, reset, output wire q2, q1, q0);
    wire jk2, t1, d0;
    wire q0_n, q1_n, q2_n;

    // Include the flip-flops
    dff q0ff(.d(d0), .clk(clk), .reset(reset), .q(q0), .q_n(q0_n));
    tff q1ff(.t(t1), .clk(clk), .reset(reset), .q(q1), .q_n(q1_n));
    jkff q2ff(.j(jk2), .k(jk2), .clk(clk), .reset(reset), .q(q2), .q_n(q2_n));

    // connect all the wires to each other
    assign jk2 = (~x && q1) || (~x && q0)  || (q2 && q1 && ~q0)
                            || (~q2 && q0) || (x && ~q1);

    assign t1 = (~x && ~q1 && ~q0)  || (~x && q1 && q0)
                                    || (x && q2 && q0) || (x && ~q2 && ~q0);

    assign d0 = (q2 && ~q1) || (~x && q2 && ~q0) || (x && ~q1)
                            || (~x && ~q2 && q1 && q0);
endmodule

