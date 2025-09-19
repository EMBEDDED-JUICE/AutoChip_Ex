`timescale 1ns / 1ps

module tb;

reg [4:0] binary_input;
wire [7:0] bcd_output;

// DUT instantiation: module = top_module, instance = top_module1
top_module top_module1 (
    .binary_input(binary_input),
    .bcd_output(bcd_output)
);

integer i;
reg [4:0] test_binary;
reg [7:0] expected_bcd;

integer errors;
integer clocks;

initial begin
    errors = 0;
    clocks = 0;

    $display("Testing Binary-to-BCD Converter...");

    for (i = 0; i < 32; i = i + 1) begin
        test_binary  = i[4:0];
        binary_input = test_binary;

        // Expected BCD
        expected_bcd[3:0] = test_binary % 10;
        expected_bcd[7:4] = test_binary / 10;

        #10;  // allow combinational settle
        clocks = clocks + 1;

        if (bcd_output !== expected_bcd) begin
            $display("Error: Test %0d failed. Expected BCD: 8'b%0b, Got: 8'b%0b",
                     test_binary, expected_bcd, bcd_output);
            errors = errors + 1;
        end
    end

    if (errors == 0)
        $display("All test cases passed!");

    $finish;
end

// Optional VCD dump
reg vcd_clk;
initial begin
    vcd_clk = 1'b0;
    $dumpfile("binary_to_bcd_tb.vcd");
    $dumpvars(0, tb);
end

always #5 vcd_clk = ~vcd_clk;

// Final summary
final begin
    $display("Hint: Total mismatched samples is %1d out of %1d samples", errors, clocks);
    $display("Simulation finished at %0d ps", $time);
    $display("Mismatches: %1d in %1d samples", errors, clocks);
end

endmodule
