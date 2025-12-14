import 'package:flutter/material.dart';
import 'core/constants/color_constants.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  runApp(const WaterApp());
}

class WaterApp extends StatelessWidget {
  const WaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retro Water',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Courier', // Tüm uygulama için varsayılan font
        useMaterial3: true,
      ),
      home: const WaterHomePage(),
    );
  }
}