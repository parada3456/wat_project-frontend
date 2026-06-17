import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_event.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_state.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _hometownController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _hometownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Create Account',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is LoginLoading;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppDimension.space32),
                child: Column(
                  children: [
                    const SizedBox(height: AppDimension.space32),
                    // Avatar Picker Placeholder
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: AppColors.surface,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.white,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(AppDimension.space8),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 17,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimension.space32),
                    WatInputField(
                      label: 'FullName',
                      hint: 'Enter your name',
                      controller: _nameController,
                    ),
                    const SizedBox(height: AppDimension.space16),
                    WatInputField(
                      label: 'Email',
                      hint: 'username@email.com',
                      controller: _emailController,
                    ),
                    const SizedBox(height: AppDimension.space16),
                    WatInputField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: AppDimension.space16),
                    WatInputField(
                      label: 'HomeTown',
                      hint: 'Select your hometown',
                      controller: _hometownController,
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppDimension.space32),
                    WatButton(
                      label: 'SignUp',
                      isLoading: isLoading,
                      onPressed: () {
                        final fullName = _nameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All fields are required')),
                          );
                          return;
                        }

                        // Split full name into first name and last name
                        final nameParts = fullName.split(' ');
                        final firstName = nameParts.first;
                        final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

                        context.read<LoginBloc>().add(
                              RegisterSubmittedEvent(
                                email: email,
                                password: password,
                                firstName: firstName,
                                lastName: lastName,
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: AppDimension.space32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'SignIn',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimension.space50),
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
