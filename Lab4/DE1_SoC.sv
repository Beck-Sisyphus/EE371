module DE1_SoC (LEDR, KEY, CLOCK_50, GPIO_0, GPIO_1);
	input CLOCK_50; // 50MHz clock.
	input [3:0] KEY;
  input [35:0] GPIO_0;
  output [35:0] GPIO_1;
  output [9:0] LEDR;

  assign LEDR[9:8] = 2'b00;
  assign GPIO_1 [35:1] = 'bZ;

	wire char_sent, char_received;
	wire [7:0] data_out;
	wire [7:0] data_in;
	wire reset;
	wire transmit_enable, load;
	reg [31:0] clk;
	always@(posedge CLOCK_50) begin
		clk <= clk + 1'b1;
	end

	lab4CPU cpu(
		.clk_clk(CLOCK_50),
		.reset_reset_n(~KEY[0]),
		.character_recieved_input_external_connection_export(char_received),
		.character_sent_input_external_connection_export(char_sent),
		.led_output_external_connection_export(LEDR[7:0]),
		.load_output_external_connection_export(load),
		.parallel_input_external_connection_export(data_out),
		.parallel_output_external_connection_export(data_in),
		.transmit_enable_output_external_connection_export(transmit_enable)
	);

  receive rx (GPIO_0[0], ~KEY[0], clk[7], data_out, char_received);

  transmit tx (data_in, transmit_enable, ~KEY[0], clk[7], load, GPIO_1[0], char_sent);

endmodule
