You are generating synthesizable Verilog-2001.  
Output ONLY one code block with NO markdown, NO prose, and nothing outside the module.  

Complete the following module declaration by filling in the implementation:

module binary_to_bcd_converter (
    input  [4:0] binary_input,  // 5-bit binary input (0-31)
    output [7:0] bcd_output     // 8-bit BCD: [7:4] = tens, [3:0] = ones
);

    // Declare regs for intermediate values
    reg [3:0] tens;
    reg [3:0] ones;

    // TODO: implement logic so that:
    // tens = binary_input / 10;
    // ones = binary_input % 10;
    // bcd_output = {tens, ones};

endmodule
