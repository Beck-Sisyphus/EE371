`include "BSC.v"
`include "BIC.v"
`include "buffer.v"
`include "PISO.v"
`include "transmit.sv"

module transmit_testBench ();

    // connext the two modules
    wire [7:0] data_in;
    wire enable, reset, clk, data_out, finish;

    // declare an instance of the AND module
    transmit tx (data_in, enable, reset, clk, load, data_out, finish);

    // Running the GUI part of simulation
    transmit_Tester aTester (data_in, enable, reset, clk, load, data_out, finish);

    // file for gtkwave

    initial
    begin
        $dumpfile("transmit.vcd");
        $dumpvars(1, tx);
    end

endmodule

module transmit_Tester (data_in, enable, reset, clk, load, data_out, finish);
    input data_out, finish;
    output reg [7:0] data_in;
    output reg enable, reset, clk, load;

    parameter stimDelay = 4;

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
        #stimDelay    reset <= 1'b1;
        #stimDelay
        reset <= 1'b1;
        #stimDelay
        reset <= 1'b0;
        enable <= 1'b0;
        #(10*stimDelay)
        enable <= 1'b1;
        load <= 1'b0;
        #stimDelay
        load <= 1'b1;
        data_in <= 8'b01010100;
        #(500*stimDelay)
        enable <= 1'b0;
        #(10*stimDelay)
        load <= 1'b0;
        #(4*stimDelay)
        load <= 1'b1;
        enable <= 1'b1;
        #stimDelay
        data_in <= 8'b00110100;
        #(500*stimDelay)
        load <= 1'b0;
        enable <= 1'b0;
        $stop;
        $finish;
    end

endmodule
