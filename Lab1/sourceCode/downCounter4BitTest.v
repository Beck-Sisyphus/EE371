// Beck Pang
// University of Washington, Seattle
// Apr. 6th, 2015
// EE 471, Lab 1


`include "downCounter4Bit.v"
module downCounter4Bit_testBench ();

	// connext the two modules
	wire clk, rst_n;
	wire [3:0] out;

	// declare an instance of the AND module
	downCounter4Bit myCounter (clk, rst_n, out);

	// Running the GUI part of simulation
	downCounter4Bit_Tester aTester (clk, rst_n, out);

	// file for gtkwave

	initial
	begin
		$dumpfile("downCounter.vcd");
		$dumpvars(1, myCounter);
	end

endmodule

module downCounter4Bit_Tester (
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