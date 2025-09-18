You are generating synthesizable Verilog-2001.  
Output ONLY one code block with NO markdown fences, NO prose, and nothing outside the module.

Write a Verilog-2001 module with the following exact specification:

Module name:
binary_to_bcd_converter

Ports:
- input  [4:0] binary_input   // 5-bit binary input (0–31)
- output [7:0] bcd_output     // 8-bit BCD: [7:4] = tens, [3:0] = ones

Requirements:
- Inside the always @(*) block, compute:
  tens = binary_input / 10;
  ones = binary_input % 10;
- Concatenate tens and ones into bcd_output = {tens, ones}.
- Use regs for tens and ones, wires where appropriate.
- Ensure full coverage for 0–31 input range.
- End with `endmodule` and nothing else.
