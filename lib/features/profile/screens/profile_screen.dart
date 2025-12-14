import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart'; // Renkler için 3 klasör yukarı çıktık

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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