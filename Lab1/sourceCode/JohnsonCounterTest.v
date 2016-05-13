// Sui Pang, Hongyu Xiao, Zhuolun Zhou
// University of Washington, Seattle
// Apr. 13th, 2015
// EE 371, Lab 1

`include "DFlipFlop.v"
`include "JohnsonCounter.v"

// test bench running on gtkwave
module JohnsonCounter_testBench ();

	// connext the two modules
	wire clk, rst_n;
	wire [3:0] out;

	// declare an instance of the AND module
	JohnsonCounter myCounter (clk, rst_n, out);

	// Running the GUI part of simulation
	JohnsonCounter_Tester aTester (clk, rst_n, out);

	// file for gtkwave

	initial
	begin
		$dumpfile("JohnsonDownCounter.vcd");
		$dumpvars(1, myCounter);
	end

endmodule

module JohnsonCounter_Tester (
	output reg clk, rst_n,
	input [3:0] out
);

	parameter stimDelay = 20;

	// generate a clock
	always #(stimDelay/2) clk = ~clk;

	initial // Response
	begin
		$display("\t clk \t out ");
		$monitor("\t %b ", out, $time);
		clk = 'b0;
	end

	always @(posedge clk) // Stimulus
	begin
		
		#stimDelay 	    rst_n = 'b0;
		#(32*stimDelay)	rst_n = 'b1; 
		$stop;
		$finish;
	end

endmodule