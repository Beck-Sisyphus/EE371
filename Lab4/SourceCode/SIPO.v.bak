module SIPO(data_in, sr_clk, clk, reset, finish, data_out); // Serial In -> Parallel Out (10 bits)
	input sr_clk, clk, reset, finish;
	input data_in;
	output reg [7:0] data_out;

	reg [9:0] Q;
	
	always @(posedge clk) begin
		if (reset) 
			Q <= 10'b1000000000;
		else if (sr_clk == 1'b1) begin 
			Q[0] <= data_in;
			Q[1] <= Q[0];
			Q[2] <= Q[1];
			Q[3] <= Q[2];
			Q[4] <= Q[3];
			Q[5] <= Q[4];
			Q[6] <= Q[5];
			Q[7] <= Q[6];
			Q[8] <= Q[7];
			Q[9] <= Q[8];
			if (finish)
				data_out[7] <= Q[8];
				data_out[6] <= Q[7];
				data_out[5] <= Q[6];
				data_out[4] <= Q[5];
				data_out[3] <= Q[4];
				data_out[2] <= Q[3];
				data_out[1] <= Q[2];
				data_out[0] <= Q[1];
		end
	end
endmodule 