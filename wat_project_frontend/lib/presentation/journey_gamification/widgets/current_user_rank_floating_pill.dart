import 'package:flutter/material.dart';
import 'package:wat_project_frontend/domain/models/gamification/user_credit_model.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class CurrentUserRankFloatingPill extends StatelessWidget {
  final UserCreditModel userCredit;

  const CurrentUserRankFloatingPill({
    super.key,
    required this.userCredit,
  });

  @override
  Widget build(BuildContext context) {
    final avatarUrl = userCredit.avatarUrl;
    final name = userCredit.name;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            backgroundImage: (avatarUrl != null && avatarUrl.isNotEmpty)
                ? NetworkImage(avatarUrl)
                : null,
            child: (avatarUrl == null || avatarUrl.isEmpty)
                ? Text(
                    name?.isNotEmpty == true ? name![0].toUpperCase() : 'Y',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'You',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '#${userCredit.rank}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_downward,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
