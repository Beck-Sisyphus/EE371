module timer(count, finished, clk, startCount, key, start);

	output reg [3:0] count;
	output reg finished;
	input clk, key, start;
	input [3:0] startCount;
	

	always@(posedge clk) 
	begin
		if(!start)
		begin
			count <= startCount;
			finished <= 0;
		end
		else if(count == 4'b0000)
			finished <= 1;
		else if(key)
			count <= count - 4'b0001;
	end
endmodule
