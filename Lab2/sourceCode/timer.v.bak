module timer(val , finished , clk , startingVal , change , start);

	output reg [3:0] val;
	output reg finished;
	input clk , change , start;
	input [3:0] startingVal;
	

	always@(posedge clk) 
	begin
		if(!start)
		begin
			val <= startingVal;
			finished <= 0;
		end
		else if(val == 4'b0000)
			finished <= 1;
		else if(change)
			val <= val - 4'b0001;
	end
endmodule
