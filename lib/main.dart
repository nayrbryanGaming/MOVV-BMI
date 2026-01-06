import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// MOVV color palette
const Color kGreen = Color(0xFF79C143);
const Color kBlue = Color(0xFF1E88C9);
const Color kBackground = Color(0xFF0B0F14);
const Color kCard = Color(0xFF121A24);
const Color kBorder = Color(0xFF223043);
const Color kText = Color(0xFFEAF2FF);

void main() {
  runApp(const MovvBmiApp());
}

class MovvBmiApp extends StatelessWidget {
  const MovvBmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOVV BMI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: kBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: kText,
          elevation: 0,
        ),
        cardColor: kCard,
        colorScheme: const ColorScheme.dark(
          primary: kGreen,
          secondary: kBlue,
          surface: kCard,
          onPrimary: kText,
          onSecondary: kText,
          onSurface: kText,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: kText, fontSize: 20, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: kText),
        ),
      ),
      home: const MovvBmiHome(),
    );
  }
}

class MovvBmiHome extends StatefulWidget {
  const MovvBmiHome({super.key});

  @override
  State<MovvBmiHome> createState() => _MovvBmiHomeState();
}

class _MovvBmiHomeState extends State<MovvBmiHome> {
  String? _lastResult;

  final TextEditingController beratCtrl = TextEditingController();
  final TextEditingController tinggiCtrl = TextEditingController();

  double? bmi;
  String kategori = '-';
  // Slider mode state
  bool _sliderMode = false;
  double _sliderBerat = 70.0;
  double _sliderTinggi = 170.0;
  // Explainability & advanced features
  bool _showExplanation = false;
  double? _previousBmi;

  @override
  void dispose() {
    beratCtrl.dispose();
    tinggiCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadLastResult();
    // initialize controllers from slider defaults
    beratCtrl.text = _sliderBerat.toStringAsFixed(1);
    tinggiCtrl.text = _sliderTinggi.toStringAsFixed(1);
  }

  Future<void> _loadLastResult() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastResult = prefs.getString('last_result');
      final prev = prefs.getDouble('previous_bmi');
      if (prev != null) _previousBmi = prev;
    });
  }

  Future<void> _saveLastResult(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_result', value);
    // save previous BMI for trend
    if (_previousBmi == null && bmi != null) {
      await prefs.setDouble('previous_bmi', bmi!);
    } else if (bmi != null && _previousBmi != bmi) {
      _previousBmi = await prefs.getDouble('previous_bmi');
      await prefs.setDouble('previous_bmi', bmi!);
    }
    setState(() {
      _lastResult = value;
    });
  }

  // Fungsi perhitungan BMI
  double hitungBMI({required double beratKg, required double tinggiCm}) {
    final tinggiM = tinggiCm / 100.0;
    return beratKg / (tinggiM * tinggiM);
  }

  // Fungsi menentukan kategori
  String kategoriBMI(double bmi) {
    if (bmi < 18.5) return 'Kurus';
    if (bmi < 25.0) return 'Normal';
    if (bmi < 30.0) return 'Overweight';
    return 'Obesitas';
  }

  // Warna badge kategori
  Color warnaKategori(String kat) {
    switch (kat) {
      case 'Kurus':
        return kBlue;
      case 'Normal':
        return kGreen;
      case 'Overweight':
        return const Color(0xFFFFC107);
      case 'Obesitas':
        return const Color(0xFFFF5252);
      default:
        return kText;
    }
  }

  // Validasi input
  bool inputValid(double berat, double tinggi) {
    return berat >= 1 && berat <= 300 && tinggi >= 50 && tinggi <= 250;
  }

  // --- NEW: Sub-label for Normal category (educational, not WHO standard)
  String subLabelNormal(double bmi) {
    if (bmi < 18.5 || bmi >= 25.0) return '';
    if (bmi >= 18.5 && bmi < 21.0) return 'Bawah';
    if (bmi >= 21.0 && bmi < 24.0) return 'Tengah';
    if (bmi >= 24.0 && bmi < 25.0) return 'Atas';
    return '';
  }

  // --- NEW: Tips for each category (3 points, no emoji)
  List<String> tipsForKategori(String kat) {
    switch (kat) {
      case 'Kurus':
        return [
          'Tingkatkan asupan kalori dengan makanan bergizi.',
          'Konsumsi protein cukup untuk membangun massa otot.',
          'Konsultasi ahli gizi jika kesulitan menaikkan berat.',
        ];
      case 'Normal':
        return [
          'Pertahankan pola makan seimbang.',
          'Rutin berolahraga minimal 150 menit per minggu.',
          'Cek BMI secara berkala untuk monitoring.',
        ];
      case 'Overweight':
        return [
          'Kurangi konsumsi makanan tinggi gula dan lemak jenuh.',
          'Tingkatkan aktivitas fisik secara bertahap.',
          'Konsultasi tenaga kesehatan untuk program yang tepat.',
        ];
      case 'Obesitas':
        return [
          'Segera konsultasi dokter atau ahli gizi.',
          'Hindari diet ekstrem tanpa pengawasan medis.',
          'Mulai aktivitas fisik ringan secara rutin.',
        ];
      default:
        return [];
    }
  }

  // --- Target BMI helper: average ideal weight for 'Normal' range
  double beratIdealAvg(double tinggiCm) {
    final h = tinggiCm / 100.0;
    final minW = 18.5 * h * h;
    final maxW = 24.9 * h * h;
    return double.parse(((minW + maxW) / 2).toStringAsFixed(1));
  }

  // --- Smart status message based on category (no emoji)
  String statusForKategori(String kat) {
    switch (kat) {
      case 'Normal':
        return 'Kondisi kamu aman, pertahankan.';
      case 'Kurus':
        return 'Perlu asupan tambahan.';
      case 'Overweight':
        return 'Perlu kontrol pola makan.';
      case 'Obesitas':
        return 'Disarankan konsultasi tenaga kesehatan.';
      default:
        return '';
    }
  }

  // --- Copy result to clipboard
  void _copyResult() {
    final b = bmi?.toStringAsFixed(1) ?? '--';
    final beratText = beratCtrl.text.trim().isEmpty ? '-' : beratCtrl.text.trim();
    final tinggiText = tinggiCtrl.text.trim().isEmpty ? '-' : tinggiCtrl.text.trim();
    final text = 'BMI saya: $b ($kategori) Tinggi: ${tinggiText} cm Berat: ${beratText} kg';
    Clipboard.setData(ClipboardData(text: text));
    _showSnack('Hasil disalin ke clipboard.');
  }

  // --- Actionable recommendation based on category (no emoji)
  String rekomendasiAksi(String kat) {
    switch (kat) {
      case 'Kurus':
        return 'Fokus naik berat 3-5 kg dengan asupan seimbang.';
      case 'Normal':
        return 'Pertahankan kondisi dengan gaya hidup sehat.';
      case 'Overweight':
        return 'Disarankan defisit kalori ringan dan olahraga teratur.';
      case 'Obesitas':
        return 'Konsultasi tenaga kesehatan untuk program penurunan berat.';
      default:
        return '';
    }
  }

  // --- Explainable result (XAI sederhana)
  String explainBMI() {
    if (bmi == null) return '';
    final tinggiVal = double.tryParse(tinggiCtrl.text.trim().replaceAll(',', '.')) ?? 0;
    final beratVal = double.tryParse(beratCtrl.text.trim().replaceAll(',', '.')) ?? 0;
    return 'BMI dihitung dari perbandingan berat terhadap kuadrat tinggi. Dengan tinggi ${tinggiVal.toStringAsFixed(0)} cm dan berat ${beratVal.toStringAsFixed(0)} kg, rasio ini (${bmi!.toStringAsFixed(1)}) masuk kategori $kategori menurut standar WHO.';
  }

  // --- Goal-based reverse calculator (target BMI → berat ideal)
  String beratUntukTargetBMI(double targetBmi, double tinggiCm) {
    final h = tinggiCm / 100.0;
    final w = targetBmi * h * h;
    return w.toStringAsFixed(1);
  }

  // --- Trend indicator
  String trendIndicator() {
    if (_previousBmi == null || bmi == null) return '';
    final diff = bmi! - _previousBmi!;
    if (diff.abs() < 0.1) return 'Stabil';
    if (diff > 0) return 'Naik ${diff.toStringAsFixed(1)}';
    return 'Turun ${diff.abs().toStringAsFixed(1)}';
  }

  // Cache computed values to avoid recalculation in build
  String? _cachedExplanation;
  String? _cachedRecommendation;

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  void onHitung() {
    double berat; double tinggi;
    if (_sliderMode) {
      berat = _sliderBerat;
      tinggi = _sliderTinggi;
      // update controllers to reflect slider values
      beratCtrl.text = berat.toStringAsFixed(1);
      tinggiCtrl.text = tinggi.toStringAsFixed(1);
    } else {
      final rawBerat = beratCtrl.text.trim().replaceAll(',', '.');
      final rawTinggi = tinggiCtrl.text.trim().replaceAll(',', '.');
      final b = double.tryParse(rawBerat);
      final t = double.tryParse(rawTinggi);
      if (b == null || t == null) {
        _showSnack('Masukkan berat (1-300) dan tinggi (50-250) yang valid.');
        return;
      }
      berat = b; tinggi = t;
    }

    if (!inputValid(berat, tinggi)) {
      String msg = '';
      if (!(berat >= 1 && berat <= 300)) msg = 'Berat harus 1-300 kg.';
      if (!(tinggi >= 50 && tinggi <= 250)) {
        if (msg.isNotEmpty) msg += ' ';
        msg += 'Tinggi harus 50-250 cm.';
      }
      _showSnack(msg);
      return;
    }

    final hasil = hitungBMI(beratKg: berat, tinggiCm: tinggi);
    setState(() {
      bmi = double.parse(hasil.toStringAsFixed(1));
      kategori = kategoriBMI(bmi!);
      // Cache expensive string operations
      _cachedExplanation = explainBMI();
      _cachedRecommendation = rekomendasiAksi(kategori);
    });
    final last = '${bmi!.toStringAsFixed(1)}|$kategori';
    _saveLastResult(last);
  }

  void onReset() {
    beratCtrl.clear();
    tinggiCtrl.clear();
    setState(() {
      bmi = null;
      kategori = '-';
      _cachedExplanation = null;
      _cachedRecommendation = null;
    });
    _showSnack('Form di-reset.');
  }

  InputDecoration _inputDecoration(String label, IconData icon, Color accent) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: kText),
      prefixIcon: Icon(icon, color: accent),
      filled: true,
      fillColor: const Color(0xFF0E1620),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: accent, width: 1.6),
      ),
    );
  }

  Widget _inputField({required String label, required TextEditingController controller, required IconData icon, required Color accent}) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]'))],
      style: const TextStyle(color: kText),
      decoration: _inputDecoration(label, icon, accent),
    );
  }

  // --- NEW: Custom BMI Indicator with markers (scale 12-40, target 22)
  Widget _bmiIndicatorWithTarget(double? currentBmi) {
    const double minScale = 12.0;
    const double maxScale = 40.0;
    const double targetBmi = 22.0;
    const double normalMin = 18.5;
    const double normalMax = 24.9;
    const double overweightMax = 30.0;

    final double displayBmi = (currentBmi ?? 0).clamp(minScale, maxScale);
    final Color currentColor = (kategori == '-') ? kText : warnaKategori(kategori);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Indikator BMI (skala 12-40)', style: TextStyle(color: kText, fontSize: 12)),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            final double barWidth = constraints.maxWidth;
            final double range = maxScale - minScale;

            double positionFor(double value) {
              final clamped = value.clamp(minScale, maxScale);
              return ((clamped - minScale) / range) * barWidth;
            }

            final double normalStartPos = positionFor(normalMin);
            final double normalEndPos = positionFor(normalMax);
            final double currentPos = positionFor(displayBmi);
            final double targetPos = positionFor(targetBmi);

            return SizedBox(
              height: 32,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Background bar
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E1620),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  // Normal range highlight
                  Positioned(
                    left: normalStartPos,
                    top: 0,
                    bottom: 0,
                    width: normalEndPos - normalStartPos,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  // Target marker (BMI 22)
                  Positioned(
                    left: targetPos - 1,
                    top: 2,
                    bottom: 2,
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        color: kBlue,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                  // Current BMI marker
                  if (currentBmi != null)
                    Positioned(
                      left: currentPos - 1.5,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 3,
                        decoration: BoxDecoration(
                          color: currentColor,
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 6),
        // WHO boundary labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('18.5', style: TextStyle(color: kText, fontSize: 10)),
            Text('25.0', style: TextStyle(color: kText, fontSize: 10)),
            Text('30.0', style: TextStyle(color: kText, fontSize: 10)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Kurus', style: TextStyle(color: kText, fontSize: 9)),
            Text('Normal', style: TextStyle(color: kText, fontSize: 9)),
            Text('Overweight', style: TextStyle(color: kText, fontSize: 9)),
            Text('Obesitas', style: TextStyle(color: kText, fontSize: 9)),
          ],
        ),
        const SizedBox(height: 8),
        // Distance to target
        if (currentBmi != null)
          Builder(builder: (context) {
            final diff = currentBmi - targetBmi;
            final diffText = diff.abs().toStringAsFixed(1);
            final String distanceLabel;
            if (diff.abs() < 0.1) {
              distanceLabel = 'Kamu sudah di target BMI 22';
            } else if (diff > 0) {
              distanceLabel = 'Jarak ke target BMI 22: +$diffText (di atas)';
            } else {
              distanceLabel = 'Jarak ke target BMI 22: -$diffText (di bawah)';
            }
            return Text(
              distanceLabel,
              style: TextStyle(color: currentColor, fontSize: 12, fontWeight: FontWeight.w500),
            );
          }),
      ],
    );
  }

  // --- DEPRECATED: Old _bmiBar kept for reference but replaced by _bmiIndicatorWithTarget
  Widget _bmiBar(double value) {
    return _bmiIndicatorWithTarget(value == 0 ? null : value);
  }

  // --- NEW: Recommendation box with highlight
  Widget _recommendationBox(String recommendation, Color categoryColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: categoryColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: categoryColor.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REKOMENDASI UTAMA',
            style: TextStyle(
              color: categoryColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            recommendation,
            style: const TextStyle(
              color: kText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // --- NEW: Bullet list for tips
  Widget _bulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('  ', style: TextStyle(color: kText, fontSize: 13)),
              const Text('• ', style: TextStyle(color: kText, fontSize: 13)),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(color: kText, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // --- NEW: Weight range narrative
  Widget _weightRangeNarrative(double tinggiCm) {
    final minNormal = beratUntukTargetBMI(18.5, tinggiCm);
    final maxNormal = beratUntukTargetBMI(24.9, tinggiCm);
    final target22 = beratUntukTargetBMI(22.0, tinggiCm);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rentang berat Normal (WHO): $minNormal - $maxNormal kg',
          style: const TextStyle(color: kText, fontSize: 13),
        ),
        const SizedBox(height: 2),
        Text(
          'Target (BMI 22, opsional): $target22 kg',
          style: const TextStyle(color: kText, fontSize: 13),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bmiText = (bmi == null) ? '--' : bmi!.toStringAsFixed(1);
    final badgeColor = (kategori == '-') ? kBorder : warnaKategori(kategori);
    final bmiColor = (kategori == '-') ? kText : warnaKategori(kategori);
    final subLabel = (bmi != null && kategori == 'Normal') ? subLabelNormal(bmi!) : '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('MOVV BMI', style: TextStyle(color: kText, fontWeight: FontWeight.w800)),
            SizedBox(height: 2),
            Text('Measure - Improve - Move', style: TextStyle(color: kText, fontSize: 12, fontWeight: FontWeight.w400)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Tentang BMI & Keterbatasan'),
                  content: const SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Body Mass Index (BMI):', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('BMI adalah indikator massa tubuh berdasarkan perbandingan berat dan tinggi badan.'),
                        SizedBox(height: 12),
                        Text('Standar Kategori:', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Kategori mengacu pada klasifikasi BMI dewasa WHO (World Health Organization):'),
                        SizedBox(height: 4),
                        Text('  < 18.5: Kurus'),
                        Text('  18.5 - 24.9: Normal'),
                        Text('  25.0 - 29.9: Overweight'),
                        Text('  >= 30.0: Obesitas'),
                        SizedBox(height: 12),
                        Text('Keterbatasan BMI:', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('BMI tidak membedakan massa otot dan lemak.'),
                        Text('Tidak memperhitungkan distribusi lemak tubuh.'),
                        Text('Tidak cocok untuk atlet, ibu hamil, atau lansia.'),
                        SizedBox(height: 12),
                        Text('Catatan Penting:', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('BMI adalah alat skrining awal, BUKAN diagnosis medis. Konsultasi tenaga kesehatan untuk evaluasi lengkap.'),
                        SizedBox(height: 12),
                        Text('Referensi:', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('WHO - Body mass index classification for adults', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))],
                ),
              );
            },
            icon: const Icon(Icons.info_outline, color: kText),
            tooltip: 'Tentang BMI',
          ),
          IconButton(
            onPressed: () {
              final tinggiVal = double.tryParse(tinggiCtrl.text.trim().replaceAll(',', '.'));
              if (tinggiVal == null || tinggiVal < 50 || tinggiVal > 250) {
                _showSnack('Masukkan tinggi badan yang valid (50-250 cm) terlebih dahulu.');
                return;
              }
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Kalkulator Berat Ideal'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Tinggi kamu: ${tinggiVal.toStringAsFixed(0)} cm', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        const Text('Berat untuk target BMI:'),
                        const SizedBox(height: 8),
                        Text('BMI 18.5 (Batas Kurus): ${beratUntukTargetBMI(18.5, tinggiVal)} kg'),
                        Text('BMI 22 (Target rekomendasi): ${beratUntukTargetBMI(22, tinggiVal)} kg'),
                        Text('BMI 24.9 (Batas Normal): ${beratUntukTargetBMI(24.9, tinggiVal)} kg'),
                        Text('BMI 30 (Batas Obesitas): ${beratUntukTargetBMI(30, tinggiVal)} kg'),
                        const SizedBox(height: 12),
                        const Text('Target BMI 22 adalah rekomendasi umum untuk kondisi sehat optimal.', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))],
                ),
              );
            },
            icon: const Icon(Icons.calculate_outlined, color: kText),
            tooltip: 'Kalkulator Berat Ideal',
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (_lastResult != null) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Hasil terakhir: ${_lastResult!.split('|')[0]} (${_lastResult!.split('|')[1]})', style: const TextStyle(color: kText, fontSize: 12)),
                ),
                const SizedBox(height: 8),
              ],

              // INPUT CARD
              RepaintBoundary(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: badgeColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Hitung BMI kamu', style: TextStyle(color: kText, fontSize: 18, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      // Slider mode toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Mode Slider', style: TextStyle(color: kText)),
                          Switch(
                            value: _sliderMode,
                            activeColor: kGreen,
                            onChanged: (v) {
                              setState(() {
                                _sliderMode = v;
                                if (_sliderMode) {
                                  final b = double.tryParse(beratCtrl.text.replaceAll(',', '.')) ?? _sliderBerat;
                                  final t = double.tryParse(tinggiCtrl.text.replaceAll(',', '.')) ?? _sliderTinggi;
                                  _sliderBerat = b.clamp(1, 300);
                                  _sliderTinggi = t.clamp(50, 250);
                                } else {
                                  beratCtrl.text = _sliderBerat.toStringAsFixed(1);
                                  tinggiCtrl.text = _sliderTinggi.toStringAsFixed(1);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      if (_sliderMode) ...[
                        Text('Berat: ${_sliderBerat.toStringAsFixed(1)} kg', style: const TextStyle(color: kText)),
                        Slider(
                          value: _sliderBerat,
                          min: 1,
                          max: 300,
                          divisions: 299,
                          activeColor: (kategori == '-') ? kGreen : warnaKategori(kategori),
                          onChanged: (v) => setState(() => _sliderBerat = double.parse(v.toStringAsFixed(1))),
                        ),
                        const SizedBox(height: 8),
                        Text('Tinggi: ${_sliderTinggi.toStringAsFixed(1)} cm', style: const TextStyle(color: kText)),
                        Slider(
                          value: _sliderTinggi,
                          min: 50,
                          max: 250,
                          divisions: 200,
                          activeColor: (kategori == '-') ? kBlue : warnaKategori(kategori),
                          onChanged: (v) => setState(() => _sliderTinggi = double.parse(v.toStringAsFixed(1))),
                        ),
                      ] else ...[
                        _inputField(label: 'Berat (kg)', controller: beratCtrl, icon: Icons.monitor_weight_outlined, accent: kGreen),
                        const SizedBox(height: 10),
                        _inputField(label: 'Tinggi (cm)', controller: tinggiCtrl, icon: Icons.height, accent: kBlue),
                      ],

                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: onHitung,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kGreen,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('HITUNG BMI', style: TextStyle(fontWeight: FontWeight.w800)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: onReset,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: kText,
                              side: const BorderSide(color: kBorder),
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              backgroundColor: kCard,
                            ),
                            child: const Text('Reset'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // RESULT CARD
              RepaintBoundary(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: badgeColor),
                  ),
                  child: Column(
                    children: [
                      const Text('Hasil', style: TextStyle(color: kText, fontSize: 16, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 10),
                      // BMI number with category color
                      Text(bmiText, style: TextStyle(color: bmiColor, fontSize: 48, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      // Category badge
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: badgeColor.withAlpha((0.18 * 255).round()),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: badgeColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Kategori: $kategori', style: TextStyle(color: badgeColor, fontWeight: FontWeight.w800)),
                                if (subLabel.isNotEmpty)
                                  Text('($subLabel)', style: TextStyle(color: badgeColor.withOpacity(0.8), fontSize: 11)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            if (bmi != null) IconButton(
                              onPressed: _copyResult,
                              icon: const Icon(Icons.copy, size: 20, color: kText),
                              tooltip: 'Salin hasil',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),
                      if (bmi != null) ...[
                        // Weight range narrative
                        Builder(builder: (context) {
                          final tinggiVal = double.tryParse(tinggiCtrl.text.trim().replaceAll(',', '.'));
                          if (tinggiVal != null && tinggiVal >= 50 && tinggiVal <= 250) {
                            return _weightRangeNarrative(tinggiVal);
                          }
                          return const Text('Masukkan tinggi untuk melihat rentang berat ideal.', style: TextStyle(color: kText, fontSize: 13));
                        }),
                        const SizedBox(height: 8),
                        Text(statusForKategori(kategori), style: const TextStyle(color: kText, fontSize: 13)),
                        const SizedBox(height: 12),
                        // Custom BMI Indicator
                        _bmiIndicatorWithTarget(bmi),
                      ] else ...[
                        const SizedBox(height: 14),
                        _bmiIndicatorWithTarget(null),
                        const SizedBox(height: 12),
                        const Text('MOVV Insight: BMI hanyalah awal, gaya hidup menentukan hasil.', style: TextStyle(color: kText, fontSize: 12)),
                      ],

                      // --- Explainability & advanced features section
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Penjelasan & Rekomendasi', style: TextStyle(color: kText, fontWeight: FontWeight.w700)),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _showExplanation = !_showExplanation;
                              });
                            },
                            icon: Icon(
                              _showExplanation ? Icons.expand_less : Icons.expand_more,
                              color: kText,
                            ),
                          },
                        ],
                      ),
                      if (_showExplanation) ...[
                        const SizedBox(height: 12),
                        Text(
                          _cachedExplanation ?? explainBMI(),
                          style: const TextStyle(color: kText, fontSize: 13),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 12),
                        // Highlighted recommendation box
                        if (kategori != '-')
                          _recommendationBox(
                            _cachedRecommendation ?? rekomendasiAksi(kategori),
                            warnaKategori(kategori),
                          ),
                        const SizedBox(height: 12),
                        // Tips section
                        if (kategori != '-') ...[
                          const Text('TIPS:', style: TextStyle(color: kText, fontSize: 12, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          _bulletList(tipsForKategori(kategori)),
                        ],
                        const SizedBox(height: 12),
                        Divider(color: kBorder),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Trend BMI Sebelumnya', style: TextStyle(color: kText, fontWeight: FontWeight.w700)),
                            Text(
                              trendIndicator(),
                              style: TextStyle(
                                color: (_previousBmi != null && bmi != null && bmi! > _previousBmi!) ? Colors.greenAccent : (_previousBmi != null && bmi != null) ? Colors.redAccent : kText,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        if (_previousBmi != null && bmi != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'BMI sebelumnya: ${_previousBmi!.toStringAsFixed(1)} (${kategoriBMI(_previousBmi!)}), sekarang: ${bmi!.toStringAsFixed(1)} (${kategori})',
                            style: const TextStyle(color: kText, fontSize: 13),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // WHO Reference & Limitation Awareness Footer
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0E1620),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Standar: WHO (World Health Organization) - BMI classification for adults', style: TextStyle(color: kText, fontSize: 12, fontWeight: FontWeight.w600)),
                    SizedBox(height: 6),
                    Text('Catatan: BMI adalah alat skrining, bukan diagnosis medis. BMI tidak membedakan massa otot dan lemak.', style: TextStyle(color: kText, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
