`include "SIPO.v"

module SIPO_testBench ();

    // connext the two modules
    wire [7:0] data_out;
    wire sr_clk, reset, finish, data_in;

    // declare an instance of the AND module
    SIPO sipo(data_in, sr_clk, reset, finish, data_out);

    // Running the GUI part of simulation
    SIPO_Tester aTester (data_in, sr_clk, reset, finish, data_out);

    // file for gtkwave

    initial
    begin
        $dumpfile("sipo.vcd");
        $dumpvars(1, sipo);
    end

endmodule

module SIPO_Tester (data_in, sr_clk, reset, finish, data_out);
    output reg data_in, sr_clk, reset, finish;
    input [7:0] data_out;

    parameter stimDelay = 10;

    // generate a clock
    always #(stimDelay/2) sr_clk = ~sr_clk;

    initial // Response
    begin
         sr_clk = 'b0;
    end

    always @(posedge sr_clk) // Stimulus
    begin
                    //reset = 'b0;
        #stimDelay    reset <= 1'b1;
        #stimDelay
        reset <= 1'b0;
	   finish <= 1'b0;
        #(10*stimDelay)
	  data_in <= 1'b1;
  
        #stimDelay
        #(8*stimDelay)
        
        data_in <= 1'b0;
        #stimDelay
        #(8*stimDelay)
        data_in <= 1'b0;
        #stimDelay
        
        #(8*stimDelay)
        
        data_in <= 1'b1;
        #stimDelay
        
        #(8*stimDelay)
        
        data_in <= 1'b0;
        #stimDelay
        
        #(8*stimDelay)
        
        data_in <= 1'b1;
        #stimDelay
        
        #(8*stimDelay)
        data_in <= 1'b1;
        #stimDelay
        
        #(8*stimDelay)
        
        data_in <= 1'b0;
        #stimDelay
        
        #(8*stimDelay)
        
        data_in <= 1'b1;
        #stimDelay
        
        #(8*stimDelay)
        data_in <= 1'b0;
        #stimDelay
        
	   finish <= 1'b1;        
        #(32*stimDelay)
        $stop;
        $finish;
    end

endmodule

