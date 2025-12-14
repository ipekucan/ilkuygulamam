import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/services/goal_service.dart';
import '../home/screens/home_screen.dart';

class InitialSetupScreen extends StatefulWidget {
  const InitialSetupScreen({super.key});

  @override
  State<InitialSetupScreen> createState() => _InitialSetupScreenState();
}

class _InitialSetupScreenState extends State<InitialSetupScreen> {
  final TextEditingController _controller = TextEditingController(text: '2500');
  bool _isSaving = false;

  Future<void> _saveGoal() async {
    final text = _controller.text.trim();
    final parsed = int.tryParse(text);
    if (parsed == null || parsed <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen geçerli bir sayı girin')));
      return;
    }

    setState(() => _isSaving = true);
    await GoalService.setDailyGoal(parsed);
    setState(() => _isSaving = false);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const WaterHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('WELCOME', style: TextStyle(fontFamily: 'Courier', color: AppColors.text, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Set your daily water goal (ml)', style: TextStyle(fontFamily: 'Courier', fontSize: 18)),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'e.g. 2500'),
              style: const TextStyle(fontFamily: 'Courier'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSaving ? null : _saveGoal,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: _isSaving ? const CircularProgressIndicator() : const Text('SAVE', style: TextStyle(fontFamily: 'Courier')),
            ),
          ],
        ),
      ),
    );
  }
}
