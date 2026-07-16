import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg(context),
      body: Center(
        child: Text(
          'PROFILE SCREEN',
          style: GoogleFonts.notoSansThai(
            fontSize: 10,
            color: AppColors.text(context),
          ),
        ),
      ),
    );
  }
}
