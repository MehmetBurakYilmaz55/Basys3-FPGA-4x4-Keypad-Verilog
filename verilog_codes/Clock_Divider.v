module Clock_Divider(
    input clk,
    input rst,
    output reg slow_clk
    );

    // LIMIT = 50.000.000 (Yaklaþýk 1 saniye aralýkla yanýp söner)
    localparam LIMIT = 2500000; 
    
    integer counter = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            slow_clk <= 0;
        end
        else begin
            if (counter == LIMIT - 1) begin
                slow_clk <= ~slow_clk; // 1 ise 0 yap, 0 ise 1 yap
                counter <= 0;
            end
            else begin
                counter <= counter + 1;
            end
        end
    end
endmodule