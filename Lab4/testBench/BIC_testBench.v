`include "BIC.v"

module BIC_testBench ();

    // connext the two modules
        wire sr_clk, reset, enable, finish;
        wire [3:0] state;

    // declare an instance of the AND module
    BIC bic (sr_clk, enable, reset, finish, state);

    // Running the GUI part of simulation
    BIC_Tester aTester (sr_clk, enable, reset, finish, state);

    // file for gtkwave

    initial
    begin
        $dumpfile("BIC.vcd");
        $dumpvars(1, bic);
    end

endmodule

module BIC_Tester (sr_clk, enable, reset, finish, state);
    output reg sr_clk, reset, enable;
    input finish;
    input [3:0] state;

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
        #stimDelay    reset <= 1'b0;
        #stimDelay
        reset <= 1'b1;
        #stimDelay
        reset <= 1'b0;
	   enable <= 1'b1;
        #(10*stimDelay)
        #(32*stimDelay)
        #(32*stimDelay)
        enable <= 1'b0;
        #(32*stimDelay)

        $stop;
        $finish;
    end

endmodule

