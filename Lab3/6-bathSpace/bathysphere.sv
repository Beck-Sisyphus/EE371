module bathysphere(CLOCK_50, LEDR, KEY ,HEX0 , HEX1);
		input CLOCK_50;   // 50 MHz clock
		//input		proc_reset;
		input [3:0] KEY;
		output   [9:0] LEDR;
		output	[6:0] HEX0, HEX1;

		wire [9:0] sw1;
		wire [3:0] key1;
		
		reg [25:0] tBase;
		always@(posedge CLOCK_50) begin
			tBase <= tBase + 1'b1;
		end

      nios_system u0 (
        .clk_clk         (CLOCK_50),         //      clk.clk
        .keys_export     (key1),     //     keys.export
        .reset_reset_n   (KEY[0]),   //    reset.reset_n
        .switches_export (sw1)  // switches.export
    );

		DE1_SoC d1 (.CLOCK_50(tBase[25]), .ledr(LEDR) , .sw(sw1) , .hex0(HEX0) , .hex1(HEX1) , .key(key1), .RESET(KEY[0]));
 
endmodule