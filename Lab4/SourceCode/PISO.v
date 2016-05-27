module PISO(sr_clk, clk, reset, data_in, data_out, load); // Parallel in -> Serial Out (10 bits)

	input sr_clk, clk, reset, load;
	input [7:0] data_in;
	output data_out;

	reg [9:0] Q_out;
	initial Q_out = 10'b1000000000;
	reg bitStream;

	assign data_out = bitStream;

	// Always block conducts parallel load
	always @(posedge clk) begin
			if (reset) begin
				Q_out[9:0] <= 10'b1000000000;
				end
			else if (sr_clk & load) begin
						Q_out[8:1] = data_in;
			end
			else if (sr_clk & load == 1'b0) begin
				bitStream = Q_out[9];
				Q_out[9] <= Q_out[8];
				Q_out[8] <= Q_out[7];
				Q_out[7] <= Q_out[6];
				Q_out[6] <= Q_out[5];
				Q_out[5] <= Q_out[4];
				Q_out[4] <= Q_out[3];
				Q_out[3] <= Q_out[2];
				Q_out[2] <= Q_out[1];
				Q_out[1] <= Q_out[0];
				Q_out[0] <= 1'b0;
		 end
	end
endmodule
