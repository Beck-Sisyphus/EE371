module transmit(data_in, enable, reset, clk, load, data_out, finish);
	input [7:0] data_in;
	input enable, load;
	input reset, clk;
	output data_out;
	output finish;

	wire sr_clk;
	wire data;

	BSC bsc(.reset, .enable, .clk, .sr_clk);
	BIC bic(.sr_clk, .enable, .reset, .clk, .finish);
	PISO piso(.sr_clk, .clk, .reset, .data_in, .data_out(data), .load);
	buffer b(.clk, .reset, .data_in(data), .data_out);
endmodule
