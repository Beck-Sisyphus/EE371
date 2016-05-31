module BIC(sr_clk, enable, reset, finish, state);
	input sr_clk;
	input enable;
	input reset;
	output reg finish;
	output reg [3:0] state;

	always @(posedge sr_clk or reset or ~enable) begin
		if (reset) begin
			state <= 4'b0000;
			finish <= 1'b0;
			end
		else if (enable) begin
			state <= state + 1'b1;
			finish <= finish;
			if (state == 4'b1010) begin
				finish <= 1'b1;
				state <= 4'b1010;
			end
		end
		else begin
			state <= 4'b0000;
			finish <= 1'b0;
			end
	end
endmodule
