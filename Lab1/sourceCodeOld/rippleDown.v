// Beck Pang, Raymond Mui, Andrew Jordan Townsend
// University of Washington, Seattle
// Apr. 6th, 2015
// EE 471, Lab 1

// @requires: a clock, an active low reset
// @returns: a patent 1111, 1110, 1101, 1100, 1011, 1010, 1001,
//  1000, 0111, 0110, 0101, 0100, 0011, 0010, 0001, 0000.
module rippleDown ( clk, rst_n, out);
	input clk, rst_n; // Asynchronous reset active low
	output [3:0] out;

	wire [3:0] outBar;
	
	DFlipFlop d0 (out[0], outBar[0], outBar[0], clk, rst_n);
	DFlipFlop d1 (out[1], outBar[1], outBar[1], out[0], rst_n);
	DFlipFlop d2 (out[2], outBar[2], outBar[2], out[1], rst_n);
	DFlipFlop d3 (out[3], outBar[3], outBar[3], out[2], rst_n);
endmodule
