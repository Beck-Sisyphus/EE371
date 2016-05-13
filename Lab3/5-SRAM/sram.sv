module sram(clk, adx, WrEn, OutEn,  data);
	parameter DATA_WIDTH = 8;
	parameter DATA_LENGTH= 2048;
	parameter ADX_LENGTH = 11;

	input clk, OutEn, WrEn;	// Active low write enable
	input [ADX_LENGTH - 1:0] adx;
	inout [DATA_WIDTH - 1:0] data;

	reg [DATA_WIDTH - 1:0]SRAM[DATA_LENGTH - 1:0]; // memory regs
	
	assign data = (WrEn & !OutEn) ? SRAM[adx] : 8'bZ; // control the tri-state 
	
	always @(posedge clk) begin
		if( !WrEn & OutEn) 
				SRAM[adx] = data; // assign the SRAM index to data
	end

endmodule  