module BSC(reset, enable, clk, sr_clk);
	input reset;
	input enable;
	input clk;
	output reg sr_clk;
	reg [3:0] state;
	always @(posedge clk) begin
		sr_clk <= 1'b0;
		if (reset) begin
			state <= 4'b0000;
			sr_clk <= 1'b0;
		end
		else if (enable) begin
			state <= state + 1;
			if (state == 4'b1000)
				sr_clk <= 1'b1;
		end
	end
endmodule