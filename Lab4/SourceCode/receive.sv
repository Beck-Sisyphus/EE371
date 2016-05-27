module receive(data_in, reset, clk, data_out, finish);
	input data_in, reset, clk;
	output [7:0] data_out;
	output finish;

	wire data;
	wire [3:0] BIC;
	wire enable;
	wire sr_clk;

	buffer b(.clk, .reset, .data_in, .data_out(data));
	start_detect detect(.data_in(data), .reset, .clk, .BIC, .enable);
	BSC bsc(.reset, .enable, .clk, .sr_clk);
	BIC bic(.sr_clk, .enable, .reset, .clk, .finish);
	SIPO sipo(.data_in(data), .sr_clk, .clk, .reset, .finish, .data_out);

endmodule