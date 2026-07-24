import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/extension/extension.dart';
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
                style: context.textTheme.displayLarge?.copyWith(color: AppColors.error,),
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
                style: context.textTheme.labelMedium?.copyWith(color: textColor,),
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
