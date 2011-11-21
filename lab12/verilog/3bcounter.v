
/*
 * JK flip-flop with synchronous reset
 *
 * The reset is active high and sets 'q' to zero.
 *
 */
module jkff (input j, k, clk, reset, output reg q, output wire q_n);
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            q <= 1'b0;
        end
        else if (j == 1'b0 && k == 1'b0) begin
            //q <= q;
        end
        else if (j == 1'b0 && k == 1'b1) begin
            q <= 0;
        end
        else if (j == 1'b1 && k == 1'b0) begin
            q <= 1;
        end
        //else if (j == 1'b1 && k == 1'b1) begin
        else begin
            q <= ~q;
        end
    end

    assign q_n = ~q;
endmodule


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


module test;
    reg clk, reset, x;
    wire q2, q1, q0;

    threebitudc tbudc(.x(x), .clk(clk), .reset(reset), .q2(q2), .q1(q1), .q0(q0));

    initial begin
        #1 $display("clk  x  q2  q1  q0");
        #1 $display("-------------------");

        // reset and initialize the clock
        #1 reset = 1;
        #1 clk = 0;
        #1 clk = 1;
        #1 clk = 0;
        #1 reset = 0;

        // choose wheter to count up or down
        //x = 0; // count up
        x = 1; // count down

        $monitor("%b    %b  %b  %b  %b", clk, x, q2, q1, q0);

        #16 $finish;
        /* Each time unit switches the clock up/down (see below).
         * We need twice as many here since the flip-flop is triggered
         * only on the positive edge.
        */
    end

    always begin
        #1 clk = ~clk;
    end
endmodule

