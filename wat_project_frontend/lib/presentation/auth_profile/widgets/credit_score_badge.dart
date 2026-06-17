import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
class CreditScoreBadge extends StatelessWidget {
  final int score;

  const CreditScoreBadge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    Color scoreColor;
    if (score >= 800) {
      scoreColor = Colors.green;
    } else if (score >= 600) {
      scoreColor = Colors.orange;
    } else {
      scoreColor = AppColors.error;
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: score / 1000,
                strokeWidth: 8,
                backgroundColor: AppColors.surface,
                valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
              ),
            ),
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimension.space8),
        const Text(
          'Credit Score',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
