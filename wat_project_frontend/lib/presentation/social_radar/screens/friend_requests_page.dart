import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/social_radar/widgets/friend_request_action_tile.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class FriendRequestsPage extends StatelessWidget {
  const FriendRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Friend Requests',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppDimension.space16),
          itemCount: 3,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppDimension.space8),
          itemBuilder: (context, index) {
            return FriendRequestActionTile(
              name: 'Request ${index + 1}',
              onAccept: () {},
              onDecline: () {},
            );
          },
        ),
      ),
    );
  }
}
