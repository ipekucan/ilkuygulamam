import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart'; // Renkler için 3 klasör yukarı çıktık
import '../../../core/services/goal_service.dart';
import '../../../widgets/retro_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _goalController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    final g = await GoalService.getDailyGoal();
    _goalController.text = g.toString();
  }

  Future<void> _saveGoal() async {
    final parsed = int.tryParse(_goalController.text.trim());
    if (parsed == null || parsed <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen geçerli bir sayı girin')));
      return;
    }

    setState(() => _isSaving = true);
    await GoalService.setDailyGoal(parsed);
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hedef kaydedildi')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          "PROFILE",
          style: TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.text), // Geri butonu rengi
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profil Resmi Kutusu
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.accent,
                border: Border.all(color: AppColors.border, width: 3),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(Icons.person, size: 60, color: AppColors.border),
            ),
            const SizedBox(height: 20),

            // Kullanıcı Adı
            const Text(
              "PLAYER 1",
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),

            const SizedBox(height: 24),

            // Günlük hedef düzenleme
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Daily Goal (ml)', style: TextStyle(fontFamily: 'Courier', color: AppColors.text)),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _goalController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    style: const TextStyle(fontFamily: 'Courier'),
                  ),
                  const SizedBox(height: 16),
                  RetroButton(
                    label: _isSaving ? 'SAVING...' : 'SAVE GOAL',
                    color: AppColors.primary,
                    icon: Icons.save,
                    isWide: true,
                    onTap: _isSaving ? () {} : _saveGoal,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // İstatistik Kartı
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.border, width: 3),
                boxShadow: const [BoxShadow(color: AppColors.border, offset: Offset(4, 4))],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Text("TOTAL DRINK", style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold)),
                  Divider(color: AppColors.border, thickness: 2),
                  Text("12,500 ml", style: TextStyle(fontFamily: 'Courier', fontSize: 20, color: AppColors.primary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}