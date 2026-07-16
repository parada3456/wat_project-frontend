import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _avatarController = TextEditingController();
  bool _initialized = false;
  bool _wasSaving = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = AppColors.bg(context);
    final textColor = AppColors.text(context);
    final borderColor = AppColors.border(context);

    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(const GetProfileEvent()),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          leading: IconButton(
            icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
            onPressed: () => context.pop(),
          ),
          title: const Text('EDIT PROFILE'),
        ),
        body: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              state.status.whenOrNull(
                loadFailed: (message, _) {
                  AppPopup.show<void>(
                    context: context,
                    title: 'Update Failed',
                    message: message ?? 'An error occurred',
                    type: AppPopupType.error,
                    buttons: [
                      AppPopupButton(
                        label: 'Dismiss',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                  setState(() {
                    _wasSaving = false;
                  });
                },
                loadSuccess: (message) {
                  if (state.profile != null && !_initialized) {
                    _firstNameController.text =
                        state.profile!.user.firstName ?? '';
                    _lastNameController.text =
                        state.profile!.user.lastName ?? '';
                    _bioController.text = state.profile!.profile.bio ?? '';
                    _avatarController.text =
                        state.profile!.profile.avatarUrl ?? '';
                    setState(() {
                      _initialized = true;
                    });
                  }
                  if (_wasSaving) {
                    AppPopup.show<void>(
                      context: context,
                      title: 'Success',
                      message: message ?? 'Profile successfully updated!',
                      type: AppPopupType.success,
                      buttons: [
                        AppPopupButton(
                          label: 'OK',
                          isPrimary: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.pop();
                          },
                        ),
                      ],
                    );
                  }
                },
              );

              if (state.profile != null && !_initialized) {
                _firstNameController.text = state.profile!.user.firstName ?? '';
                _lastNameController.text = state.profile!.user.lastName ?? '';
                _bioController.text = state.profile!.profile.bio ?? '';
                _avatarController.text = state.profile!.profile.avatarUrl ?? '';
                setState(() {
                  _initialized = true;
                });
              }
            },
            builder: (context, state) {
              final isLoading = state.status is UILoading;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimension.space24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimension.space24),
                    // Profile Image area in Pixel frame
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.panel(context),
                              border: Border.all(
                                color: borderColor,
                                width: AppDimension.pixelBorderWidth,
                              ),
                              image: _avatarController.text.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(_avatarController.text),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _avatarController.text.isEmpty
                                ? AppAssets.img(
                                    AppAssets.iconCharacter,
                                    size: 50,
                                    color: textColor,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(AppDimension.space4),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                border: Border.all(
                                  color: borderColor,
                                  width: AppDimension.pixelBorderWidth,
                                ),
                              ),
                              child: AppAssets.img(
                                AppAssets.iconEdit,
                                size: 12,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimension.space32),
                    // Inputs in PixelDialogBox
                    PixelDialogBox(
                      title: 'EDIT PLAYER INFO',
                      child: Column(
                        children: [
                          WatInputField(
                            label: 'First Name',
                            hint: 'enter first name',
                            controller: _firstNameController,
                          ),
                          const SizedBox(height: AppDimension.space16),
                          WatInputField(
                            label: 'Last Name',
                            hint: 'enter last name',
                            controller: _lastNameController,
                          ),
                          const SizedBox(height: AppDimension.space16),
                          WatInputField(
                            label: 'Bio',
                            hint: 'tell us about yourself',
                            controller: _bioController,
                          ),
                          const SizedBox(height: AppDimension.space16),
                          WatInputField(
                            label: 'Avatar Url',
                            hint: 'enter image url',
                            controller: _avatarController,
                            onChanged: (val) {
                              setState(() {}); // refresh preview image
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimension.space24),
                    // Save Button
                    WatButton(
                      label: 'Save Changes',
                      isLoading: isLoading,
                      onPressed: () {
                        setState(() {
                          _wasSaving = true;
                        });
                        context.read<ProfileBloc>().add(
                              UpdateProfileSubmittedEvent(
                                firstName: _firstNameController.text.trim(),
                                lastName: _lastNameController.text.trim(),
                                bio: _bioController.text.trim(),
                                avatarUrl: _avatarController.text.trim(),
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: AppDimension.space32),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
