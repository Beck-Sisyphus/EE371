

module DE1_SoC (CLOCK_50, LEDR , SW , HEX0 , HEX1 , KEY);
	
	input [3:0] KEY;
	input [9:0] SW;
	input CLOCK_50;
	
	output [6:0] HEX0, HEX1;
	output [9:0] LEDR;
	
	wire pressurizing, evacuating, pressurizeFinished, evacuateFinished, waiting, waitFinished;
	wire [3:0] evacuateCount, pressurizeCount, waitCount;
	wire [6:0] PorD, number;
	
	assign HEX1 = PorD;
	assign HEX0 = number;

	assign LEDR[9] = SW[9];
	assign LEDR[1:0] = SW[1:0];
	
	reg [25:0] tBase;
	always@(posedge CLOCK_50) begin
		tBase <= tBase + 1'b1;
	end

	interlock inter (.clk(tBase[25]), .reset(~KEY[0]), .emptyCheck(SW[9]), .evacuating(evacuating), 
	                 .pressurizing(pressurizing), .innerPort(LEDR[3]), .outerPort(LEDR[2]), .status(LEDR[7:4]), 
						  .leaving(SW[1]), .arriving(SW[0]), .sw3(SW[3]), .sw2(SW[2]), .enter(LEDR[8]),
						  .evacuate(KEY[2]), .pressurize(KEY[1]), .pressurizeFinished(pressurizeFinished), 
						  .evacuateFinished(evacuateFinished), .waiting(waiting), .waitFinished(waitFinished));

   display disp (.PorD(PorD), .count(number), .clk(CLOCK_50), .evacuateCount(evacuateCount), .pressurizeCount(pressurizeCount),
					  .evacuating(evacuating), .pressurizing(pressurizing), .waiting(waiting), .waitCount(waitCount));
	
	timer pressurize(.count(pressurizeCount), .finished(pressurizeFinished), .clk(tBase[25]), .startCount(4'b0111), .key(~KEY[1]), .start(pressurizing));
	
	timer depressurize(.count(evacuateCount), .finished(evacuateFinished), .clk(tBase[25]), .startCount(4'b1000), .key(~KEY[2]) , .start(evacuating));

	timer wait5min(.count(waitCount), .finished(waitFinished), .clk(tBase[25]), .startCount(4'b0101), .key(1'b1), .start(waiting));

endmodule


