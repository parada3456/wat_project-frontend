import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
class FriendCard extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final bool isOnline;
  final VoidCallback onDelete;

  const FriendCard({
    super.key,
    required this.name,
    this.avatarUrl,
    this.isOnline = false,
    required this.onDelete,
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
          Stack(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.surface,
                child: const Icon(Icons.person, color: AppColors.white),
              ),
              if (isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
            ],
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
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
