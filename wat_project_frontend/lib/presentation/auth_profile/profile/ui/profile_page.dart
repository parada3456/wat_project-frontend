import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/presentation/auth_profile/widgets/credit_score_badge.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showDeleteAccountDialog(BuildContext context, ProfileBloc profileBloc) {
    final passwordController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'This action is permanent and cannot be undone. Please enter your password to confirm account deletion.',
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                final password = passwordController.text.trim();
                if (password.isNotEmpty) {
                  profileBloc.add(DeleteAccountSubmittedEvent(password));
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(const GetProfileEvent()),
      child: Builder(
        builder: (context) {
          final profileBloc = context.read<ProfileBloc>();
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  state.status.whenOrNull(
                    loadFailed: (message, _) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message ?? 'An error occurred'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    loadSuccess: (message) {
                      if (message == 'DELETE_ACCOUNT_SUCCESS') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Account successfully deleted.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        context.go('/login');
                      }
                    },
                  );
                },
                builder: (context, state) {
                  if (state.profile == null && state.status is UILoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.profile == null) {
                    return Center(
                      child: Text(
                        state.status.maybeWhen(
                          loadFailed: (message, _) => message ?? 'An error occurred',
                          orElse: () => 'No profile data loaded',
                        ),
                      ),
                    );
                  }

                  final user = state.profile!.user;
                  final profile = state.profile!.profile;
                  final creditScore = state.profile!.creditScore;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimension.space32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppDimension.space32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'My Profile',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.my_location),
                                    onPressed: () {
                                      // Trigger update location with sample coordinates
                                      profileBloc.add(const UpdateLocationSubmittedEvent(
                                        latitude: 13.7563,
                                        longitude: 100.5018,
                                      ));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Updating location coordinates...')),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.settings_outlined),
                                    onPressed: () => context.push('/settings'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimension.space32),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primary, width: 2),
                                    image: profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(profile.avatarUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: profile.avatarUrl == null || profile.avatarUrl!.isEmpty
                                      ? const Icon(Icons.person, size: 60, color: AppColors.white)
                                      : null,
                                ),
                                const SizedBox(height: AppDimension.space16),
                                Text(
                                  '${user.firstName ?? ""} ${user.lastName ?? ""}'.trim().isNotEmpty
                                      ? '${user.firstName ?? ""} ${user.lastName ?? ""}'.trim()
                                      : 'Unknown User',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  user.email,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    profile.bio!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: AppDimension.space32),
                          Center(
                            child: CreditScoreBadge(score: creditScore.currentScore),
                          ),
                          const SizedBox(height: AppDimension.space32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Actions',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.push('/profile/edit'),
                                child: const Text('Edit Profile'),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimension.space8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[50], foregroundColor: Colors.red),
                                onPressed: () => _showDeleteAccountDialog(context, profileBloc),
                                icon: const Icon(Icons.delete_forever, size: 18),
                                label: const Text('Delete Account'),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimension.space32),
                          const Text(
                            'Earned Badges',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: AppDimension.space16),
                          state.badges.isEmpty
                              ? const Text('No badges earned yet.', style: TextStyle(color: AppColors.textSecondary))
                              : Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: state.badges.map((badge) {
                                    return Chip(
                                      avatar: const Icon(Icons.stars, color: Colors.orangeAccent, size: 18),
                                      label: Text(badge.title),
                                      backgroundColor: AppColors.surface,
                                    );
                                  }).toList(),
                                ),
                          const SizedBox(height: AppDimension.space32),
                          const Text(
                            'Credit History Records',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: AppDimension.space16),
                          state.creditHistory.isEmpty
                              ? const Text('No credit records found.', style: TextStyle(color: AppColors.textSecondary))
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.creditHistory.length,
                                  separatorBuilder: (context, index) => const Divider(),
                                  itemBuilder: (context, index) {
                                    final record = state.creditHistory[index];
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(record.note ?? 'Score Adjustment'),
                                      subtitle: Text(record.createdAt.toLocal().toString().split(' ')[0]),
                                      trailing: Text(
                                        record.delta > 0 ? '+${record.delta}' : '${record.delta}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: record.delta > 0 ? Colors.green : Colors.red,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          const SizedBox(height: AppDimension.space50),
                        ],
                      ),
                    );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
