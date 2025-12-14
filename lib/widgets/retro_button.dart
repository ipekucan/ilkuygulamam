import 'package:flutter/material.dart';
import '../core/constants/color_constants.dart'; // Renkleri bir üst klasörden çektik

class RetroButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final bool isWide;

  const RetroButton({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isWide ? double.infinity : 140,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: AppColors.border, width: 3),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: AppColors.border, offset: Offset(4, 4))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.border),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.border,
                fontFamily: 'Courier', // Font tutarlılığı için ekledik
              ),
            ),
          ],
        ),
      ),
    );
  }
}