
module niosII_microprocessor (
	address_export,
	clk_clk,
	data_export,
	led_export,
	outen_export,
	reset_reset_n,
	wren_export);	

	output	[10:0]	address_export;
	input		clk_clk;
	inout	[7:0]	data_export;
	output	[7:0]	led_export;
	output		outen_export;
	input		reset_reset_n;
	output		wren_export;
endmodule
