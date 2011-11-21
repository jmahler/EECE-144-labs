/*
 * Test bench for 3 bit counter.
 *
 * To compile this file run:
 *
 *   iverilog this_file.v
 *
 * Run the executable:
 *
 *   ./a.out
 * OR
 *   vvp a.out
 *
 * Because $dumpfile and $dumpvars have been
 * added it will generate data for gtkwave
 * in 3bitcounter.vcd.
 *
 * This output file can then be shown with Gtkwave.
 *
 *   gtkwave 3bitcounter.vcd
 *
 * And from within Gtkwave you can pick and choose
 * variables to see their waveforms over time.
 *
 *
 * This project was completed as part of lab 12 in the
 * class EECE-144 taught by Kurtis Kredo II at Chico State
 * during the Fall of 2011.
 *
 * Author(s): Jeremiah Mahler <jmmahler@gmail.com>
 * 		      Marvanee Johnson
 */

`include "3bitcounter.v"

module test;
    reg clk, reset, x;
    wire q2, q1, q0;
	integer i;

    threebitudc tbudc(.x(x), .clk(clk), .reset(reset), .q2(q2), .q1(q1), .q0(q0));

    initial begin
        $dumpfile("gtkwave-output.vcd");
        $dumpvars(0,test);

        //#1 $display("clk  x  q2  q1  q0");
        //#1 $display("-------------------");

        // reset and initialize the clock
        #1 reset = 1;
        #1 clk = 0;
        #1 clk = 1;
        #1 clk = 0;
        #1 reset = 0;

        x = 0; // 0 up, 1 down
		for (i = 0; i <= 8; i = i + 1) begin
			#1;
		end

		// reset in the middle
		#1 reset = 1;
        #1 clk = 0;
        #1 clk = 1;
        reset = 0;

        //x = 0; // 0 up, 1 down
		for (i = 0; i <= 8; i = i + 1) begin
			#1;
		end

        //$monitor("%b    %b  %b  %b  %b", clk, x, q2, q1, q0);

        //#16 $finish;
        /* Each time unit switches the clock up/down (see below).
         * We need twice as many here since the flip-flop is triggered
         * only on the positive edge.
        */

	   	$finish;
    end

    always begin
        #1 clk = ~clk;
    end
endmodule

