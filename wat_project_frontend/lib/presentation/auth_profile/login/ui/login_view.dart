import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/presentation/auth_profile/widgets/login_header.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_event.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_state.dart';

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
                  context.read<LoginBloc>().add(ForgotPasswordSubmittedEvent(email));
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

    if (state is LoginFailure && state.apiError != null) {
      try {
        return state.apiError!.details.firstWhere((e) => e.field == field).reason;
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
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Forgot password email sent successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppDimension.space32),
                child: Column(
                  children: [
                    const SizedBox(height: AppDimension.space50),
                    const LoginHeader(),
                    const SizedBox(height: AppDimension.space50),
                    WatInputField(
                      label: 'Email',
                      hint: 'username@email.com',
                      controller: _emailController,
                      errorText: _getError(state, 'email'),
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
                      obscureText: true,
                      errorText: _getError(state, 'password'),
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
                      isLoading: state is LoginLoading,
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        setState(() {
                          _emailError = null;
                          _passwordError = null;
                        });

                        bool isValid = true;
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
                          context.read<LoginBloc>().add(
                                LoginSubmittedEvent(email, password),
                              );
                        } else {
                          setState(() {});
                        }
                      },
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
                          onTap: () => context.push('/register2'),
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
}
