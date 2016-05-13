// Beck Pang
// University of Washington, Seattle
// Apr. 6th, 2015
// EE 471, Lab 1

module rippleDown ( clk, rst_n, out);
	input clk, rst_n; // Asynchronous reset active low
	output [3:0] out;

	wire [3:0] outBar;
	
	DFlipFlop d0 (out[0], outBar[0], outBar[0], clk, rst_n);
	DFlipFlop d1 (out[1], outBar[1], outBar[1], out[0], rst_n);
	DFlipFlop d2 (out[2], outBar[2], outBar[2], out[1], rst_n);
	DFlipFlop d3 (out[3], outBar[3], outBar[3], out[2], rst_n);
endmodule

`include "DFlipFlop.v"
module testBench ();

	// connext the two modules
	wire clk, rst_n;
	wire [3:0] out;

	// declare an instance of the AND module
	rippleDown myCounter (clk, rst_n, out);

	// Running the GUI part of simulation
	Tester aTester (clk, rst_n, out);

	// file for gtkwave

	initial
	begin
		$dumpfile("JohnsonCounter.vcd");
		$dumpvars(1, myCounter);
	end

endmodule

module Tester (
	output reg clk, rst_n,
	input [3:0] out
);

	parameter stimDelay = 20;

	// generate a clock
	always #(stimDelay/2) clk = ~clk;

	initial // Response
	begin
		$display("\t\t clk rst_n \t out \t   Time ");
		$monitor("\t %b ", out, $time);
		clk = 'b0;
	end

	always @(posedge clk) // Stimulus
	begin
					rst_n = 'b0;
		#stimDelay	rst_n = 'b1; 
		#(32*stimDelay)  rst_n = 'b0;
		#stimDelay  clk = 'b1;
		#(32*stimDelay)  clk = 'b0;
		#stimDelay  clk = 'b1;
		#(2*stimDelay);
		$stop;
		$finish;
	end

endmodule