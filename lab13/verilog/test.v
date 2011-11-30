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

`include "taillights.v"

module test;
    reg clk, L, R, H;
    wire [2:0] TL, TR;
	integer i;

	taillights tl1(.clk(clk), .L(L), .R(R), .H(H), .TL(TL), .TR(TR));

    initial begin
        $dumpfile("gtkwave-output.vcd");
        $dumpvars(0,test);

        // initialize
		L = 0;
		R = 0;
		H = 0;
        clk = 0;

		/*
		// Left
		L = 1;
		R = 0;
		for (i = 0; i <= 10; i = i + 1) begin
			#1;
		end

		// Right
		L = 0;
		R = 1;
		for (i = 0; i <= 10; i = i + 1) begin
			#1;
		end

		// Hazard
		H = 1;
		for (i = 0; i <= 10; i = i + 1) begin
			#1;
		end
		*/

		// Left, then change to right in the middle.
		L = 1;
		R = 0;
		for (i = 0; i <= 5; i = i + 1) begin
			#1;
		end
		L = 0;
		R = 1;
		for (i = 0; i <= 5; i = i + 1) begin
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

