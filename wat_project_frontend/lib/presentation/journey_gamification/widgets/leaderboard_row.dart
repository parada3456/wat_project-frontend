import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class LeaderboardRow extends StatelessWidget {
  final int rank;
  final String name;
  final int points;
  final String? avatarUrl;
  final bool isCurrentUser;

  const LeaderboardRow({
    super.key,
    required this.rank,
    required this.name,
    required this.points,
    this.avatarUrl,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppColors.primary.withOpacity(0.1)
            : AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        border: isCurrentUser ? Border.all(color: AppColors.primary) : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: rank <= 3 ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.surface,
            child: const Icon(Icons.person, color: AppColors.white),
          ),
          const SizedBox(width: AppDimension.space16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            '$points pts',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
