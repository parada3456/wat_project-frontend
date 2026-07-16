import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class ErrorPage extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const ErrorPage({super.key, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pixel "!" exclamation icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.error,
                  width: AppDimension.pixelBorderWidth,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '!',
                style: GoogleFonts.pressStart2p(
                  fontSize: 32,
                  color: AppColors.error,
                ),
              ),
            ),
            const SizedBox(height: AppDimension.space16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimension.space12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: AppDimension.pixelBorderWidth,
                ),
              ),
              child: Text(
                message?.toUpperCase() ?? 'SOMETHING WENT WRONG',
                textAlign: TextAlign.center,
                style: GoogleFonts.pressStart2p(
                  fontSize: 8,
                  color: textColor,
                  height: 2.0,
                ),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimension.space16),
              WatButton(label: 'RETRY', onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}
