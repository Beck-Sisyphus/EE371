// Beck Pang, Raymond Mui, Andrew Jordan Townsend
// University of Washington, Seattle
// Apr. 6th, 2015
// EE 471, Lab 1

// @requires: a clock, an active low reset
// @returns: a patent 0000, 1000, 1100, 1110, 1111, 0111, 0011, 0001.
module JohnsonCounter(clk,rst_n, out);
	input clk, rst_n;
	output reg [3:0] out;
	reg [3:0] outns;


	always @(*)
	begin
		outns[3] = ~out[0];
		outns[2:0] = out[3:1];
	end

// DFFs
    always @(negedge rst_n or posedge clk)
    	if (!rst_n)
            out <= 4'b0;
        else 
        	out <= outns;
endmodule

