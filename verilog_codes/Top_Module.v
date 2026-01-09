`timescale 1ns / 1ps

module Top_Module(
    input clk,              // 100 MHz Sistem Saati
    input rst,              // Reset Butonu (btnC) - Ekraný temizlemek için þart!
    input [3:0] col,        // Keypad Sütunlarý (PMOD'dan gelir)
    output [3:0] row,       // Keypad Satýrlarý (PMOD'a gider)
    output [6:0] seg,       // 7-Segment Segmentler
    output [3:0] an,        // 7-Segment Anotlar
    output dp               // Nokta
    );

    // --- ÝÇ KABLOLAR (Wires) ---
    wire w_slow_clk;        // Clock Divider'dan çýkan yavaþ saat
    wire [3:0] w_key_data;  // Scanner'dan okunan HAFIZALI tuþ verisi

    // 1. Modül: Saat Bölücü
    // Scanner'ýn hýzýný belirler (2.5 Milyon / 20Hz civarý idealdir)
    Clock_Divider Divider_Unit (
        .clk(clk),
        .rst(rst),
        .slow_clk(w_slow_clk)
    );

    // 2. Modül: Keypad Tarayýcý (Yeni Resetli ve Hafýzalý Versiyon)
    // Debouncer olmadýðý için doðrudan bu modülden çýkan veriyi kullanacaðýz.
    Keypad_Scanner Scanner_Unit (
        .clk(w_slow_clk),   // Yavaþ saat
        .rst(rst),          // YENÝ: Hafýzayý silmek için reset lazým
        .col(col),          // Giriþ
        .row(row),          // Çýkýþ
        .key_out(w_key_data) // Tuþ verisi (Basýlmadýðýnda son deðeri korur)
    );

    // 3. Modül: Ekran Sürücü
    // Arada Debouncer YOK. Scanner çýkýþý direkt buraya giriyor.
    Seven_Seg_Driver Display_Unit (
        .clk(clk),           // 100 MHz (Kombinasyonel olduðu için fark etmez)
        .in_number(w_key_data), // DÝKKAT: Direkt w_key_data baðlandý
        .seg(seg),
        .an(an),
        .dp(dp)
    );

endmodule