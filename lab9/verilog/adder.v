/*
 * 
 * Lab 9, EECE-144, Two-Bit Adder in Verilog
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
 * in some_file.vcd.
 *
 * This output file can then be shown with Gtkwave.
 *
 *   gtkwave some_file.vcd
 *
 * And from within Gtkwave you can pick and choose
 * variables to see their waveforms over time.
 */

// 'adder' is written in a "data flow modeling" style
// using primitives (and(), or(), ...) and operators(&, |, ~, ...)
// It is mostly written using operators in this case.
module adder(input a1,a0,b1, b0, output c, s1, s0);
    assign c =    (a1 & b1)
                | (a0 & b1 & b0) | (a1 & a0 & b0) ;

    assign s1 =   (a1 & ~b1 & ~b0)
                | (a1 & ~a0 & ~b1)
                | (a1 & a0 & b1 & b0)
                | (~a1 & a0 & ~b1 & b0)
                | (~a1 & ~a0 & b1)
                | (~a1 & b1 & ~b0);

    //assign s0 = (a0 & (~b0))| ((~a0) & b0); 
    // simplifies to an XOR
    //assign s0 = a0 ^ b0;
    xor(s0, a0, b0);
endmodule

module test;
    reg a1_in, a0_in, b1_in, b0_in;
	integer i;
    wire c_out, s1_out, s0_out;

     // Dont think of modules as being "called" as in C. 
     // Instead think of this like soldering a chip to a board.
    adder adder1(.a1(a1_in), .a0(a0_in), .b1(b1_in), .b0(b0_in),
                    .c(c_out), .s1(s1_out), .s0(s0_out));

    initial begin
        // produce output for GTKWave
        $dumpfile("gtkwave-02.vcd");
        $dumpvars(0,test);

        // header for the formatted output
        $display("a1 a0 b1 b0 | c s1 s0");
        $display("---------------------");

		for (i = 0; i < 16; i = i + 1) begin
				#1 {a1_in, a0_in, b1_in, b0_in} = i;
				#1 $display("%b  %b  %b  %b  | %b  %b  %b",
                	a1_in, a0_in, b1_in, b0_in, c_out, s1_out, s0_out);
		end
	end
endmodule
