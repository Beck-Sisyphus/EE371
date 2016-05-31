`include "PISO.v"

module PISO_testBench ();

    // connext the two modules
    wire [7:0] data_in;
    wire sr_clk, clk, reset, data_out, load;

    // declare an instance of the AND module
    PISO tx (sr_clk, clk, reset, data_in, data_out, load);

    // Running the GUI part of simulation
    PISO_Tester aTester (sr_clk, clk, reset, data_in, data_out, load);

    // file for gtkwave

    initial
    begin
        $dumpfile("piso.vcd");
        $dumpvars(1, tx);
    end

endmodule

module PISO_Tester (sr_clk, clk, reset, data_in, data_out, load);
    output reg sr_clk, clk, reset, load;
    output reg [7:0] data_in;
    input data_out;

    parameter stimDelay = 10;

    // generate a clock
    always #(stimDelay/2) clk = ~clk;

    initial // Response
    begin
        // $display("\t\t clk rst_n \t out \t   Time ");
        $monitor("\t %b ", data_out, sr_clk, $time);
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
        #(10*stimDelay)
        load = 1'b0;
        sr_clk = 1'b0;
        #stimDelay
        reset <= 1'b0;
        data_in <= 8'b0101010;
        load = 1'b1;
        #stimDelay
        sr_clk = 1'b1;
        #(8*stimDelay)
        sr_clk = 1'b0;
        #stimDelay
        sr_clk = 1'b1;
        #(8*stimDelay)
        sr_clk = 1'b0;
        #stimDelay
        sr_clk = 1'b1;
        #(8*stimDelay)
        sr_clk = 1'b0;
        load = 1'b0;
        #stimDelay
        #stimDelay
        load = 1'b1;
        data_in <= 8'b11001001;
        #stimDelay
        sr_clk = 1'b1;
        #(8*stimDelay)
        sr_clk = 1'b0;
        #stimDelay
        sr_clk = 1'b1;
        #(8*stimDelay)
        sr_clk = 1'b0;
        #stimDelay
        sr_clk = 1'b1;
        #(8*stimDelay)
        sr_clk = 1'b0;

        load = 1'b0;
        #(32*stimDelay)
        $stop;
        $finish;
    end

endmodule
