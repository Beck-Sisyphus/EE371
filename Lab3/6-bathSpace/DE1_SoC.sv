

module DE1_SoC (CLOCK_50, ledr , sw , hex0 , hex1 , key, RESET);
	
	input [3:0] key;
	input [9:0] sw;
	input CLOCK_50;
	input RESET;
	
	output [6:0] hex0, hex1;
	output [9:0] ledr;
	
	wire pressurizing, evacuating, pressurizeFinished, evacuateFinished, waiting, waitFinished;
	wire [3:0] evacuateCount, pressurizeCount, waitCount;
	wire [6:0] PorD, number;
	
	assign hex1 = PorD;
	assign hex0 = number;

	assign ledr[9] = sw[6];
	assign ledr[1:0] = sw[1:0];
	

	interlock inter (.clk(CLOCK_50), .reset(~RESET), .emptyCheck(sw[6]), .evacuating(evacuating), 
	                 .pressurizing(pressurizing), .innerPort(ledr[3]), .outerPort(ledr[2]), .status(ledr[7:4]), 
						  .leaving(sw[1]), .arriving(sw[0]), .sw3(sw[3]), .sw2(sw[2]), .enter(ledr[8]),
						  .evacuate(key[2]), .pressurize(key[1]), .pressurizeFinished(pressurizeFinished), 
						  .evacuateFinished(evacuateFinished), .waiting(waiting), .waitFinished(waitFinished));

   display disp (.PorD(PorD), .count(number), .clk(CLOCK_50), .evacuateCount(evacuateCount), .pressurizeCount(pressurizeCount),
					  .evacuating(evacuating), .pressurizing(pressurizing), .waiting(waiting), .waitCount(waitCount));
	
	timer pressurize(.count(pressurizeCount), .finished(pressurizeFinished), .clk(CLOCK_50), .startCount(4'b0111), .key(~key[1]), .start(pressurizing));
	
	timer depressurize(.count(evacuateCount), .finished(evacuateFinished), .clk(CLOCK_50), .startCount(4'b1000), .key(~key[2]) , .start(evacuating));

	timer wait5min(.count(waitCount), .finished(waitFinished), .clk(CLOCK_50), .startCount(4'b0101), .key(1'b1), .start(waiting));

endmodule


