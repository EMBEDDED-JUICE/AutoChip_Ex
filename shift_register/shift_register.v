/*
You are generating synthesizable Verilog-2001.
Output ONLY the complete Verilog-2001 code ending with endmodule.
Do not generate a testbench.
Do not include markdown fences, explanations, or prose.

Write a module with the following specification:

Module name:
top_module

Ports:

clk (input wire) → clock input

reset_n (input wire) → active-low reset

data_in (input wire) → 1-bit serial data input

shift_enable (input wire) → shift enable (active high)

data_out (output reg [7:0]) → 8-bit parallel data output

Behavior:

On the rising edge of clk or falling edge of reset_n:

If reset_n is low, clear data_out to all zeros.

Else, if shift_enable is high, shift left (data_out <= {data_out[6:0], data_in}) with data_in entering at the LSB.

Otherwise, hold the current value.

End the code with endmodule.
*/