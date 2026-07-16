import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/usecases/journey/list_journey_phases_usecase.dart';
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
  List<Map<String, String>> _phases = [
    {'id': 'phase-1', 'name': 'Phase 1'},
    {'id': 'phase-2', 'name': 'Phase 2'},
    {'id': 'phase-3', 'name': 'Phase 3'},
    {'id': 'phase-4', 'name': 'Phase 4'},
  ];

  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _arrivalDateError;
  String? _jobStartDateError;
  String? _otpError;

  bool _obscurePassword = true;
  bool _showOtpStep = false;

  @override
  void initState() {
    super.initState();
    _loadPhases();
  }

  Future<void> _loadPhases() async {
    try {
      final usecase = getIt<ListJourneyPhasesUseCase>();
      final result = await usecase();
      result.fold(
        (failure) {},
        (phases) {
          if (phases.isNotEmpty && mounted) {
            setState(() {
              _phases = phases.map((p) => {
                    'id': p.phaseId,
                    'name': p.title,
                  }).toList();
              if (!_phases.any((p) => p['id'] == _selectedPhase)) {
                _selectedPhase = _phases.first['id'];
              }
            });
          }
        },
      );
    } catch (_) {}
  }

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

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
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
        return status.apiError!.details
            .firstWhere((e) => e.field == field)
            .reason;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  void _validateAndNext(LoginState state) {
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

    var isValid = true;
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
    setState(() => _showOtpStep = true);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subtextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          leading: IconButton(
            icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
            onPressed: () {
              if (_showOtpStep) {
                setState(() => _showOtpStep = false);
              } else {
                context.pop();
              }
            },
          ),
          title: Text(
            _showOtpStep ? 'VERIFY OTP' : 'CREATE ACCOUNT',
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
                        context.pop();
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
                padding: const EdgeInsets.all(AppDimension.space24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimension.space16),
                    if (!_showOtpStep) ...[
                      PixelDialogBox(
                        title: 'PLAYER INFO',
                        child: Column(
                          children: [
                            WatInputField(
                              label: 'Username',
                              hint: 'enter your username',
                              controller: _usernameController,
                              errorText: _getError(state, 'username'),
                              autocorrect: false,
                              enableSuggestions: false,
                              onChanged: (_) {
                                if (_usernameError != null) {
                                  setState(() => _usernameError = null);
                                }
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
                          ],
                        ),
                      ),
                      const SizedBox(height: AppDimension.space16),
                      PixelDialogBox(
                        title: 'PHASE SELECT',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Phase dropdown in pixel style
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: AppDimension.pixelBorderWidth,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimension.space12,
                              ),
                              child: DropdownButton<String>(
                                value: _selectedPhase,
                                isExpanded: true,
                                dropdownColor: isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface,
                                underline: const SizedBox.shrink(),
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 9,
                                  color: textColor,
                                ),
                                items: _phases.map((p) {
                                  return DropdownMenuItem<String>(
                                    value: p['id'],
                                    child: Text(p['name']!),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() => _selectedPhase = val);
                                },
                              ),
                            ),
                            const SizedBox(height: AppDimension.space16),
                            GestureDetector(
                              onTap: () =>
                                  _selectDate(context, _arrivalDateController),
                              child: AbsorbPointer(
                                child: WatInputField(
                                  label: _selectedPhase == 'phase-1'
                                      ? 'Arrival Date (Optional)'
                                      : 'Arrival Date',
                                  hint: 'YYYY-MM-DD',
                                  controller: _arrivalDateController,
                                  errorText: _getError(state, 'arrivalDate'),
                                  suffixIcon: AppAssets.img(
                                    AppAssets.iconCalendar,
                                    size: 18,
                                    color: subtextColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppDimension.space16),
                            GestureDetector(
                              onTap: () => _selectDate(
                                context,
                                _jobStartDateController,
                              ),
                              child: AbsorbPointer(
                                child: WatInputField(
                                  label: _selectedPhase == 'phase-1'
                                      ? 'Job Start Date (Optional)'
                                      : 'Job Start Date',
                                  hint: 'YYYY-MM-DD',
                                  controller: _jobStartDateController,
                                  errorText: _getError(state, 'jobStartDate'),
                                  suffixIcon: AppAssets.img(
                                    AppAssets.iconCalendar,
                                    size: 18,
                                    color: subtextColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppDimension.space24),
                      WatButton(
                        label: 'Next >',
                        isLoading: isLoading,
                        onPressed: () => _validateAndNext(state),
                      ),
                    ] else ...[
                      // ─── OTP Step ───
                      PixelDialogBox(
                        title: 'VERIFY EMAIL',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'We sent a 6-digit code to:',
                              style: GoogleFonts.pressStart2p(
                                fontSize: 8,
                                color: subtextColor,
                                height: 2.0,
                              ),
                            ),
                            const SizedBox(height: AppDimension.space8),
                            Text(
                              _emailController.text,
                              style: GoogleFonts.pressStart2p(
                                fontSize: 8,
                                color: AppColors.primary,
                                height: 1.8,
                              ),
                            ),
                            const SizedBox(height: AppDimension.space24),
                            WatInputField(
                              label: 'OTP Code',
                              hint: 'enter 6-digit code',
                              controller: _otpController,
                              errorText: _getError(state, 'otp'),
                              autocorrect: false,
                              enableSuggestions: false,
                              keyboardType: TextInputType.number,
                              onChanged: (_) {
                                if (_otpError != null) {
                                  setState(() => _otpError = null);
                                }
                              },
                            ),
                            const SizedBox(height: AppDimension.space24),
                            WatButton(
                              label: 'Verify & Sign Up',
                              isLoading: isLoading,
                              onPressed: () {
                                final otp = _otpController.text.trim();
                                if (otp != '123456') {
                                  setState(() {
                                    _otpError = 'Invalid OTP. Use 123456';
                                  });
                                  return;
                                }
                                context.read<LoginBloc>().add(
                                      RegisterSubmittedEvent(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                        firstName:
                                            _usernameController.text.trim(),
                                        lastName: '',
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: AppDimension.space24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'HAVE ACCOUNT?  ',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 7,
                            color: subtextColor,
                            height: 1.8,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Text(
                            'SIGN IN',
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
}
