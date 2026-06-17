import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/bloc/login_bloc.dart';
import 'package:wat_project_frontend/presentation/auth_profile/login/ui/login_view.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<LoginBloc>(),
          child: const LoginView(),
        ),
      ),
    );
  }
}
