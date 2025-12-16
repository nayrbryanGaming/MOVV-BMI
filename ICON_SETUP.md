# 📱 MOVV BMI - Cara Ganti App Icon

## ✅ File Konfigurasi Sudah Disiapkan

Semua file konfigurasi untuk mengganti icon aplikasi sudah disiapkan:

1. ✅ `pubspec.yaml` - Sudah dikonfigurasi
2. ✅ `flutter_launcher_icons.yaml` - File konfigurasi khusus
3. ✅ `generate_icons.bat` - Script otomatis untuk Windows
4. ✅ `assets/images/logo.png` - Logo MOVV (pastikan file ini ada)

## 🚀 Cara Generate App Icon (3 Metode)

### **Metode 1: Menggunakan Script Otomatis (PALING MUDAH)**

1. Double-click file: `generate_icons.bat`
2. Tunggu sampai selesai
3. Done! Icon sudah terganti

---

### **Metode 2: Menggunakan Terminal Android Studio**

Buka Terminal di Android Studio, lalu jalankan:

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

---

### **Metode 3: Manual via Command Prompt**

1. Buka Command Prompt (cmd)
2. Masuk ke folder project:
   ```
   cd "E:\0flutter androidstudio\MOVV_BMI"
   ```
3. Jalankan perintah:
   ```
   flutter pub get
   flutter pub run flutter_launcher_icons
   ```

---

## 📋 Verifikasi Icon Sudah Terganti

Setelah generate icon, cek folder-folder ini:

### Android Icon:
- `android/app/src/main/res/mipmap-hdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-mdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xhdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png`
- `android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png`

### iOS Icon (jika build iOS):
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

---

## 🏃 Test Icon Baru

Setelah generate icon, rebuild aplikasi:

```bash
flutter clean
flutter run
```

Atau di Android Studio:
1. **Build > Clean Project**
2. **Run > Run 'main.dart'**

---

## 🎨 Konfigurasi Icon Saat Ini

- **Logo Path**: `assets/images/logo.png`
- **Background Color**: `#0B0F14` (MOVV dark background)
- **Platform**: Android & iOS
- **Adaptive Icon**: ✅ Ya (Android 8.0+)

---

## ⚠️ Troubleshooting

### Jika icon tidak berubah setelah generate:

1. **Uninstall app dari HP/Emulator**
   ```bash
   flutter clean
   ```

2. **Rebuild app**
   ```bash
   flutter run
   ```

### Jika dapat error "flutter command not found":

- Pastikan Flutter sudah terinstall
- Cek PATH environment variable sudah terisi Flutter SDK
- Atau jalankan dari Android Studio Terminal (bukan Command Prompt Windows)

---

## 📦 Output yang Dihasilkan

Setelah menjalankan `flutter pub run flutter_launcher_icons`, akan muncul output seperti ini:

```
✓ Creating icons for android
✓ Creating icons for ios
✓ Successfully generated launcher icons
```

Semua icon di folder `android/app/src/main/res/mipmap-*` akan otomatis diganti dengan logo MOVV.

---

## 🎯 Summary

- ✅ `pubspec.yaml` sudah dikonfigurasi
- ✅ `flutter_launcher_icons.yaml` sudah dibuat
- ✅ Script `generate_icons.bat` siap dijalankan
- ✅ Assets `logo.png` sudah disiapkan

**Langkah terakhir: Jalankan `generate_icons.bat` atau command di atas!**

---

Generated: December 2025
Project: MOVV BMI - Kelompok 2

