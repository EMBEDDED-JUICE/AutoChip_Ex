/*
You are generating synthesizable Verilog-2001.

Output requirements:
- Output ONLY one code block with NO markdown fences, NO prose, and nothing outside the module.
- Use exactly the module/port names below.
- Code must compile on Icarus Verilog without warnings.

Write a single Verilog-2001 module with this exact header and ports:

module top_module (
    input  [4:0] binary_input,  // 5-bit binary input (0-31)
    output [7:0] bcd_output     // 8-bit BCD: [7:4]=tens, [3:0]=ones
);

Design requirements:
1) Inside an `always @(*)` block, compute:
   - tens (reg [3:0]) = binary_input / 10;
   - ones (reg [3:0]) = binary_input % 10;
2) Drive the output as a concatenation:
   - assign bcd_output = {tens, ones};
3) Use regs for tens and ones. Do not use SystemVerilog `logic`.
4) No initial blocks, delays, tasks, or simulation code. Pure combinational logic.
5) Cover full input range 0..31 correctly.

End the file with `endmodule` and nothing else.
*/