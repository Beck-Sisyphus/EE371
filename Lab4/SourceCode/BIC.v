module BIC(sr_clk, enable, reset, finish, state);
	input sr_clk;
	input enable;
	input reset;
	//input clk;
	output reg finish;
	output reg [3:0] state;
	
	/*always @(posedge clk) begin
		finish <= 1'b0;
		if (reset) begin
			state <= 4'b0000;
			finish <= 1'b0;
		end
		else if(enable & sr_clk) begin  
			state <= state + 1'b1;
			if (state == 4'b1010)
				finish <= 1'b1;
		end
	end
*/



	  always @(posedge sr_clk) begin
		if (reset) begin
			state <= 4'b0000;
			finish <= 1'b0;
			end
		else if (enable) begin
			state <= state + 1'b1;
			if (state == 4'b1010) begin
				finish <= 1'b1;
				state <= 4'b0000;
			end
		end
		else 
			state <= 4'b0000;
			finish <= 1'b0;
			
	end

endmodule