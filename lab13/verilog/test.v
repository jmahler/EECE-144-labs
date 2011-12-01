/*
 * Test bench tail lights.
 *
 * To compile this file run:
 *
 *   iverilog test.v
 *
 * Run the executable:
 *
 *   ./a.out
 * OR
 *   vvp a.out
 *
 * Because $dumpfile and $dumpvars have been
 * added it will generate data for gtkwave
 * in gtkwave-output.vcd.
 *
 * This output file can then be shown with Gtkwave.
 *
 *   gtkwave gtkwave-output.vcd
 *
 * And from within Gtkwave you can pick and choose
 * variables to see their waveforms over time.
 *
 *
 * This project was completed as part of lab 13 in the
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

	taillights tl1(.clk(clk), .L(L), .R(R), .H(H), .TL(TL), .TR(TR));

    initial begin
        $dumpfile("gtkwave-output.vcd");
        $dumpvars(0,test);

        // initialize
		L = 0;
		R = 0;
		H = 0;
        clk = 0;

		// configure how to run the test

		/*
		// Left
		L = 1; R = 0;

		// Right
		#10 L = 0; R = 1;
		*/
	   	
	    /*
		// Hazard
		H = 0;
		#5 H = 1;
		// engaging the left or right should not change anything
		#5 L = 1;
		#5 L = 0; R=1;
		*/

		// back and forth from left to right
		H = 0;
		L = 1; R = 0;
		#4 L = 0; R = 1;
		#9 L = 1; R = 0;
		#5 L = 0; R = 1;

	   	#2 $finish;
    end

    always begin
        #1 clk = ~clk;
    end
endmodule

