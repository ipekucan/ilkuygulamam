import 'package:flutter/material.dart';
import 'core/constants/color_constants.dart';
import 'core/services/goal_service.dart';
import 'features/home/screens/home_screen.dart';
import 'features/onboarding/initial_setup_screen.dart';

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
      home: FutureBuilder<bool>(
        future: GoalService.hasDailyGoal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final hasGoal = snapshot.data ?? false;
          if (!hasGoal) {
            return const InitialSetupScreen();
          }

          return const WaterHomePage();
        },
      ),
    );
  }
}