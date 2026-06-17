import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
class BadgeGridTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isEarned;

  const BadgeGridTile({
    super.key,
    required this.title,
    required this.icon,
    this.isEarned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isEarned ? AppColors.primary.withOpacity(0.1) : AppColors.surfaceAlt,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 30,
              color: isEarned ? AppColors.primary : AppColors.textSecondary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: AppDimension.space12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isEarned ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
