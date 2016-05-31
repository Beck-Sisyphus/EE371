module BIC(sr_clk, enable, reset, clk, finish);
	input sr_clk;
	input enable;
	input reset;
	input clk;
	output reg finish;
	reg [3:0] state;
	
	always @(posedge clk) begin
		finish <= 1'b0;
		if (reset) begin
			state <= 4'b0000;
			finish <= 1'b0;
		end
		else if(enable & sr_clk) begin  
			state <= state + 1;
			if (state == 4'b1010)
				finish <= 1'b1;
		end
	end	
endmodule