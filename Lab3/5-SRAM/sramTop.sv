// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
// File name: 
//	sramTop.sv
//
// Description:
//	Tests sram module in the sram.sv file
//
// Author:
//	Nick Lopez
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

// `include "sram.sv"

module testBench;
	// connect the two modules
	wire [15:0] data;
	wire 		readWrite, enable;
	wire [9:0]	address;
	
	// declare an instance of the MyDesign module
	sram sram1(data, readWrite, enable, address);

	// declare an instance of the Tester module
	Tester tester1 (readWrite, enable, address, data);

	// file specifications for gtkwave
	initial
	begin
		// dump file is for dumping all the variables in a simulation
		$dumpfile("sram.vcd");
		// dumps all the variables in module myDesign and below
		// but not modules instantiated in myDesign into the dumpfile.
		$dumpvars(1, sram1);
	end
endmodule

module Tester (readWrite, enable, address, data); 
	
	output			readWrite, enable;
	output [9:0]	address; 
	inout [15:0]	data;
	
	reg 		readWrite, enable;
	reg [9:0]	address;
	reg [15:0]	data1;

	wire [15:0]	data;

	parameter stimDelay = 20;
	integer i;

	assign data = !enable? data1 : 16'bzzzzzzzzzzzzzzzz;
	initial // Response
	begin
	enable = 1'b1;
	address = 9'b0;
	data1 = 16'b0;
	readWrite = 1'b1;
//	$display("\t pressureComp depressureComp pressureState \t clk reset pressurize depressurize \t Time ");
//	$monitor("\t\t %b \t\t %b \t %b \t\t %b \t %b \t %b \t %b", pressureComp, depressureComp, pressureState, clk, reset, pressurize, depressurize, $time );
	end
	
	initial // Stimulus
	begin 
	#stimDelay data1 = 16'b1;
	#stimDelay;
	#stimDelay;
	#stimDelay enable = 1'b0;
	#stimDelay readWrite = 1'b0;
	#stimDelay;
	#stimDelay;
	#stimDelay readWrite = 1'b1;
	
	for(i = 0; i < 128; i = i + 1) begin
		#stimDelay data1 = 127 - i; address = i;
		#stimDelay;
		#stimDelay readWrite = 1'b0;
		#stimDelay;
		#stimDelay;		
		#stimDelay readWrite = 1'b1;
		#stimDelay;
		#stimDelay;
	end

	#(60*stimDelay); // needed to see END of simulation
	$finish; // finish simulation
	end
endmodule