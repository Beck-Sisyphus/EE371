module start_detect(data_in, reset, clk, state, enable);
	input data_in;
	input clk;
	input reset;
	input [3:0] state;
	output enable;

	reg enable, ns;

	always @(*) begin
		case(enable)
			1'b0: if (state == 4'b0000 & data_in == 1'b1)
						ns = 1'b1;
					else
						ns = 1'b0;
		   1'b1: if (state == 4'b1010 & data_in == 1'b0)
						ns = 1'b0;
					else
						ns = 1'b1;
		endcase
	end


	always @(posedge clk) begin
		if (reset)
			enable <= 1'b0;
		else
			enable <= ns;
		end
endmodule
