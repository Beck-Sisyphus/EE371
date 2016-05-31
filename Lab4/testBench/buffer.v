module buffer(input clk, reset, data_in, output data_out);
	reg q;
	assign data_out = q;
	 
	always @(posedge clk) begin
		if (reset) begin
			q <= 1;
		end else begin
			q <= data_in;
		end
	end
endmodule