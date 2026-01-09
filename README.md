# FPGA Tabanlı 4x4 Matris Keypad Sürücüsü ve Özel PCB Tasarımı (Basys 3)
### 🇬🇧 FPGA Based 4x4 Matrix Keypad Driver & Custom PCB Design

![University](https://img.shields.io/badge/Kocaeli%20University-EHM-green)
![Hardware](https://img.shields.io/badge/Hardware-Basys3%20%7C%20KiCad-orange)
![Language](https://img.shields.io/badge/Language-Verilog-blue)

---

## 🇹🇷 Proje Hakkında (Turkish)

Bu proje, **Kocaeli Üniversitesi** Elektronik ve Haberleşme Mühendisliği bölümü kapsamında; Digilent Basys 3 FPGA kartı için geliştirilmiş bir 4x4 Matris Keypad sürücüsü ve donanım tasarımını içerir.

Projenin en özgün yanı, standart "Debouncer" modülleri kullanmak yerine, mekanik gürültüleri (bouncing) donanımsal mantıkla çözen **"Freeze & Latch" (Dondur ve Kilitle)** algoritmasının kullanılmasıdır.

### 🚀 Öne Çıkan Özellikler
* **Freeze (Dondurma) Algoritması:** Tarama sırasında herhangi bir sütundan sinyal (`col != 0`) algılandığı anda tarayıcı sayaç dondurulur. Bu sayede tuş basılı olduğu sürece tarama satır değiştiremez ve kararlı bir okuma sağlanır.
* **Özgün PCB Tasarımı:** Keypad donanımı sıfırdan tasarlanmış ve üretilmiştir.
* **Üretime Özel Kılıflar (BenimKutuphanem):** standart kütüphanedeki kılıflar (footprints) alınmış ve ped yüzeyleri manuel olarak genişletilmiştir. Bu sayede lehimleme kolaylığı sağlanmıştır.
  
### 🛠️ PCB Tasarımı ve "BenimKutuphanem" Detayı
Baskı devre kartı (PCB) tasarımı **KiCad** kullanılarak yapılmıştır. Standart kütüphanedeki direnç (1206) ve buton kılıflarının pedleri, asit indirme işleminde erimemesi ve lehimlemenin kolay olması için manuel olarak büyütülmüştür.

Bu özelleştirilmiş kılıflar, projenin `pcb_design/BenimKutuphanem.pretty` klasörü altında toplanmıştır.

### 📂 Klasör Yapısı
* `verilog_codes/` -> Verilog kaynak kodları (`Top_Module`, `Scanner`, `SevenSeg` vb.).
* `pcb_design/` -> KiCad proje dosyaları, şematik, PCB çizimi ve **BenimKutuphanem** klasörü.
* `docs/` -> Devre şeması (PDF), proje raporu ve görseller.

---

## 🇬🇧 Project Description (English)

This repository contains the full **Verilog source code** and **custom PCB design** files for a 4x4 Matrix Keypad project implemented on the Digilent Basys 3 FPGA board, developed at **Kocaeli University**.

The project features a custom-developed **"Freeze & Latch" scanning algorithm** that eliminates the need for traditional debouncer modules by locking the state upon signal detection.

### 🚀 Key Features
* **Freeze Logic:** Unlike standard scanning, the counter instantly stops (freezes) when a column signal is detected. This prevents the scanner from jumping to the next row during micro-second contact bounces, ensuring a stable output.
* **Custom PCB Design:** The hardware is designed from scratch using **KiCad**.
* **DIY-Friendly Footprints:** To facilitate "Toner Transfer" etching and hand-soldering, standard component footprints were modified with significantly **larger pads**.

### 🛠️ PCB Design & Custom Library
Since the board was manufactured using DIY methods, standard library footprints were too small and risky for hand soldering.
* We created a custom library named **"BenimKutuphanem"** (MyLibrary).
* This library includes modified footprints for resistors and tactile switches with enlarged pads to prevent pad lifting during etching.
* The custom library files can be found in `pcb_design/libraries/BenimKutuphanem`.

### ⚙️ Pinout (Pmod Header JB)
| FPGA Pin | Keypad Pin | Direction |
|----------|------------|-----------|
| JB1    | COL 1      | Input     |
| JB2    | COL 2      | Input     |
| JB3    | COL 3      | Input     |
| JB4    | COL 4      | Input     |
| JB7    | ROW 1      | Output    |
| JB8    | ROW 2      | Output    |
| JB9    | ROW 3      | Output    |
| JB10   | ROW 4      | Output    |

---

## 👥 Authors & Acknowledgments / Yazar ve Teşekkür

**Project Team / Proje Ekibi:**
* **Mehmet Burak YILMAZ** - *FPGA Design & Verification & PCB Design*

## 📄 License
This project is open-source and available for educational purposes.
