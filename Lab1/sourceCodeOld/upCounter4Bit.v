// Beck Pang, Raymond Mui, Andrew Jordan Townsend
// University of Washington, Seattle
// Apr. 6th, 2015
// EE 471, Lab 1

// @requires: a clock, an active low reset
// @returns: a patent 0000, 0001, 0010, 0011, 0100, 0101, 
//  0110, 0111, 1000, 1001, 1010, 1011, 1100, 1101, 1110, 1111.
module upCounter4Bit (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	output [3:0] out
);
	wire [3:0] outBar;
	wire [3:0] d;
	
	assign d[0] = outBar[0];
	assign d[1] = out[1] ^ out[0];
	assign d[2] = out[2] ^ (out[1] & out[0]);
	assign d[3] = out[3] ^ (out[2] & out[1] & out[0]);

	DFlipFlop d0 (out[0], outBar[0], d[0], clk, rst_n);
	DFlipFlop d1 (out[1], outBar[1], d[1], clk, rst_n);
	DFlipFlop d2 (out[2], outBar[2], d[2], clk, rst_n);
	DFlipFlop d3 (out[3], outBar[3], d[3], clk, rst_n);
	
endmodule
