module display (PorD, count, clk, evacuateCount, pressurizeCount, evacuating, pressurizing, waiting, waitCount);

	output reg [6:0] PorD, count;
	input clk, evacuating, pressurizing, waiting;
   input [3:0] evacuateCount, pressurizeCount, waitCount;
	
	
	always @(posedge clk)
	begin
		if(!evacuating && !pressurizing && !waiting) 
			begin
				PorD <= ~7'b0000000;
				count <= ~7'b0000000;
			end
		else
		begin
			if(evacuating)
				begin
				PorD <= ~7'b1011110;
				case(evacuateCount)
				
					// Light: 6543210 
					0: count <= ~7'b0111111; 
					1: count <= ~7'b0000110; 
					2: count <= ~7'b1011011; 
					3: count <= ~7'b1001111; 
					4: count <= ~7'b1100110; 
					5: count <= ~7'b1101101; 
					6: count <= ~7'b1111101; 
					7: count <= ~7'b0000111; 
					8: count <= ~7'b1111111; 
					default: count <= 7'bX;
				endcase 
				end
			else if(pressurizing)
				begin
				PorD <= ~7'b1110011;
				case(pressurizeCount)
					// Light: 6543210 
					0: count <= ~7'b0111111; 
					1: count <= ~7'b0000110; 
					2: count <= ~7'b1011011; 
					3: count <= ~7'b1001111; 
					4: count <= ~7'b1100110; 
					5: count <= ~7'b1101101; 
					6: count <= ~7'b1111101; 
					7: count <= ~7'b0000111; 
					8: count <= ~7'b1111111; 
					default: count <= 7'bX; 
				endcase
				end 
			else
				begin
				PorD <= ~7'b1000000;
				case(waitCount)
					// Light: 6543210 
					0: count <= ~7'b0111111; 
					1: count <= ~7'b0000110; 
					2: count <= ~7'b1011011; 
					3: count <= ~7'b1001111; 
					4: count <= ~7'b1100110; 
					5: count <= ~7'b1101101; 
					6: count <= ~7'b1111101; 
					7: count <= ~7'b0000111; 
					8: count <= ~7'b1111111; 
					default: count <= 7'bX; 
				endcase
				end
			end
		end

	
endmodule

