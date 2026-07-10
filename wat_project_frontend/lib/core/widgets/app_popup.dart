import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

enum AppPopupType { success, error, warning, info, none }

class AppPopupButton {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Color? color;

  const AppPopupButton({
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
    this.color,
  });
}

class AppPopup extends StatelessWidget {
  final String title;
  final String message;
  final AppPopupType type;
  final List<AppPopupButton> buttons;

  const AppPopup({
    super.key,
    required this.title,
    required this.message,
    required this.buttons,
    this.type = AppPopupType.none,
  }) : assert(
         buttons.length >= 1 && buttons.length <= 3,
         'AppPopup must have between 1 and 3 buttons',
       );

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    AppPopupType type = AppPopupType.none,
    required List<AppPopupButton> buttons,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppPopup(
        title: title,
        message: message,
        type: type,
        buttons: buttons,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimension.radiusLarge),
      ),
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColors.white,
      elevation: 8,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        padding: const EdgeInsets.all(AppDimension.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (type != AppPopupType.none) ...[
              _buildIcon(context),
              const SizedBox(height: AppDimension.space16),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style:
                  theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.blackText,
                  ) ??
                  TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.blackText,
                  ),
            ),
            const SizedBox(height: AppDimension.space10),
            Text(
              message,
              textAlign: TextAlign.center,
              style:
                  theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.grey[300] : AppColors.textSecondary,
                  ) ??
                  TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[300] : AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppDimension.space32),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    IconData iconData;
    Color iconColor;
    Color bgColor;

    switch (type) {
      case AppPopupType.success:
        iconData = Icons.check_circle_outline_rounded;
        iconColor = Colors.green;
        bgColor = Colors.green.withOpacity(0.1);
        break;
      case AppPopupType.error:
        iconData = Icons.error_outline_rounded;
        iconColor = AppColors.error;
        bgColor = AppColors.error.withOpacity(0.1);
        break;
      case AppPopupType.warning:
        iconData = Icons.warning_amber_rounded;
        iconColor = Colors.amber[800]!;
        bgColor = Colors.amber.withOpacity(0.1);
        break;
      case AppPopupType.info:
        iconData = Icons.info_outline_rounded;
        iconColor = Colors.blue;
        bgColor = Colors.blue.withOpacity(0.1);
        break;
      case AppPopupType.none:
        return const SizedBox.shrink();
    }

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(iconData, color: iconColor, size: 36),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (buttons.length == 3) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: buttons.map((button) {
          final isLast = button == buttons.last;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : AppDimension.space10),
            child: SizedBox(
              width: double.infinity,
              child: _buildSingleButton(context, button),
            ),
          );
        }).toList(),
      );
    }

    // 1 or 2 buttons
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons.map((button) {
        final isFirst = button == buttons.first;
        final isMulti = buttons.length > 1;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: isFirst && isMulti ? AppDimension.space10 / 2 : 0,
              left: !isFirst && isMulti ? AppDimension.space10 / 2 : 0,
            ),
            child: _buildSingleButton(context, button),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSingleButton(BuildContext context, AppPopupButton button) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (button.isPrimary) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: button.color ?? AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: AppDimension.space12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
          ),
        ),
        onPressed: button.onPressed,
        child: Text(
          button.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor:
              button.color ??
              (isDark ? Colors.grey[300] : AppColors.textPrimary),
          side: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          ),
          padding: const EdgeInsets.symmetric(vertical: AppDimension.space12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
          ),
        ),
        onPressed: button.onPressed,
        child: Text(
          button.label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }
  }
}
