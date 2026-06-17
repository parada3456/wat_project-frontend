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
      child: SingleChildScrollView(
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
            ),
            const SizedBox(height: AppDimension.space32),
            WatInputField(
              label: 'Password',
              hint: 'Enter your password',
              controller: _passwordController,
              obscureText: true,
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
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                final isLoading = state is LoginLoading;
                return WatButton(
                  label: 'SignIn',
                  isLoading: isLoading,
                  onPressed: () {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    if (email.isNotEmpty && password.isNotEmpty) {
                      context.read<LoginBloc>().add(
                            LoginSubmittedEvent(email, password),
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter email and password'),
                        ),
                      );
                    }
                  },
                );
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
      ),
    );
  }
}
