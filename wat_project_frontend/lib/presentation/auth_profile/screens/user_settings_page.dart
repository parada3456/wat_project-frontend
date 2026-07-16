import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/presentation/auth_profile/widgets/settings_toggle_tile.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';

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
    AppPopup.show<void>(
      context: context,
      title: 'Delete Account',
      message: 'This action is permanent. Enter your password to confirm.',
      type: AppPopupType.error,
      content: WatInputField(
        label: 'Current Password',
        hint: 'enter password',
        controller: passwordController,
        obscureText: true,
      ),
      buttons: [
        const AppPopupButton(label: 'Cancel'),
        AppPopupButton(
          label: 'Delete',
          isPrimary: true,
          color: AppColors.error,
          autoPop: false,
          onPressed: () {
            final password = passwordController.text.trim();
            if (password.isNotEmpty) {
              profileBloc.add(DeleteAccountSubmittedEvent(password));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) =>
              getIt<ProfileBloc>()..add(const GetProfileEvent()),
        ),
        BlocProvider<LoginBloc>(create: (context) => getIt<LoginBloc>()),
      ],
      child: Builder(
        builder: (context) {
          final profileBloc = context.read<ProfileBloc>();
          final loginBloc = context.read<LoginBloc>();
          final bgColor = AppColors.bg(context);
          final textColor = AppColors.text(context);

          return Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              leading: IconButton(
                icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('SETTINGS'),
            ),
            body: MultiBlocListener(
              listeners: [
                BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state.profile != null) {
                      setState(() {
                        _radarVisibility =
                            state.profile!.profile.radarVisibility !=
                            RadarVisibility.hidden;
                      });
                    }
                    state.status.whenOrNull(
                      loadFailed: (message, _) {
                        AppPopup.show<void>(
                          context: context,
                          title: 'Error',
                          message: message ?? 'An error occurred',
                          type: AppPopupType.error,
                          buttons: [
                            AppPopupButton(
                              label: 'Dismiss',
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                      loadSuccess: (message) {
                        if (message == 'DELETE_ACCOUNT_SUCCESS') {
                          AppPopup.show<void>(
                            context: context,
                            title: 'Account Deleted',
                            message: 'Account successfully deleted.',
                            type: AppPopupType.success,
                            buttons: [
                              AppPopupButton(
                                label: 'OK',
                                isPrimary: true,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context.go('/login');
                                },
                              ),
                            ],
                          );
                        }
                      },
                    );
                  },
                ),
              ],
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileState) {
                  final isLoading =
                      profileState.status is UILoading || _isUpdating;
                  return SafeArea(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimension.space24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: AppDimension.space24),
                              PixelSectionHeader(label: 'PRIVACY'),
                              const SizedBox(height: AppDimension.space12),
                              SettingsToggleTile(
                                title: 'Radar Visibility',
                                subtitle:
                                    'Allow friends to see your location on the radar',
                                value: _radarVisibility,
                                onChanged: (value) async {
                                  setState(() {
                                    _isUpdating = true;
                                  });
                                  try {
                                    await getIt<UserRepository>()
                                        .updateSettings({
                                          'radar_visibility': value
                                              ? 'showFriends'
                                              : 'hidden',
                                        });
                                    if (!context.mounted) return;
                                    profileBloc.add(const GetProfileEvent());
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    AppPopup.show<void>(
                                      context: context,
                                      title: 'Error',
                                      message:
                                          'Failed to update visibility: $e',
                                      type: AppPopupType.error,
                                      buttons: [
                                        AppPopupButton(
                                          label: 'Dismiss',
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
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
                              const SizedBox(height: AppDimension.space24),
                              PixelSectionHeader(label: 'NOTIFICATIONS'),
                              const SizedBox(height: AppDimension.space12),
                              SettingsToggleTile(
                                title: 'Push Notifications',
                                subtitle:
                                    'Receive updates about missions and expenses',
                                value: _notificationsEnabled,
                                onChanged: (value) async {
                                  setState(() {
                                    _isUpdating = true;
                                    _notificationsEnabled = value;
                                  });
                                  try {
                                    await getIt<UserRepository>()
                                        .updateSettings({
                                          'push_notifications': value,
                                        });
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    AppPopup.show<void>(
                                      context: context,
                                      title: 'Error',
                                      message:
                                          'Failed to update notification settings: $e',
                                      type: AppPopupType.error,
                                      buttons: [
                                        AppPopupButton(
                                          label: 'Dismiss',
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
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
                              const SizedBox(height: AppDimension.space24),
                              PixelSectionHeader(label: 'ACCOUNT'),
                              const SizedBox(height: AppDimension.space12),
                              WatButton.outlined(
                                label: 'Log Out',
                                onPressed: () {
                                  loginBloc.add(const LogoutRequestedEvent());
                                },
                              ),
                              const SizedBox(height: AppDimension.space12),
                              WatButton(
                                label: 'Delete Account',
                                backgroundColor: AppColors.error.withValues(alpha: 0.15),
                                borderColor: AppColors.error,
                                textColor: AppColors.error,
                                onPressed: () => _showDeleteAccountDialog(
                                  context,
                                  profileBloc,
                                ),
                              ),
                              const SizedBox(height: AppDimension.space48),
                            ],
                          ),
                        ),
                        if (isLoading)
                          Container(
                            color: Colors.black.withValues(alpha: 0.25),
                            child: const Center(
                              child: PixelLoadingDots(color: AppColors.primary),
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
