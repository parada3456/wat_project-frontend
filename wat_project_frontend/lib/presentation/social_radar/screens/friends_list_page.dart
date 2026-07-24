import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/social_radar/widgets/friend_card.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class FriendsListPage extends StatelessWidget {
  const FriendsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Friends',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              // TODO: Navigate to Friend Requests
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimension.space16),
              color: AppColors.background,
              child: const WatInputField(
                label: 'Search',
                hint: 'Search friends...',
                suffixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppDimension.space16),
                itemCount: 5,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimension.space8),
                itemBuilder: (context, index) {
                  return FriendCard(
                    name: 'Friend ${index + 1}',
                    isOnline: index % 2 == 0,
                    onDelete: () {
                      // TODO: Implement Delete Friend
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
