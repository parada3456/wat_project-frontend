import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _arrivalDateController = TextEditingController();
  final _jobStartDateController = TextEditingController();
  final _otpController = TextEditingController();

  String? _selectedPhase = 'phase-1';

  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _arrivalDateError;
  String? _jobStartDateError;
  String? _otpError;

  bool _obscurePassword = true;
  bool _showOtpStep = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _arrivalDateController.dispose();
    _jobStartDateController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toIso8601String().split('T').first;
      });
    }
  }

  String? _getError(LoginState state, String field) {
    if (field == 'username' && _usernameError != null) return _usernameError;
    if (field == 'email' && _emailError != null) return _emailError;
    if (field == 'password' && _passwordError != null) return _passwordError;
    if (field == 'arrivalDate' && _arrivalDateError != null) return _arrivalDateError;
    if (field == 'jobStartDate' && _jobStartDateError != null) return _jobStartDateError;
    if (field == 'otp' && _otpError != null) return _otpError;

    final status = state.status;
    if (status is UILoadFailed && status.apiError != null) {
      try {
        return status.apiError!.details.firstWhere((e) => e.field == field).reason;
      } catch (_) {
        return null;
      }
    }
    return null;
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
            onPressed: () {
              if (_showOtpStep) {
                setState(() => _showOtpStep = false);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            _showOtpStep ? 'Verify OTP' : 'Create Account',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              final status = state.status;
              if (status is UILoadFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(status.message ?? 'Registration failed'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (status is UILoadSuccess) {
                AppPopup.show<void>(
                  context: context,
                  title: 'Success',
                  message: status.message ?? 'Registration successful!',
                  type: AppPopupType.success,
                  buttons: [
                    AppPopupButton(
                      label: 'OK',
                      isPrimary: true,
                      onPressed: () {
                        Navigator.of(context).pop(); // dismiss popup
                        context.push('/home');
                      },
                    ),
                  ],
                );
              }
            },
            builder: (context, state) {
              final isLoading = state.status is UILoading;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppDimension.space32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimension.space32),
                    if (!_showOtpStep) ...[
                      // Register Form Step
                      WatInputField(
                        label: 'Username',
                        hint: 'Enter your username',
                        controller: _usernameController,
                        errorText: _getError(state, 'username'),
                        autocorrect: false,
                        enableSuggestions: false,
                        onChanged: (_) {
                          if (_usernameError != null) setState(() => _usernameError = null);
                        },
                      ),
                      const SizedBox(height: AppDimension.space16),
                      WatInputField(
                        label: 'Email',
                        hint: 'username@email.com',
                        controller: _emailController,
                        errorText: _getError(state, 'email'),
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) {
                          if (_emailError != null) setState(() => _emailError = null);
                        },
                      ),
                      const SizedBox(height: AppDimension.space16),
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
                          if (_passwordError != null) setState(() => _passwordError = null);
                        },
                      ),
                      const SizedBox(height: AppDimension.space16),
                      const Text(
                        'Phase Selector',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space4),
                      DropdownButtonFormField<String>(
                        value: _selectedPhase,
                        dropdownColor: AppColors.surface,
                        decoration: InputDecoration(
                          hintText: 'Select your phase',
                          fillColor: AppColors.backgroundAlt,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'phase-1', child: Text('Phase 1')),
                          DropdownMenuItem(value: 'phase-2', child: Text('Phase 2')),
                          DropdownMenuItem(value: 'phase-3', child: Text('Phase 3')),
                          DropdownMenuItem(value: 'phase-4', child: Text('Phase 4')),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _selectedPhase = val;
                          });
                        },
                      ),
                      if (_selectedPhase != 'phase-1') ...[
                        const SizedBox(height: AppDimension.space16),
                        GestureDetector(
                          onTap: () => _selectDate(context, _arrivalDateController),
                          child: AbsorbPointer(
                            child: WatInputField(
                              label: 'Arrival Date',
                              hint: 'YYYY-MM-DD',
                              controller: _arrivalDateController,
                              errorText: _getError(state, 'arrivalDate'),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimension.space16),
                        GestureDetector(
                          onTap: () => _selectDate(context, _jobStartDateController),
                          child: AbsorbPointer(
                            child: WatInputField(
                              label: 'Job Start Date',
                              hint: 'YYYY-MM-DD',
                              controller: _jobStartDateController,
                              errorText: _getError(state, 'jobStartDate'),
                            ),
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: AppDimension.space16),
                        GestureDetector(
                          onTap: () => _selectDate(context, _arrivalDateController),
                          child: AbsorbPointer(
                            child: WatInputField(
                              label: 'Arrival Date (Optional)',
                              hint: 'YYYY-MM-DD',
                              controller: _arrivalDateController,
                              errorText: _getError(state, 'arrivalDate'),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimension.space16),
                        GestureDetector(
                          onTap: () => _selectDate(context, _jobStartDateController),
                          child: AbsorbPointer(
                            child: WatInputField(
                              label: 'Job Start Date (Optional)',
                              hint: 'YYYY-MM-DD',
                              controller: _jobStartDateController,
                              errorText: _getError(state, 'jobStartDate'),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: AppDimension.space32),
                      WatButton(
                        label: 'Next',
                        isLoading: isLoading,
                        onPressed: () {
                          final username = _usernameController.text.trim();
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          final arrivalDate = _arrivalDateController.text.trim();
                          final jobStartDate = _jobStartDateController.text.trim();

                          setState(() {
                            _usernameError = null;
                            _emailError = null;
                            _passwordError = null;
                            _arrivalDateError = null;
                            _jobStartDateError = null;
                          });

                          bool isValid = true;
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                          if (username.isEmpty) {
                            _usernameError = 'Username is required';
                            isValid = false;
                          }

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

                          if (_selectedPhase != 'phase-1') {
                            if (arrivalDate.isEmpty) {
                              _arrivalDateError = 'Arrival Date is required';
                              isValid = false;
                            }
                            if (jobStartDate.isEmpty) {
                              _jobStartDateError = 'Job Start Date is required';
                              isValid = false;
                            }
                          }

                          if (!isValid) {
                            setState(() {});
                            return;
                          }

                          // Proceed to OTP step
                          setState(() => _showOtpStep = true);
                        },
                      ),
                    ] else ...[
                      // OTP Verification Step
                      const Text(
                        'Email Verification',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We sent a 6-digit verification code to ${_emailController.text}. Please enter it below to verify.',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimension.space32),
                      WatInputField(
                        label: 'OTP Code',
                        hint: 'Enter 123456 to verify',
                        controller: _otpController,
                        errorText: _getError(state, 'otp'),
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.number,
                        onChanged: (_) {
                          if (_otpError != null) setState(() => _otpError = null);
                        },
                      ),
                      const SizedBox(height: AppDimension.space32),
                      WatButton(
                        label: 'Verify & Sign Up',
                        isLoading: isLoading,
                        onPressed: () {
                          final otp = _otpController.text.trim();
                          if (otp != '123456') {
                            setState(() {
                              _otpError = 'Invalid OTP. Please use 123456';
                            });
                            return;
                          }

                          final username = _usernameController.text.trim();
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          context.read<LoginBloc>().add(
                                RegisterSubmittedEvent(
                                  email: email,
                                  password: password,
                                  firstName: username,
                                  lastName: '',
                                ),
                              );
                        },
                      ),
                    ],
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
