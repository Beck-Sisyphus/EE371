module test(sr_clk, enable, finish, clk, reset, data_in, data_out); // Parallel in -> Serial Out (10 bits)
	
	input sr_clk, enable, finish, clk, reset;
	input [7:0] data_in;
	output data_out;

	reg [9:0] Q_out;
	reg bitStream;
	
	assign data_out = bitStream;
	
	// Always block conducts parallel load 
	always @(posedge clk) begin
			if (reset) 
				Q_out[9:0] <= 10'b0000000001;
			else if (sr_clk == 1'b1 & enable & !finish) begin // export serially
				Q_out[8:1] = data_in;
				bitStream = Q_out[0];
				Q_out[0] <= Q_out[1];
				Q_out[1] <= Q_out[2];
				Q_out[2] <= Q_out[3];
				Q_out[3] <= Q_out[4];
				Q_out[4] <= Q_out[5];
				Q_out[5] <= Q_out[6];
				Q_out[6] <= Q_out[7];
				Q_out[7] <= Q_out[8];
				Q_out[8] <= Q_out[9];
				Q_out[9] <= 1'b0; 
		   end
	end
endmodule