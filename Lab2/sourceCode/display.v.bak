

module display (letter , number , clk , val , draining , filling);

	output [6:0] letter , number;
	input clk , draining , filling;
	input [3:0] val;
	
	
	always @(posedge clk)
	begin
		if(!draining && !filling)
		begin
			letter <= ~7'b0000000;
			number <= ~7'b0000000;
		end
	else
	begin
		if(draining)
			letter <= ~7'b0111111;
		else
			letter <= ~7'b1110001;
		case(val)
		begin
			// Light: 6543210 
			0: num = ~7'b0111111; 
			1: num = ~7'b0000110; 
			2: num = ~7'b1011011; 
			3: num = ~7'b1001111; 
			4: num = ~7'b1100110; 
			5: num = ~7'b1101101; 
			6: num = ~7'b1111101; 
			7: num = ~7'b0000111; 
			8: num = ~7'b1111111; 
			default: num = 7'bX; 
		endcase 
		
		
		end
	
	end
	
	
	
	
	
	
	
	end

	
endmodule

