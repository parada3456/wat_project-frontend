import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/presentation/auth_profile/widgets/credit_score_badge.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showDeleteAccountDialog(BuildContext context, ProfileBloc profileBloc) {
    final passwordController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(const GetProfileEvent()),
      child: Builder(
        builder: (context) {
          final profileBloc = context.read<ProfileBloc>();
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final bgColor = AppColors.bg(context);
          final textColor = AppColors.text(context);
          final subtextColor = AppColors.textSub(context);
          final borderColor = AppColors.border(context);

          return Scaffold(
            backgroundColor: bgColor,
            body: SafeArea(
              child: BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
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
                builder: (context, state) {
                  if (state.profile == null && state.status is UILoading) {
                    return const Center(child: PixelLoadingDots(color: AppColors.primary));
                  }

                  if (state.profile == null) {
                    return Center(
                      child: Text(
                        state.status.maybeWhen(
                          loadFailed: (message, _) =>
                              (message ?? 'An error occurred').toUpperCase(),
                          orElse: () => 'NO PROFILE DATA LOADED',
                        ),
                        style: GoogleFonts.pressStart2p(fontSize: 8, color: textColor),
                      ),
                    );
                  }

                  final user = state.profile!.user;
                  final profile = state.profile!.profile;
                  final creditScore = state.profile!.creditScore;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimension.space24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppDimension.space24),
                        // ─── Header ───
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MY PROFILE',
                              style: GoogleFonts.pressStart2p(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: AppAssets.img(
                                    AppAssets.iconLocation,
                                    size: 20,
                                    color: textColor,
                                  ),
                                  onPressed: () {
                                    profileBloc.add(
                                      const UpdateLocationSubmittedEvent(
                                        latitude: 13.7563,
                                        longitude: 100.5018,
                                      ),
                                    );
                                    AppPopup.show<void>(
                                      context: context,
                                      title: 'Updating Location',
                                      message: 'Updating location coordinates...',
                                      type: AppPopupType.info,
                                      buttons: [
                                        AppPopupButton(
                                          label: 'Dismiss',
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: AppAssets.img(
                                    AppAssets.iconSettings,
                                    size: 20,
                                    color: textColor,
                                  ),
                                  onPressed: () => context.push('/settings'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimension.space24),

                        // ─── Character Card ───
                        PixelBorderContainer(
                          width: double.infinity,
                          child: Column(
                            children: [
                              // Avatar Frame
                              Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: AppColors.panel(context),
                                  border: Border.all(
                                    color: borderColor,
                                    width: AppDimension.pixelBorderWidth,
                                  ),
                                  image: profile.avatarUrl != null &&
                                          profile.avatarUrl!.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(profile.avatarUrl!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: profile.avatarUrl == null ||
                                        profile.avatarUrl!.isEmpty
                                    ? AppAssets.img(
                                        AppAssets.iconCharacter,
                                        size: 48,
                                        color: textColor,
                                      )
                                    : null,
                              ),
                              const SizedBox(height: AppDimension.space16),
                              Text(
                                '${user.firstName ?? ""} ${user.lastName ?? ""}'
                                        .trim()
                                        .isNotEmpty
                                    ? '${user.firstName ?? ""} ${user.lastName ?? ""}'
                                          .trim()
                                          .toUpperCase()
                                    : 'UNKNOWN PLAYER',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppDimension.space4),
                              Text(
                                user.email.toLowerCase(),
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 7,
                                  color: subtextColor,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (profile.bio != null &&
                                  profile.bio!.isNotEmpty) ...[
                                const SizedBox(height: AppDimension.space12),
                                Text(
                                  '"${profile.bio!}"',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.pressStart2p(
                                    fontSize: 7,
                                    color: subtextColor,
                                    height: 1.8,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: AppDimension.space24),

                        // ─── Credit Score ───
                        if (creditScore != null)
                          Center(
                            child: CreditScoreBadge(
                              score: creditScore.currentScore,
                            ),
                          )
                        else
                          PixelBorderContainer(
                            width: double.infinity,
                            borderColor: AppColors.warning,
                            child: Center(
                              child: Text(
                                'CREDIT SCORE NOT ESTABLISHED YET',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 7,
                                  color: AppColors.warning,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        const SizedBox(height: AppDimension.space24),

                        // ─── Actions Section ───
                        PixelSectionHeader(label: 'ACTIONS'),
                        const SizedBox(height: AppDimension.space12),
                        Row(
                          children: [
                            Expanded(
                              child: WatButton(
                                label: 'Edit Profile',
                                onPressed: () => context.push('/profile/edit'),
                              ),
                            ),
                            const SizedBox(width: AppDimension.space12),
                            Expanded(
                              child: WatButton(
                                label: 'Delete Account',
                                backgroundColor: AppColors.error.withValues(alpha: 0.15),
                                borderColor: AppColors.error,
                                textColor: AppColors.error,
                                onPressed: () => _showDeleteAccountDialog(
                                  context,
                                  profileBloc,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimension.space24),

                        // ─── Badges Section ───
                        PixelSectionHeader(label: 'BADGES'),
                        const SizedBox(height: AppDimension.space12),
                        state.badges.isEmpty
                            ? Text(
                                'NO BADGES EARNED YET.',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 8,
                                  color: subtextColor,
                                ),
                              )
                            : Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: state.badges.map((badge) {
                                  return PixelBorderContainer(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimension.space8,
                                      vertical: AppDimension.space8,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppAssets.img(
                                          AppAssets.iconBadge,
                                          size: 16,
                                          color: AppColors.secondary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          badge.title.toUpperCase(),
                                          style: GoogleFonts.pressStart2p(
                                            fontSize: 7,
                                            color: textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                        const SizedBox(height: AppDimension.space24),

                        // ─── Credit History ───
                        PixelSectionHeader(label: 'CREDIT HISTORY'),
                        const SizedBox(height: AppDimension.space12),
                        state.creditHistory.isEmpty
                            ? Text(
                                'NO CREDIT RECORDS FOUND.',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 8,
                                  color: subtextColor,
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.creditHistory.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: AppDimension.space8),
                                itemBuilder: (context, index) {
                                  final record = state.creditHistory[index];
                                  final Color deltaColor = record.delta > 0
                                      ? AppColors.success
                                      : AppColors.error;

                                  return PixelBorderContainer(
                                    padding: const EdgeInsets.all(AppDimension.space12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (record.note ?? 'SCORE ADJUSTMENT')
                                                    .toUpperCase(),
                                                style: GoogleFonts.pressStart2p(
                                                  fontSize: 8,
                                                  color: textColor,
                                                  height: 1.5,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                record.createdAt
                                                    .toLocal()
                                                    .toString()
                                                    .split(' ')[0],
                                                style: GoogleFonts.pressStart2p(
                                                  fontSize: 6,
                                                  color: subtextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          record.delta > 0
                                              ? '+${record.delta}'
                                              : '${record.delta}',
                                          style: GoogleFonts.pressStart2p(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: deltaColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                        const SizedBox(height: AppDimension.space48),
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
