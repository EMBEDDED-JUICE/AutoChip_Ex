// Design renamed to top_module (I/O unchanged)
module top_module (
    input  wire        clk,           // Clock input
    input  wire        rst_n,         // Active-low reset
    input  wire [1:0]  die_select,    // 00=4-sided, 01=6-sided, 10=8-sided, 11=20-sided
    input  wire        roll,          // Roll trigger (high to roll)
    output reg  [7:0]  rolled_number  // Rolled number (1..20)
);

    // 8-bit LFSR for pseudo-random generation
    reg [7:0] lfsr;

    // Rising-edge detect for 'roll'
    reg roll_prev;
    wire roll_rising_edge = roll & ~roll_prev;

    // LFSR feedback polynomial taps (as provided): x^8 + x^7 + x^6 + x^5 + 1
    wire feedback = lfsr[7] ^ lfsr[6] ^ lfsr[5] ^ lfsr[4];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lfsr          <= 8'h01;    // Non-zero seed
            rolled_number <= 8'h00;
            roll_prev     <= 1'b0;
        end else begin
            // Track previous roll level
            roll_prev <= roll;

            // Free-run the LFSR
            lfsr <= {lfsr[6:0], feedback};

            // Latch new roll result on roll rising edge
            if (roll_rising_edge) begin
                case (die_select)
                    2'b00: rolled_number <= (lfsr % 8'd4)  + 8'd1;   // 1..4
                    2'b01: rolled_number <= (lfsr % 8'd6)  + 8'd1;   // 1..6
                    2'b10: rolled_number <= (lfsr % 8'd8)  + 8'd1;   // 1..8
                    2'b11: rolled_number <= (lfsr % 8'd20) + 8'd1;   // 1..20
                    default: rolled_number <= 8'h00;
                endcase
            end
        end
    end
endmodule
