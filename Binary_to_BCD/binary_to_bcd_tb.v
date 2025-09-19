
`timescale 1ns / 1ps

module tb;

reg [4:0] binary_input;
wire [7:0] bcd_output;

// DUT instantiation: module = top_module, instance = dut
top_module dut (
    .binary_input(binary_input),
    .bcd_output(bcd_output)
);

integer i;
reg [4:0] test_binary;
reg [7:0] expected_bcd;

integer errors;
integer samples;

// Optional VCD dump clock
reg vcd_clk;

initial begin
    errors  = 0;
    samples = 0;
    vcd_clk = 1'b0;

    $dumpfile("binary_to_bcd_tb.vcd");
    $dumpvars(0, tb);

    $display("Testing Binary-to-BCD Converter...");

    for (i = 0; i < 32; i = i + 1) begin
        test_binary  = i[4:0];
        binary_input = test_binary;

        // Expected BCD
        expected_bcd[3:0] = test_binary % 10;
        expected_bcd[7:4] = test_binary / 10;

        #10;  // allow combinational settle
        samples = samples + 1;

        if (bcd_output !== expected_bcd) begin
            $display("Error: Input=%0d Expected=8'b%0b Got=8'b%0b",
                     test_binary, expected_bcd, bcd_output);
            errors = errors + 1;
        end
    end

    if (errors == 0)
        $display("All test cases passed!");

    // Final summary
    $display("Hint: Total mismatched samples is %0d out of %0d samples", errors, samples);
    $display("Simulation finished at %0t ps", $time);
    $display("Mismatches: %0d in %0d samples", errors, samples);

    $finish;
end

// Simple free-running clock for VCD timeline (not used by DUT)
always #5 vcd_clk = ~vcd_clk;

endmodule
