import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/presentation/auth_profile/widgets/settings_toggle_tile.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  bool _radarVisibility = false;
  bool _notificationsEnabled = true;
  bool _isUpdating = false;

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
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () {
                final password = passwordController.text.trim();
                if (password.isNotEmpty) {
                  profileBloc.add(DeleteAccountSubmittedEvent(password));
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => getIt<ProfileBloc>()..add(const GetProfileEvent()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => getIt<LoginBloc>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final profileBloc = context.read<ProfileBloc>();
          final loginBloc = context.read<LoginBloc>();

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: MultiBlocListener(
              listeners: [
                BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state.profile != null) {
                      setState(() {
                        _radarVisibility = state.profile!.profile.radarVisibility != RadarVisibility.hidden;
                      });
                    }
                    state.status.whenOrNull(
                      loadFailed: (message, _) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message ?? 'An error occurred'),
                            backgroundColor: AppColors.error,
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
                ),
                // BlocListener<LoginBloc, LoginState>(
                //   listener: (context, state) {
                //     if (state is LoginFailure) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text(state.errorMessage),
                //           backgroundColor: AppColors.error,
                //         ),
                //       );
                //     } else if (state is LoginInitial) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text('Successfully logged out.'),
                //           backgroundColor: Colors.green,
                //         ),
                //       );
                //       context.go('/login');
                //     }
                //   },
                // ),
              ],
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileState) {
                  final isLoading = profileState.status is UILoading || _isUpdating;
                  return SafeArea(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimension.space32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: AppDimension.space32),
                              const Text(
                                'Privacy',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppDimension.space16),
                              SettingsToggleTile(
                                title: 'Radar Visibility',
                                subtitle: 'Allow friends to see your location on the radar',
                                value: _radarVisibility,
                                onChanged: (value) async {
                                  setState(() {
                                    _isUpdating = true;
                                  });
                                  try {
                                    await getIt<UserRepository>().updateSettings({
                                      'radar_visibility': value ? 'showFriends' : 'hidden',
                                    });
                                    if (!context.mounted) return;
                                    profileBloc.add(const GetProfileEvent());
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to update visibility: $e'),
                                        backgroundColor: AppColors.error,
                                      ),
                                    );
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isUpdating = false;
                                      });
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: AppDimension.space16),
                              const Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppDimension.space16),
                              SettingsToggleTile(
                                title: 'Push Notifications',
                                subtitle: 'Receive updates about missions and expenses',
                                value: _notificationsEnabled,
                                onChanged: (value) async {
                                  setState(() {
                                    _isUpdating = true;
                                    _notificationsEnabled = value;
                                  });
                                  try {
                                    await getIt<UserRepository>().updateSettings({
                                      'push_notifications': value,
                                    });
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to update notification settings: $e'),
                                        backgroundColor: AppColors.error,
                                      ),
                                    );
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isUpdating = false;
                                      });
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: AppDimension.space50),
                              const Text(
                                'Account',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppDimension.space16),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {
                                    loginBloc.add(const LogoutRequestedEvent());
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.textPrimary,
                                    side: const BorderSide(color: AppColors.surface),
                                    padding: const EdgeInsets.symmetric(vertical: AppDimension.space16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                                    ),
                                  ),
                                  child: const Text('Log Out'),
                                ),
                              ),
                              const SizedBox(height: AppDimension.space16),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () => _showDeleteAccountDialog(context, profileBloc),
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.error,
                                    padding: const EdgeInsets.symmetric(vertical: AppDimension.space16),
                                  ),
                                  child: const Text(
                                    'Delete Account',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppDimension.space50),
                            ],
                          ),
                        ),
                        if (isLoading)
                          Container(
                            color: Colors.black.withValues(alpha: 0.1),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
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
