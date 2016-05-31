`include "BSC.v"

module BSC_testBench ();

    // connext the two modules
        wire sr_clk, clk, reset, enable;

    // declare an instance of the AND module
    BSC bsc (reset, enable, clk, sr_clk);

    // Running the GUI part of simulation
    BSC_Tester aTester (reset, enable, clk, sr_clk);

    // file for gtkwave

    initial
    begin
        $dumpfile("BSC.vcd");
        $dumpvars(1, bsc);
    end

endmodule

module BSC_Tester (reset, enable, clk, sr_clk);
    output reg clk, reset, enable;
    input sr_clk;

    parameter stimDelay = 10;

    // generate a clock
    always #(stimDelay/2) clk = ~clk;

    initial // Response
    begin
        clk = 'b0;
    end

    always @(posedge clk) // Stimulus
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

