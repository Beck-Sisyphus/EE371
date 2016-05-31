`include "start_detect.v"
`include "BSC.v"
`include "BIC.v"
`include "buffer.v"
`include "SIPO.v"
`include "receive.v"

module receive_testBench ();

    // connext the two modules
    wire [7:0] data_out;
    wire enable, reset, clk, data_in, finish;

    // declare an instance of the AND module
    receive rx (data_in, reset, clk, data_out, finish);

    // Running the GUI part of simulation
    receive_Tester aTester (data_in, reset, clk, data_out, finish);

    // file for gtkwave

    initial
    begin
        $dumpfile("receive.vcd");
        $dumpvars(1, rx);
    end

endmodule

module receive_Tester (data_in, reset, clk, data_out, finish);
    input [7:0] data_out;
    input finish;
    output reg data_in, reset, clk;

    parameter stimDelay = 20;

    // generate a clock
    always #(stimDelay/2) clk = ~clk;

    initial // Response
    begin
        // $display("\t\t clk rst_n \t out \t   Time ");
        $monitor("\t %b ", data_out, finish, $time);
        clk = 'b0;
    end

    always @(posedge clk) // Stimulus
    begin
                    //reset = 'b0;
        #stimDelay    reset <= 'b1;
        #stimDelay
        reset <= 'b0;
        data_in <= 'b1;
        #stimDelay
        reset <= 'b0;
        #(14*stimDelay)
        data_in <= 'b0;
        #(16*stimDelay)
        data_in <= 'b1;
        #(16*stimDelay)
        data_in <= 'b0;
        #(16*stimDelay)
        data_in <= 'b1;
        #(16*stimDelay)
        data_in <= 'b0;
        #(16*stimDelay)
        data_in <= 'b1;
        #(16*stimDelay)
        data_in <= 'b0;
        #(16*stimDelay)
        data_in <= 'b1;
        #(16*stimDelay)
        data_in <= 'b0;
        #stimDelay
        #stimDelay
        #(32*stimDelay)
        $stop;
        $finish;
    end

endmodule
