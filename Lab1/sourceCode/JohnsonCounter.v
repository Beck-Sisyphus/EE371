// Beck Pang, Hongyu Xiao, Zhuolun Zhou
// University of Washington, Seattle
// Apr. 13th, 2016
// EE 371, Lab 1

// @requires: a clock, an active low reset
// @returns: a pattern of 1111, 0111, 0011, 0001, 0000, 1000, 1100, 1110, 1111
module JohnsonCounter(clk,rst_n, out);
	input clk, rst_n;
	output reg [3:0] out = 4'b1111;
	reg [3:0] outns;


	always @(*)
	begin
		outns[3] = ~out[0];
		outns[2:0] = out[3:1];
	end

// DFFs
    always @(negedge rst_n or posedge clk)
   		if (rst_n == 1'b0)
           out <= 4'b1111;
        else 
       		out <= outns;
endmodule

