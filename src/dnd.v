module lfsr (
    input wire clk,
    input wire reset,
    output reg [4:0] random_number // 5-bit output for the random number (1 to 20)
);
    reg [4:0] lfsr;
    wire feedback;

    // Define the feedback polynomial x^5 + x^3 + 1
    assign feedback = lfsr[4] ^ lfsr[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr <= 5'b1; // LFSR should never be zero
        end else begin
            lfsr <= {lfsr[3:0], feedback}; // Shift left and insert feedback
        end
    end

    // Generate a random number between 1 and 20
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            random_number <= 5'd1; // Initial value
        end else begin
            random_number <= (lfsr % 20) + 1; // Random number between 1 and 20
        end
    end
endmodule
