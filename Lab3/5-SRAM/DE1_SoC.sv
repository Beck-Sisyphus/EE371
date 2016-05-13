	module DE1_SoC(CLOCK_50, KEY, LEDR);
		input CLOCK_50;   // 50 MHz clock
		input  [3:0] KEY; // Active Low
		output  [9:0] LEDR;
		assign LEDR[9:8] = 2'b00;	
		
		wire OutEn, WrEn;
		wire [10:0] address;
		wire [7:0] data;	

		niosII_microprocessor u0 (
        .address_export (address), // address.export
        .clk_clk        (CLOCK_50),        //     clk.clk
        .data_export    (data),    //    data.export
		  .led_export     (LEDR[7:0]),     //     led.export
        .outen_export   (OutEn),   //   outen.export
        .reset_reset_n  (KEY[0]),   //   reset.reset_n
		  .wren_export    (WrEn)    //    wren.export
		);
		
		sram s2 (CLOCK_50, address, WrEn, OutEn, data);
 
	endmodule
	
	