import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class SocialLinkItem extends StatelessWidget {
  final IconData icon;
  final String username;

  const SocialLinkItem({super.key, required this.icon, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: AppDimension.space16),
          Text(
            username,
            style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
