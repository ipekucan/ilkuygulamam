import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../widgets/retro_button.dart';
import '../../profile/screens/profile_screen.dart'; // Profil sayfasına erişim

class WaterHomePage extends StatefulWidget {
  const WaterHomePage({super.key});

  @override
  State<WaterHomePage> createState() => _WaterHomePageState();
}

class _WaterHomePageState extends State<WaterHomePage> {
  int _currentIntake = 0;
  final int _dailyGoal = 2500;

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
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
                  const Icon(Icons.water_drop, size: 60, color: AppColors.border),
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
                    RetroButton(
                      label: "+200 ml",
                      color: AppColors.secondary,
                      icon: Icons.local_cafe,
                      onTap: () => _addWater(200),
                    ),
                    RetroButton(
                      label: "+500 ml",
                      color: AppColors.primary,
                      icon: Icons.local_drink,
                      onTap: () => _addWater(500),
                    ),
                  ],
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