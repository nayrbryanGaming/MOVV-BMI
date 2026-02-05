# MOVV BMI - Body Mass Index Calculator

**Aplikasi BMI profesional dengan standar WHO yang dirancang untuk memberikan insight kesehatan yang akurat dan actionable.**

Aplikasi kalkulator BMI (Body Mass Index) berbasis World Health Organization dengan fitur lengkap untuk mengukur, melacak, dan memahami indeks massa tubuh Anda secara mendalam. Dilengkapi dengan penjelasan transparan, rekomendasi berbasis data, dan reverse calculator untuk mencapai target berat ideal.

*Last Updated: 5 Februari 2026*

![MOVV BMI Logo](assets/images/logo.png)

---

## Fitur Utama

### Core Features
- [v] **Kalkulator BMI Akurat** - Hitung BMI berdasarkan berat dan tinggi badan dengan presisi tinggi
- [v] **Dual Input Mode** - Input manual numerik atau mode slider interaktif untuk kemudahan penggunaan
- [v] **Standar WHO Tervalidasi** - Klasifikasi berbasis World Health Organization yang terpercaya
  - Kurus (< 18.5)
  - Normal (18.5 - 24.9)
  - Overweight (25.0 - 29.9)
  - Obesitas (≥ 30.0)
- [v] **Visualisasi Hasil Dinamis** - Tampilan BMI dengan warna adaptif dan progress bar visual

### Advanced Features
- **Target BMI Calculator** - Hitung berat ideal yang diperlukan untuk mencapai BMI target
- **Trend Tracking** - Monitor perubahan BMI dari waktu ke waktu dengan riwayat terukur
- **Explainable AI (XAI)** - Penjelasan detail dan transparan bagaimana BMI dihitung
- **Actionable Recommendations** - Rekomendasi kesehatan berbasis kategori BMI Anda
- **Copy to Clipboard** - Salin hasil BMI dengan mudah untuk dibagikan
- **Persistent Storage** - Simpan riwayat BMI secara otomatis di perangkat

### Academic Features
- **WHO Reference** - Menggunakan standar WHO yang telah divalidasi secara internasional
- **Limitation Awareness** - Informasi keterbatasan BMI sebagai indikator kesehatan
- **Goal-Based Calculator** - Reverse calculator untuk perencanaan target berat ideal

---

## Design & User Experience

Aplikasi ini menggunakan tema warna MOVV yang modern, konsisten, dan user-friendly:

### Color Palette
- **Primary Green**: #79C143 (Kesehatan & Vitalitas)
- **Primary Blue**: #1E88C9 (Kepercayaan & Profesionalisme)
- **Background Dark**: #0B0F14 (Mengurangi eye strain)
- **Card Dark**: #121A24 (Kontras optimal)
- **Border**: #223043 (Visual hierarchy)
- **Text**: #EAF2FF (Legibilitas tinggi)

### UI/UX Principles
- **Dark Mode Optimized** - Desain elegan dengan dark theme yang nyaman untuk penggunaan jangka panjang
- **Responsive Design** - Layout yang menyesuaikan sempurna di berbagai ukuran layar dan orientasi
- **Material Design 3** - Mengikuti design guideline Google Material terbaru untuk konsistensi
- **Adaptive Color System** - Warna berubah dinamis sesuai kategori BMI untuk feedback visual yang jelas
- **Smooth Animations** - Interaksi yang fluid dan responsive untuk user experience premium

## Screenshots

Coming soon

## Getting Started

### Prerequisites
Sebelum memulai, pastikan Anda memiliki:
- **Flutter SDK** 3.x atau lebih tinggi
- **Dart SDK** 3.x atau lebih tinggi (included dengan Flutter)
- **Android Studio** atau **VS Code** dengan Flutter extension
- **Android SDK** untuk development Android
- **Xcode** untuk development iOS (macOS only)

### Installation

1. Clone repository:
```bash
git clone https://github.com/nayrbryanGaming/MOVV-BMI.git
cd MOVV-BMI
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run aplikasi:
```bash
flutter run
```

4. Build for release (optional):
```bash
# Android
flutter build appbundle --release

# iOS
flutter build ipa --release
```

## Project Structure

```
lib/
  └── main.dart          # Main application file (all features)
assets/
  └── images/
      └── logo.png       # MOVV logo (app icon source)
android/                 # Android platform files
ios/                     # iOS platform files
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8        # iOS style icons
  shared_preferences: ^2.0.15    # Local device storage

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  flutter_launcher_icons: ^0.13.1
```

### Dependency Details
- **shared_preferences**: Menyimpan riwayat BMI dan preferensi user di device storage secara aman
- **flutter_launcher_icons**: Generate app icons untuk berbagai resolusi dan platform

## Configuration

### App Icon
Icon aplikasi menggunakan logo MOVV dari `assets/images/logo.png`.

Untuk regenerate icon:
```bash
flutter pub run flutter_launcher_icons
```

### SharedPreferences
Aplikasi menggunakan `shared_preferences` untuk menyimpan:
- Hasil BMI terakhir
- BMI sebelumnya (untuk trend tracking)

## Testing

Semua fitur telah diuji secara menyeluruh untuk memastikan stabilitas dan akurasi:

### Manual Testing Checklist
- [v] Input manual berat & tinggi dengan validasi
- [v] Mode slider interaktif untuk berat & tinggi
- [v] Validasi input boundary (1-300 kg, 50-250 cm)
- [v] Perhitungan BMI dengan presisi akurat
- [v] Kategori WHO sesuai standar internasional
- [v] Warna adaptif berdasarkan kategori
- [v] Target berat ideal calculation
- [v] Copy to clipboard functionality
- [v] Riwayat BMI terakhir tersimpan
- [v] Trend BMI tracking dari waktu ke waktu
- [v] Penjelasan & rekomendasi berbasis data
- [v] Goal-based calculator reverse logic
- [v] Info dialog dan penjelasan lengkap

### Unit Tests
Coming soon

### Platform Compatibility
- [v] Android 5.0+ (API level 21 dan lebih tinggi)
- [v] iOS 11.0+
- [v] Web platform

## Academic Approach

MOVV BMI didesain dengan pendekatan akademik dan product thinking:

### Decision Support
Bukan hanya kalkulator, tapi decision engine yang memberikan rekomendasi actionable.

### Explainable AI (XAI)
Sistem memberikan penjelasan transparan bagaimana BMI dihitung dan apa makna hasilnya.

### Risk Awareness
Aplikasi mencantumkan keterbatasan BMI - menunjukkan mature engineering thinking.

### Goal-Oriented UX
Reverse calculator memungkinkan user melihat berat target untuk BMI yang diinginkan.

## Features Comparison

| Feature | Basic BMI App | MOVV BMI |
|---------|---------------|----------|
| BMI Calculator | [v] | [v] |
| WHO Standard | [x] | [v] |
| Slider Input | [x] | [v] |
| Trend Tracking | [x] | [v] |
| Explainable Results | [x] | [v] |
| Goal-Based Calculator | [x] | [v] |
| Limitation Awareness | [x] | [v] |
| Actionable Recommendations | [x] | [v] |
| Persistence | [x] | [v] |
| Modern UI | [x] | [v] |

## License

This project is licensed under the MIT License. All rights reserved.

See the [LICENSE](LICENSE) file for more details.

---
- Solo Developer - MOVV BMI Application
- Flutter & Dart Expert
- GitHub: https://github.com/nayrbryanGaming
- Email: nayrbryanGaming01@gmail.com
- Year: 2024-2026

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to open an issue or submit a pull request.

## Support

Untuk dukungan teknis, pertanyaan, atau saran:
- Email: nayrbryanGaming01@gmail.com
- GitHub Issues: https://github.com/nayrbryanGaming/MOVV-BMI/issues

## Acknowledgments

- WHO (World Health Organization) - untuk standar kategori BMI yang digunakan
- Flutter Team - untuk framework dan tools yang luar biasa
- Material Design - untuk design guidelines yang komprehensif

---

**Made with care by nayrbryanGaming**

**MOVV: Measure → Improve → Move**

*MOVV BMI adalah komitmen untuk memberikan tool kesehatan yang akurat, transparan, dan user-friendly bagi semua orang.*

