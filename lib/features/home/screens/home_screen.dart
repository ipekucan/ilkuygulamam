import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/services/goal_service.dart';
import '../../../widgets/retro_button.dart';
import '../../profile/screens/profile_screen.dart'; // Profil sayfasına erişim

class WaterHomePage extends StatefulWidget {
  const WaterHomePage({super.key});

  @override
  State<WaterHomePage> createState() => _WaterHomePageState();
}

class _WaterHomePageState extends State<WaterHomePage> {
  int _currentIntake = 0;
  int _dailyGoal = 2500;
  int _mlAmount = 200; // Ayarlanabilir ml miktarı
  String _cupDesign = 'default'; // Bardak tasarımı (şimdilik kullanılmıyor)

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    final g = await GoalService.getDailyGoal();
    setState(() => _dailyGoal = g);
  }

  void _addWater(int amount) {
    setState(() {
      _currentIntake += amount;
    });
  }

  void _resetDay() {
    setState(() {
      _currentIntake = 0;
    });
  }

  IconData _getCupIcon() {
    switch (_cupDesign) {
      case 'cafe':
        return Icons.local_cafe;
      case 'drink':
        return Icons.local_drink;
      case 'drop':
        return Icons.water_drop;
      default:
        return Icons.water_drop;
    }
  }

  void _showMlDialog() {
    final TextEditingController controller = TextEditingController(text: _mlAmount.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ML Miktarı Ayarla', style: TextStyle(fontFamily: 'Courier')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'ML'),
            ),
            const SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ElevatedButton(onPressed: () { setState(() => _mlAmount = 100); Navigator.pop(context); }, child: const Text('100')),
                ElevatedButton(onPressed: () { setState(() => _mlAmount = 200); Navigator.pop(context); }, child: const Text('200')),
                ElevatedButton(onPressed: () { setState(() => _mlAmount = 300); Navigator.pop(context); }, child: const Text('300')),
                ElevatedButton(onPressed: () { setState(() => _mlAmount = 500); Navigator.pop(context); }, child: const Text('500')),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('İptal')),
          TextButton(
            onPressed: () {
              final parsed = int.tryParse(controller.text);
              if (parsed != null && parsed > 0) {
                setState(() => _mlAmount = parsed);
              }
              Navigator.pop(context);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _showCupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bardak Tasarımı Seç', style: TextStyle(fontFamily: 'Courier')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.local_cafe, size: 40),
                  onPressed: () { setState(() => _cupDesign = 'cafe'); Navigator.pop(context); },
                ),
                IconButton(
                  icon: const Icon(Icons.local_drink, size: 40),
                  onPressed: () { setState(() => _cupDesign = 'drink'); Navigator.pop(context); },
                ),
                IconButton(
                  icon: const Icon(Icons.water_drop, size: 40),
                  onPressed: () { setState(() => _cupDesign = 'drop'); Navigator.pop(context); },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tamam')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentIntake / _dailyGoal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "HYDRATION STATION",
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: AppColors.text,
            letterSpacing: 2.0,
            fontFamily: 'Courier',
          ),
        ),
        // SAĞ ÜSTTEKİ PROFİL İKONU
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: AppColors.text),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              // reload goal in case it was changed in profile
              _loadGoal();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Bilgi Kartı
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.accent,
                border: Border.all(color: AppColors.border, width: 3),
                boxShadow: const [BoxShadow(color: AppColors.border, offset: Offset(6, 6))],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(_getCupIcon(), size: 60, color: AppColors.border),
                  const SizedBox(height: 10),
                  const Text("GÜNLÜK HEDEF", style: TextStyle(fontFamily: 'Courier', fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(
                    "$_currentIntake / $_dailyGoal ml",
                    style: const TextStyle(fontFamily: 'Courier', fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.border),
                  ),
                ],
              ),
            ),

            // İlerleme Çubuğu
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Status:", style: TextStyle(fontFamily: 'Courier', fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.border, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: progress == 1.0 ? AppColors.secondary : AppColors.primary,
                        border: const Border(right: BorderSide(color: AppColors.border, width: 3)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  progress == 1.0 ? "HEDEF TAMAMLANDI! 🎉" : "%${(progress * 100).toInt()} Loading...",
                  style: const TextStyle(fontFamily: 'Courier', fontSize: 14),
                ),
              ],
            ),

            // Butonlar
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: RetroButton(
                        label: "ML\n($_mlAmount)",
                        color: AppColors.secondary,
                        icon: Icons.settings,
                        onTap: _showMlDialog,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: RetroButton(
                        label: "BARDAK",
                        color: AppColors.primary,
                        icon: _getCupIcon(),
                        onTap: _showCupDialog,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                RetroButton(
                  label: "+ SU EKLE",
                  color: AppColors.accent,
                  icon: Icons.add,
                  isWide: true,
                  onTap: () => _addWater(_mlAmount),
                ),
                const SizedBox(height: 20),
                RetroButton(
                  label: "RESET DAY",
                  color: Colors.white,
                  icon: Icons.refresh,
                  isWide: true,
                  onTap: _resetDay,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}