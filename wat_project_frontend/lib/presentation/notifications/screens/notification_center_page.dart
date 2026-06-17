import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/notifications/widgets/notification_item_tile.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class NotificationCenterPage extends StatelessWidget {
  const NotificationCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Mark all as read
            },
            child: const Text('Mark all as read'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppDimension.space16),
          itemCount: 5,
          separatorBuilder: (context, index) => const SizedBox(height: AppDimension.space8),
          itemBuilder: (context, index) {
            final titles = [
              'New Mission Assigned',
              'Friend Request',
              'Expense Alert',
              'Phase Unlocked',
              'System Update'
            ];
            final messages = [
              'Phase 1: Visa Prep is now available.',
              'Alex Smith sent you a friend request.',
              'Maria Garcia added a new expense for Pizza Night.',
              'Congratulations! You have moved to Phase 2.',
              'New features are available in the latest version.'
            ];
            final icons = [
              Icons.assignment_outlined,
              Icons.person_add_outlined,
              Icons.receipt_long_outlined,
              Icons.workspace_premium_outlined,
              Icons.system_update_outlined
            ];
            return NotificationItemTile(
              title: titles[index],
              message: messages[index],
              time: '${index + 1}h ago',
              icon: icons[index],
              isRead: index > 1,
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
