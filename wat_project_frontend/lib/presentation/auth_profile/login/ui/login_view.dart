import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/auth_profile/widgets/login_header.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';

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
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Forgot Password'),
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your email',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  context.read<LoginBloc>().add(
                    ForgotPasswordSubmittedEvent(email),
                  );
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print('status: ${state.status}');
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
                  onPressed: () => Navigator.of(context).pop(),
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
                    Navigator.of(context).pop();
                    context.push('/home');
                  },
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
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
                    const SizedBox(height: AppDimension.space50),
                    IconButton(
                      icon: const Icon(
                        Icons.home,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () {
                        context.push('/home');
                      },
                    ),
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
                    const SizedBox(height: AppDimension.space32),
                    WatInputField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      autocorrect: false,
                      enableSuggestions: false,
                      errorText: _getError(state, 'password'),
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                        child: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      onChanged: (_) {
                        if (_passwordError != null) {
                          setState(() => _passwordError = null);
                        }
                      },
                    ),
                    const SizedBox(height: AppDimension.space16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _showForgotPasswordDialog,
                        child: const Text(
                          'ForgotPassword?',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimension.space32),
                    WatButton(
                      label: 'SignIn',
                      isLoading: state.status is UILoading,
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        setState(() {
                          _emailError = null;
                          _passwordError = null;
                        });

                        bool isValid = true;
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

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
                          _passwordError =
                              'Password must be at least 8 characters';
                          isValid = false;
                        }

                        if (isValid) {
                          context.read<LoginBloc>().add(
                            LoginSubmittedEvent(email, password),
                          );
                        } else {
                          setState(() {});
                        }
                      },
                    ),
                    const SizedBox(height: AppDimension.space16),
                    const Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.divider)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.divider)),
                      ],
                    ),
                    const SizedBox(height: AppDimension.space16),
                    OutlinedButton(
                      onPressed: () => _handleGoogleSignIn(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        side: const BorderSide(color: AppColors.divider),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                        ),
                        backgroundColor: AppColors.surface,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/512px-Google_%22G%22_Logo.svg.png',
                            height: 18,
                            width: 18,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.login,
                              size: 18,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimension.space32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/register'),
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<String?> getGoogleIdToken() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    try {
      await googleSignIn.initialize();
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate(
        scopeHint: ['email'],
      );
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      return googleAuth.idToken;
    } catch (error) {
      print('Google Sign-In Error: $error');
      return null;
    }
  }

  void _handleGoogleSignIn() async {
    final idToken = await getGoogleIdToken();
    if (idToken == null) {
      return;
    }

    if (mounted) {
      context.read<LoginBloc>().add(
            GoogleLoginSubmittedEvent(idToken),
          );
    }
  }
}
