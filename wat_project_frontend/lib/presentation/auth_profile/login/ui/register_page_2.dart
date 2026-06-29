// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:wat_project_frontend/di/inject.dart';
// import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
// import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
// import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
// import 'package:wat_project_frontend/utils/theme_constants.dart';

// class RegisterPage2 extends StatefulWidget {
//   const RegisterPage2({super.key});

//   @override
//   State<RegisterPage2> createState() => _RegisterPage2State();
// }

// class _RegisterPage2State extends State<RegisterPage2> {
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   String? _firstNameError;
//   String? _lastNameError;
//   String? _emailError;
//   String? _passwordError;

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   String? _getError(LoginState state, String field) {
//     if (field == 'firstName' && _firstNameError != null) return _firstNameError;
//     if (field == 'lastName' && _lastNameError != null) return _lastNameError;
//     if (field == 'email' && _emailError != null) return _emailError;
//     if (field == 'password' && _passwordError != null) return _passwordError;

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
//             'Create Account (v2)',
//             style: TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.home, color: AppColors.textPrimary),
//               onPressed: () {
//                 context.push('/home');
//               },
//             ),
//           ],
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
//                       label: 'FirstName',
//                       hint: 'Enter your first name',
//                       controller: _firstNameController,
//                       errorText: _getError(state, 'firstName'),
//                       onChanged: (_) {
//                         if (_firstNameError != null) setState(() => _firstNameError = null);
//                       },
//                     ),
//                     const SizedBox(height: AppDimension.space16),
//                     WatInputField(
//                       label: 'LastName',
//                       hint: 'Enter your last name',
//                       controller: _lastNameController,
//                       errorText: _getError(state, 'lastName'),
//                       onChanged: (_) {
//                         if (_lastNameError != null) setState(() => _lastNameError = null);
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
//                     const SizedBox(height: AppDimension.space32),
//                     WatButton(
//                       label: 'SignUp',
//                       isLoading: isLoading,
//                       onPressed: () {
//                         final firstName = _firstNameController.text.trim();
//                         final lastName = _lastNameController.text.trim();
//                         final email = _emailController.text.trim();
//                         final password = _passwordController.text.trim();

//                         setState(() {
//                           _firstNameError = null;
//                           _lastNameError = null;
//                           _emailError = null;
//                           _passwordError = null;
//                         });

//                         bool isValid = true;
//                         final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

//                         if (firstName.isEmpty) {
//                           _firstNameError = 'First name is required';
//                           isValid = false;
//                         }

//                         if (lastName.isEmpty) {
//                           _lastNameError = 'Last name is required';
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
