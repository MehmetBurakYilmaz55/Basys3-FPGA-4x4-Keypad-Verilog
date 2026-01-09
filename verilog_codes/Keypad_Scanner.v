`timescale 1ns / 1ps

module Keypad_Scanner(
    input clk,              // Yavaþ saat (Clock Divider'dan)
    input rst,              // RESET EKLENDÝ (Ekraný temizlemek için þart!)
    input [3:0] col,        // Sütunlar
    output reg [3:0] row,   // Satýrlar
    output reg [3:0] key_out // Çýkýþ artýk hafýzalý
    );

    reg [1:0] scan_timer;

    // --- 1. ADIM: TARAMA (Aynen Koruyoruz) ---
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            scan_timer <= 0;
            row <= 4'b0000;
        end
        else begin
            // Tuþ basýlý deðilse (0000) gezmeye devam et
            // Basýlýysa (else) olduðun yerde kal (Freeze)
            if (col == 4'b0000) begin
                scan_timer <= scan_timer + 1;
            end
            
            case(scan_timer)
                2'b00: row <= 4'b0001; 
                2'b01: row <= 4'b0010; 
                2'b10: row <= 4'b0100; 
                2'b11: row <= 4'b1000; 
            endcase
        end
    end

    // --- 2. ADIM: TUÞ OKUMA VE HAFIZAYA ALMA ---
    // Burayý "always @(*)" yerine "always @(posedge clk)" yaptýk.
    // Yani artýk anlýk deðil, saat vuruþuyla kaydedilen bir hafýza oldu.
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            key_out <= 0; // Reset gelince hafýzayý sil
        end
        else begin
            // SADECE TUÞA BASILDIYSA DEÐERÝ GÜNCELLE!
            // Eðer col == 0 ise, buraya girmez ve key_out ESKÝ DEÐERÝNÝ KORUR.
            
            if (col != 4'b0000) begin
                case (row)
                    4'b0001: begin 
                        if (col[0]) key_out <= 4'h1; 
                        if (col[1]) key_out <= 4'h2; 
                        if (col[2]) key_out <= 4'h3; 
                        if (col[3]) key_out <= 4'hA; 
                    end
                    4'b0010: begin 
                        if (col[0]) key_out <= 4'h4; 
                        if (col[1]) key_out <= 4'h5; 
                        if (col[2]) key_out <= 4'h6; 
                        if (col[3]) key_out <= 4'hB; 
                    end
                    4'b0100: begin 
                        if (col[0]) key_out <= 4'h7; 
                        if (col[1]) key_out <= 4'h8; 
                        if (col[2]) key_out <= 4'h9; 
                        if (col[3]) key_out <= 4'hC; 
                    end
                    4'b1000: begin 
                        if (col[0]) key_out <= 4'hE; 
                        if (col[1]) key_out <= 4'h0; 
                        if (col[2]) key_out <= 4'hF; 
                        if (col[3]) key_out <= 4'hD; 
                    end
                endcase
            end
        end
    end

endmodule