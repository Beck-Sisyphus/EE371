
module nios_system (
	clk_clk,
	keys_export,
	reset_reset_n,
	switches_export);	

	input		clk_clk;
	output	[3:0]	keys_export;
	input		reset_reset_n;
	output	[9:0]	switches_export;
endmodule
