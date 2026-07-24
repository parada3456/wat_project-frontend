import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class FriendRequestActionTile extends StatelessWidget {
  final String name;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const FriendRequestActionTile({
    super.key,
    required this.name,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.space16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
      ),
      child: Row(
        children: [
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
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                onPressed: onAccept,
              ),
              IconButton(
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: onDecline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
