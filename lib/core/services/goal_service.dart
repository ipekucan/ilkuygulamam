import 'package:shared_preferences/shared_preferences.dart';

class GoalService {
  static const _key = 'dailyGoal';

  static Future<bool> hasDailyGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_key);
  }

  static Future<int> getDailyGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 2500;
  }

  static Future<void> setDailyGoal(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, value);
  }
}
