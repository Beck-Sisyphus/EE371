

module display (letter , num , clk , drainVal , fillVal , draining , filling , waiting , waitVal);

	output reg [6:0] letter , num;
	input clk , draining , filling , waiting;
	input [3:0] drainVal , fillVal , waitVal;
	
	
	always @(posedge clk)
	begin
		if(!draining && !filling && !waiting)
			begin
				letter <= ~7'b0000000;
				num <= ~7'b0000000;
			end
		else
		begin
			if(draining)
				begin
				letter <= ~7'b1011110;
				case(drainVal)
				
					// Light: 6543210 
					0: num <= ~7'b0111111; 
					1: num <= ~7'b0000110; 
					2: num <= ~7'b1011011; 
					3: num <= ~7'b1001111; 
					4: num <= ~7'b1100110; 
					5: num <= ~7'b1101101; 
					6: num <= ~7'b1111101; 
					7: num <= ~7'b0000111; 
					8: num <= ~7'b1111111; 
					default: num <= 7'bX;
				endcase 
				end
			else if(filling)
				begin
				letter <= ~7'b1110011;
				case(fillVal)
					// Light: 6543210 
					0: num <= ~7'b0111111; 
					1: num <= ~7'b0000110; 
					2: num <= ~7'b1011011; 
					3: num <= ~7'b1001111; 
					4: num <= ~7'b1100110; 
					5: num <= ~7'b1101101; 
					6: num <= ~7'b1111101; 
					7: num <= ~7'b0000111; 
					8: num <= ~7'b1111111; 
					default: num <= 7'bX; 
				endcase
				end 
			else
				begin
				letter <= ~7'b1000000;
				case(waitVal)
					// Light: 6543210 
					0: num <= ~7'b0111111; 
					1: num <= ~7'b0000110; 
					2: num <= ~7'b1011011; 
					3: num <= ~7'b1001111; 
					4: num <= ~7'b1100110; 
					5: num <= ~7'b1101101; 
					6: num <= ~7'b1111101; 
					7: num <= ~7'b0000111; 
					8: num <= ~7'b1111111; 
					default: num <= 7'bX; 
				endcase
				end
			end
		end

	
endmodule

