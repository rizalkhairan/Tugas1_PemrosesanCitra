## Editor Citra Digital

**Editor Citra Digital (MainApp)** adalah aplikasi berbasis MATLAB App Designer
untuk pengolahan citra. Aplikasi menyediakan transformasi intensitas, ekualisasi dan pencocokan histogram,
serta filtering untuk menghaluskan atau menajamkan citra. Pengguna dapat
melihat pratinjau hasil, menerapkan atau membatalkan perubahan, menggunakan
Undo/Redo, dan menyimpan citra hasil pengolahan.

## Dependensi

- **MATLAB** dengan App Designer. Program dikembangkan dan diuji menggunakan
  MATLAB R2026a.
- **Image Processing Toolbox**, antara lain untuk fungsi `padarray` dan
  konversi tipe data citra.
- Berkas `ImageEditorState.m`, `IntensityTransforms.m`,
  `HistogramTransforms.m`, `ImageFilters.m`, dan `restoreImageClass.m`
  berada dalam folder yang sama dengan `MainApp.mlapp`.

## How to Run

1. Buka MATLAB dan arahkan **Current Folder** ke folder proyek.
2. Buka `MainApp.mlapp` melalui App Designer, lalu klik **Run**. Alternatifnya,
   ketik `MainApp` pada **Command Window**.
3. Klik **Load Image** untuk memuat citra.
4. Pilih tab **Intensity**, **Histogram**, atau **Filtering**, lalu pilih metode
   dan atur parameternya. Untuk pencocokan histogram, muat citra referensi
   melalui **Load Reference Image**.
5. Klik **Preview** untuk melihat hasil, **Apply** untuk menerapkan perubahan,
   atau **Cancel** untuk membatalkannya. Gunakan **Undo/Redo** untuk berpindah
   antarhasil penyuntingan.
6. Klik **Save Image** untuk menyimpan hasil. Pastikan perubahan sudah
   diterapkan dengan **Apply** sebelum menyimpan.

## 
Syahrizal Bani Khairan 13523063  
Muhammad Ghifary Komara Putra 13523066  
Tugas 1 IF4073 Pemrosesan Citra Digital
