`timescale 1ns / 1ps

module Seven_Seg_Driver(
    input clk,               // Sistem saati (Bu modülde multiplexing yapmazsak kullanýlmayabilir ama dursun)
    input [3:0] in_number,   // Keypad'den gelen 4-bitlik sayý (0-F arasý)
    output reg [6:0] seg,    // a, b, c, d, e, f, g ledleri
    output reg [3:0] an,     // Hangi basamaðýn yanacaðýný seçen uçlar
    output dp                // Nokta iþareti (Ýsteðe baðlý)
    );

    // Noktayý söndür (Basys 3'te 1 sönük, 0 yanýk demektir)
    assign dp = 1;

    // --- ANOT KONTROLÜ (Hangi Hane Yansýn?) ---
    // Basys 3'te Anotlar 0 ile aktif olur.
    // En saðdaki hane (Digit 0) AN0'dýr.
    // 4'b1110 -> En saðdaki yanar, diðerleri söner.
    always @(*) begin
        an = 4'b1110; 
    end

    // --- SEGMENT KOD ÇÖZÜCÜ (Decoder) ---
    // Giriþteki 4-bit sayýyý (0-15), 7-segment desenine çevirir.
    // UNUTMA: 0 = YANIK (ON), 1 = SÖNÜK (OFF)
    
    always @(*) begin
        case(in_number)
            //                  gfedcba
            4'h0: seg = 7'b1000000; // 0
            4'h1: seg = 7'b1111001; // 1
            4'h2: seg = 7'b0100100; // 2
            4'h3: seg = 7'b0110000; // 3
            4'h4: seg = 7'b0011001; // 4
            4'h5: seg = 7'b0010010; // 5
            4'h6: seg = 7'b0000010; // 6
            4'h7: seg = 7'b1111000; // 7
            4'h8: seg = 7'b0000000; // 8
            4'h9: seg = 7'b0010000; // 9
            4'hA: seg = 7'b0001000; // A 
            4'hB: seg = 7'b0000011; // b (Küçük b çünkü B, 8 ile karýþýr)
            4'hC: seg = 7'b1000110; // C
            4'hD: seg = 7'b0100001; // d (Küçük d çünkü D, 0 ile karýþýr)
            4'hE: seg = 7'b0000110; // E
            4'hF: seg = 7'b0001110; // F
            default: seg = 7'b1111111; // Hata veya boþ (Hepsi sönük)
        endcase
    end

endmodule