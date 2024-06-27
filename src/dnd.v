module lfsr(
    input clk,
    input reset,
    input [2:0] mod,
    output reg [3:0] lfsr, 
    output reg [3:0] random_number
    );

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            lfsr <= 4'b1010; // Initial seed value
        end else begin
            lfsr[3:1] <= lfsr[2:0];
            case(mod)
                0: lfsr[0] <= lfsr[3] ~^ lfsr[0];
                1: lfsr[0] <= lfsr[3] ~^ lfsr[1];
                2: lfsr[0] <= lfsr[1] ~^ lfsr[0];
                3: lfsr[0] <= lfsr[2] ~^ lfsr[0];
                4: lfsr[0] <= lfsr[2] ~^ lfsr[1];
                5: lfsr[0] <= lfsr[0] ~^ lfsr[1];
                6: lfsr[0] <= lfsr[3] ~^ lfsr[2];
                default: lfsr[0] <= lfsr[3] ~^ lfsr[0];
            endcase
        end
    end

    // Scale the LFSR output to a 0 to 9 range
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            random_number <= 4'b0000; // Initialize to 0
        end else begin
            random_number <= lfsr % 10; // Scale and map to 0-9
        end
    end
endmodule
