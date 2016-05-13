	module DE1_SoC(CLOCK_50, KEY, LEDR);
		input CLOCK_50;   // 50 MHz clock
		input  [3:0] KEY; // Active Low
		output [9:0] LEDR;
		
		assign LEDR[9:8] = 2'b00;
  
  	niosII_microprocessor u0 (
		.clk_clk                            (CLOCK_50),              //      clk.clk
		.reset_reset_n                      (KEY[0]),                   //      reset.reset_n
		.led_pio_external_connection_export (LEDR[7:0]) 						 // 		led_pio_external_connection.export
	);

  
   /*
   	niosII_microprocessor u0 (
		.clk_clk                            (<connected-to-clk_clk>),                            //                         clk.clk
		.reset_reset_n                      (<connected-to-reset_reset_n>),                      //                       reset.reset_n
		.led_pio_external_connection_export (<connected-to-led_pio_external_connection_export>)  // led_pio_external_connection.export
	);
	*/
 
	endmodule
	
	