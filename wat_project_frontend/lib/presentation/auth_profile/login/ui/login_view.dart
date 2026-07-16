import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/widgets/login_header.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();
    AppPopup.show<void>(
      context: context,
      title: 'Forgot Password',
      message: 'Enter your email address to reset your password.',
      type: AppPopupType.info,
      content: WatInputField(
        label: 'Email Address',
        hint: 'enter your email',
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
      ),
      buttons: [
        const AppPopupButton(label: 'Cancel'),
        AppPopupButton(
          label: 'Submit',
          isPrimary: true,
          autoPop: false,
          onPressed: () {
            final email = emailController.text.trim();
            if (email.isNotEmpty) {
              context
                  .read<LoginBloc>()
                  .add(ForgotPasswordSubmittedEvent(email));
              context.pop();
            }
          },
        ),
      ],
    );
  }

  String? _getError(LoginState state, String field) {
    if (field == 'email' && _emailError != null) return _emailError;
    if (field == 'password' && _passwordError != null) return _passwordError;

    final status = state.status;
    if (status is UILoadFailed && status.apiError != null) {
      try {
        return status.apiError!.details
            .firstWhere((e) => e.field == field)
            .reason;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subtextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        state.status.whenOrNull(
          loadFailed: (message, apiError) {
            AppPopup.show<void>(
              context: context,
              title: 'Login Failed',
              message: message ?? 'An error occurred',
              type: AppPopupType.error,
              buttons: [
                AppPopupButton(
                  label: 'Dismiss',
                  onPressed: () => context.pop(),
                ),
              ],
            );
          },
          loadSuccess: (message) {
            AppPopup.show<void>(
              context: context,
              title: 'Success',
              message: message ?? 'Login successful!',
              type: AppPopupType.success,
              buttons: [
                AppPopupButton(
                  label: 'OK',
                  isPrimary: true,
                  onPressed: () {
                    context.pop();
                    context.push('/home');
                  },
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimension.space32,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: AppDimension.space50),
                    const LoginHeader(),
                    const SizedBox(height: AppDimension.space40),

                    // ─── Pixel dialog panel ───
                    PixelDialogBox(
                      title: 'SIGN IN',
                      child: Column(
                        children: [
                          WatInputField(
                            label: 'Email',
                            hint: 'username@email.com',
                            controller: _emailController,
                            errorText: _getError(state, 'email'),
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (_) {
                              if (_emailError != null) {
                                setState(() => _emailError = null);
                              }
                            },
                          ),
                          const SizedBox(height: AppDimension.space16),
                          WatInputField(
                            label: 'Password',
                            hint: 'enter your password',
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            autocorrect: false,
                            enableSuggestions: false,
                            errorText: _getError(state, 'password'),
                            suffixIcon: GestureDetector(
                              onTap: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                              child: AppAssets.img(
                                _obscurePassword
                                    ? AppAssets.iconPassword
                                    : AppAssets.iconCheck,
                                size: 18,
                                color: subtextColor,
                              ),
                            ),
                            onChanged: (_) {
                              if (_passwordError != null) {
                                setState(() => _passwordError = null);
                              }
                            },
                          ),
                          const SizedBox(height: AppDimension.space8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: _showForgotPasswordDialog,
                              child: Text(
                                '> FORGOT PASSWORD?',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 7,
                                  color: AppColors.primary,
                                  height: 1.8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppDimension.space20),
                          WatButton(
                            label: 'Sign In',
                            isLoading: state.status is UILoading,
                            onPressed: () => _submit(context),
                          ),
                          const SizedBox(height: AppDimension.space16),
                          // OR divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: borderColor,
                                  thickness: AppDimension.pixelBorderWidth,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimension.space8,
                                ),
                                child: Text(
                                  'OR',
                                  style: GoogleFonts.pressStart2p(
                                    fontSize: 8,
                                    color: subtextColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: borderColor,
                                  thickness: AppDimension.pixelBorderWidth,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimension.space16),
                          WatButton.outlined(
                            label: 'Sign in with Google',
                            onPressed: () => _handleGoogleSignIn(),
                            borderColor: borderColor,
                            textColor: textColor,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppDimension.space20),
                    // ─── Register link ───
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "NO ACCOUNT?  ",
                          style: GoogleFonts.pressStart2p(
                            fontSize: 7,
                            color: subtextColor,
                            height: 1.8,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/register'),
                          child: Text(
                            'SIGN UP',
                            style: GoogleFonts.pressStart2p(
                              fontSize: 7,
                              color: AppColors.primary,
                              height: 1.8,
                            ),
                          ),
                        ),
                      ],
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

  void _submit(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    var isValid = true;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty) {
      _emailError = 'Email is required';
      isValid = false;
    } else if (!emailRegex.hasMatch(email)) {
      _emailError = 'Enter a valid email format';
      isValid = false;
    }

    if (password.isEmpty) {
      _passwordError = 'Password is required';
      isValid = false;
    } else if (password.length < 8) {
      _passwordError = 'Password must be at least 8 characters';
      isValid = false;
    }

    if (isValid) {
      context.read<LoginBloc>().add(LoginSubmittedEvent(email, password));
    } else {
      setState(() {});
    }
  }

  Future<String?> getGoogleIdToken() async {
    final googleSignIn = GoogleSignIn.instance;
    try {
      await googleSignIn.initialize();
      final googleUser = await googleSignIn.authenticate(
        scopeHint: ['email'],
      );
      final googleAuth = googleUser.authentication;
      return googleAuth.idToken;
    } catch (error) {
      debugPrint('Google Sign-In Error: $error');
      return null;
    }
  }

  void _handleGoogleSignIn() async {
    final idToken = await getGoogleIdToken();
    if (idToken == null) return;
    if (mounted) {
      context.read<LoginBloc>().add(GoogleLoginSubmittedEvent(idToken));
    }
  }
}
