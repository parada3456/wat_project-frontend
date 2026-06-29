// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wat_project_frontend/di/inject.dart';
// import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
// import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
// import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
// import 'package:wat_project_frontend/utils/theme_constants.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _hometownController = TextEditingController();

//   String? _nameError;
//   String? _emailError;
//   String? _passwordError;
//   String? _hometownError;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _hometownController.dispose();
//     super.dispose();
//   }

//   String? _getError(LoginState state, String field) {
//     if (field == 'name' && _nameError != null) return _nameError;
//     if (field == 'email' && _emailError != null) return _emailError;
//     if (field == 'password' && _passwordError != null) return _passwordError;
//     if (field == 'hometown' && _hometownError != null) return _hometownError;

//     if (state is LoginFailure && state.apiError != null) {
//       try {
//         return state.apiError!.details.firstWhere((e) => e.field == field).reason;
//       } catch (_) {
//         return null;
//       }
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<LoginBloc>(),
//       child: Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: AppBar(
//           backgroundColor: AppColors.background,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: const Text(
//             'Create Account',
//             style: TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: BlocConsumer<LoginBloc, LoginState>(
//             listener: (context, state) {
//               if (state is LoginFailure) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(state.errorMessage),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//             },
//             builder: (context, state) {
//               final isLoading = state is LoginLoading;

//               return SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: AppDimension.space32),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: AppDimension.space32),
//                     // Avatar Picker Placeholder
//                     Center(
//                       child: Stack(
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 100,
//                             decoration: const BoxDecoration(
//                               color: AppColors.surface,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.person,
//                               size: 50,
//                               color: AppColors.white,
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: Container(
//                               padding: const EdgeInsets.all(AppDimension.space8),
//                               decoration: const BoxDecoration(
//                                 color: AppColors.primary,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 Icons.camera_alt,
//                                 size: 17,
//                                 color: AppColors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: AppDimension.space32),
//                     WatInputField(
//                       label: 'FullName',
//                       hint: 'Enter your name',
//                       controller: _nameController,
//                       errorText: _getError(state, 'name'),
//                       onChanged: (_) {
//                         if (_nameError != null) setState(() => _nameError = null);
//                       },
//                     ),
//                     const SizedBox(height: AppDimension.space16),
//                     WatInputField(
//                       label: 'Email',
//                       hint: 'username@email.com',
//                       controller: _emailController,
//                       errorText: _getError(state, 'email'),
//                       onChanged: (_) {
//                         if (_emailError != null) setState(() => _emailError = null);
//                       },
//                     ),
//                     const SizedBox(height: AppDimension.space16),
//                     WatInputField(
//                       label: 'Password',
//                       hint: 'Enter your password',
//                       controller: _passwordController,
//                       obscureText: true,
//                       errorText: _getError(state, 'password'),
//                       onChanged: (_) {
//                         if (_passwordError != null) setState(() => _passwordError = null);
//                       },
//                     ),
//                     const SizedBox(height: AppDimension.space16),
//                     WatInputField(
//                       label: 'HomeTown',
//                       hint: 'Select your hometown',
//                       controller: _hometownController,
//                       errorText: _getError(state, 'hometown'),
//                       onChanged: (_) {
//                         if (_hometownError != null) setState(() => _hometownError = null);
//                       },
//                       suffixIcon: const Icon(
//                         Icons.keyboard_arrow_down,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     const SizedBox(height: AppDimension.space32),
//                     WatButton(
//                       label: 'SignUp',
//                       isLoading: isLoading,
//                       onPressed: () {
//                         final fullName = _nameController.text.trim();
//                         final email = _emailController.text.trim();
//                         final password = _passwordController.text.trim();
//                         final hometown = _hometownController.text.trim();

//                         setState(() {
//                           _nameError = null;
//                           _emailError = null;
//                           _passwordError = null;
//                           _hometownError = null;
//                         });

//                         bool isValid = true;
//                         final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

//                         if (fullName.isEmpty) {
//                           _nameError = 'Name is required';
//                           isValid = false;
//                         }

//                         if (email.isEmpty) {
//                           _emailError = 'Email is required';
//                           isValid = false;
//                         } else if (!emailRegex.hasMatch(email)) {
//                           _emailError = 'Enter a valid email format';
//                           isValid = false;
//                         }

//                         if (password.isEmpty) {
//                           _passwordError = 'Password is required';
//                           isValid = false;
//                         } else if (password.length < 8) {
//                           _passwordError = 'Password must be at least 8 characters';
//                           isValid = false;
//                         }

//                         if (!isValid) {
//                           setState(() {});
//                           return;
//                         }

//                         // Split full name into first name and last name
//                         final nameParts = fullName.split(' ');
//                         final firstName = nameParts.first;
//                         final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

//                         context.read<LoginBloc>().add(
//                               RegisterSubmittedEvent(
//                                 email: email,
//                                 password: password,
//                                 firstName: firstName,
//                                 lastName: lastName,
//                               ),
//                             );
//                       },
//                     ),
//                     const SizedBox(height: AppDimension.space32),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Already have an account? ",
//                           style: TextStyle(color: AppColors.textSecondary),
//                         ),
//                         GestureDetector(
//                           onTap: () => Navigator.pop(context),
//                           child: const Text(
//                             'SignIn',
//                             style: TextStyle(
//                               color: AppColors.primary,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: AppDimension.space50),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
