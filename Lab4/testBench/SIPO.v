module SIPO(data_in, sr_clk, reset, finish, data_out); // Serial In -> Parallel Out (10 bits)
	input sr_clk, reset;
	input data_in;
	input finish;
	output reg [7:0] data_out;

	reg [9:0] Q;

	always @(posedge sr_clk or reset) begin
		if (reset)
			Q <= 10'b0000000000;
		else begin
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
		end
	end

	always @(posedge finish) begin
		data_out[0] <= Q[1];
		data_out[1] <= Q[2];
		data_out[2] <= Q[3];
		data_out[3] <= Q[4];
		data_out[4] <= Q[5];
		data_out[5] <= Q[6];
		data_out[6] <= Q[7];
		data_out[7] <= Q[8];
	end
endmodule
