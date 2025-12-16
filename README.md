# MOVV BMI

Aplikasi kalkulator BMI (Body Mass Index) modern dengan fitur lengkap untuk mengukur dan melacak indeks massa tubuh Anda.

![MOVV BMI Logo](assets/images/logo.png)

## 🎯 Fitur Utama

### Core Features
- ✅ **Kalkulator BMI** - Hitung BMI berdasarkan berat dan tinggi badan
- ✅ **Dual Input Mode** - Input manual atau mode slider yang interaktif
- ✅ **Kategori WHO** - Klasifikasi berdasarkan standar World Health Organization
  - Kurus (< 18.5)
  - Normal (18.5 - 24.9)
  - Overweight (25.0 - 29.9)
  - Obesitas (≥ 30.0)
- ✅ **Visualisasi Hasil** - Tampilan BMI dengan warna adaptif dan progress bar

### Advanced Features
- 🎯 **Target BMI Calculator** - Kalkulator berat ideal berbasis goal
- 📊 **Trend Tracking** - Pantau perubahan BMI dari waktu ke waktu
- 🧠 **Explainable AI** - Penjelasan detail bagaimana BMI dihitung
- 💡 **Actionable Recommendations** - Rekomendasi berbasis kategori BMI
- 📋 **Copy to Clipboard** - Salin hasil BMI dengan mudah
- 💾 **Persistent Storage** - Simpan riwayat BMI terakhir

### Academic Features
- 📌 **WHO Reference** - Menggunakan standar WHO yang tervalidasi
- ⚠️ **Limitation Awareness** - Informasi keterbatasan BMI sebagai indikator
- 🔍 **Goal-Based Calculator** - Reverse calculator untuk target berat ideal

## 🎨 Design

Aplikasi ini menggunakan tema warna MOVV yang modern dan konsisten:
- **Primary Green**: #79C143
- **Primary Blue**: #1E88C9
- **Background Dark**: #0B0F14
- **Card Dark**: #121A24
- **Border**: #223043
- **Text**: #EAF2FF

### UI/UX Highlights
- 🌙 **Dark Mode** - Desain elegan dengan dark theme
- 📱 **Responsive** - Layout yang menyesuaikan berbagai ukuran layar
- 🎭 **Material 3** - Mengikuti design guideline terbaru
- 🎨 **Adaptive Colors** - Warna yang menyesuaikan kategori BMI
- ⚡ **Smooth Animations** - Interaksi yang fluid dan responsive

## 📱 Screenshots

*Coming soon*

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.x or higher)
- Dart SDK (3.x or higher)
- Android Studio / VS Code
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

### Installation

1. Clone repository ini:
```bash
git clone https://github.com/nayrbryanGaming/MOVV-BMI.git
cd MOVV-BMI
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate app icons (optional, sudah ter-generate):
```bash
flutter pub run flutter_launcher_icons
```

4. Run aplikasi:
```bash
flutter run
```

## 🏗️ Project Structure

```
lib/
  └── main.dart          # Main application file (all features)
assets/
  └── images/
      └── logo.png       # MOVV logo (app icon source)
android/                 # Android platform files
ios/                     # iOS platform files
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.0.15

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  flutter_launcher_icons: ^0.13.1
```

## 🔧 Configuration

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

## 🧪 Testing

### Manual Testing Checklist
- [ ] Input manual berat & tinggi
- [ ] Mode slider berat & tinggi
- [ ] Validasi input (1-300 kg, 50-250 cm)
- [ ] Perhitungan BMI
- [ ] Kategori WHO
- [ ] Warna adaptif
- [ ] Target berat ideal
- [ ] Copy to clipboard
- [ ] Riwayat terakhir
- [ ] Trend BMI
- [ ] Penjelasan & rekomendasi
- [ ] Goal-based calculator
- [ ] Info dialog

### Unit Tests
*Coming soon*

## 🎓 Academic Approach

MOVV BMI didesain dengan pendekatan akademik dan product thinking:

### Decision Support
Bukan hanya kalkulator, tapi **decision engine** yang memberikan rekomendasi actionable.

### Explainable AI (XAI)
Sistem memberikan penjelasan transparan bagaimana BMI dihitung dan apa makna hasilnya.

### Risk Awareness
Aplikasi mencantumkan keterbatasan BMI - menunjukkan mature engineering thinking.

### Goal-Oriented UX
Reverse calculator memungkinkan user melihat berat target untuk BMI yang diinginkan.

## 🏆 Features Comparison

| Feature | Basic BMI App | MOVV BMI |
|---------|---------------|----------|
| BMI Calculator | ✅ | ✅ |
| WHO Standard | ❌ | ✅ |
| Slider Input | ❌ | ✅ |
| Trend Tracking | ❌ | ✅ |
| Explainable Results | ❌ | ✅ |
| Goal-Based Calculator | ❌ | ✅ |
| Limitation Awareness | ❌ | ✅ |
| Actionable Recommendations | ❌ | ✅ |
| Persistence | ❌ | ✅ |
| Modern UI | ❌ | ✅ |

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Team

**Kelompok 2**
- Project: MOVV BMI
- Year: 2024

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 📞 Support

For support, email: [your-email@example.com]

## 🌟 Acknowledgments

- WHO (World Health Organization) untuk standar kategori BMI
- Flutter team untuk framework yang amazing
- Material Design untuk design guidelines

---

**Made with ❤️ by Kelompok 2**

**MOVV**: Measure • Improve • Move

