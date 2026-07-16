import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

enum AppPopupType { success, error, warning, info, none }

class AppPopupButton {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final Color? color;
  final String? path;
  final Map<String, String>? pathParameters;
  final Map<String, String>? queryParameters;
  final Object? extra;
  final bool replacement;
  final bool autoPop;

  const AppPopupButton({
    required this.label,
    this.onPressed,
    this.isPrimary = false,
    this.color,
    this.path,
    this.pathParameters,
    this.queryParameters,
    this.extra,
    this.replacement = false,
    this.autoPop = true,
  });
}

/// AppPopup — Pixel RPG dialog box (NPC speech / system alert style).
class AppPopup extends StatelessWidget {
  final String title;
  final String message;
  final AppPopupType type;
  final List<AppPopupButton> buttons;
  final Widget? content;

  const AppPopup({
    super.key,
    required this.title,
    required this.message,
    required this.buttons,
    this.type = AppPopupType.none,
    this.content,
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
    Widget? content,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (context) => AppPopup(
        title: title,
        message: message,
        type: type,
        buttons: buttons,
        content: content,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subtextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: PixelDialogBox(
        title: _typeLabel(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (type != AppPopupType.none) ...[
              _buildTypeIndicator(context),
              const SizedBox(height: AppDimension.space12),
            ],
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                fontSize: 10,
                color: textColor,
                height: 1.8,
              ),
            ),
            const SizedBox(height: AppDimension.space8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 8,
                color: subtextColor,
                height: 2.0,
              ),
            ),
            if (content != null) ...[
              const SizedBox(height: AppDimension.space12),
              content!,
            ],
            const SizedBox(height: AppDimension.space20),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  String? _typeLabel() {
    switch (type) {
      case AppPopupType.success:
        return 'SYSTEM';
      case AppPopupType.error:
        return 'ERROR';
      case AppPopupType.warning:
        return 'WARNING';
      case AppPopupType.info:
        return 'INFO';
      case AppPopupType.none:
        return null;
    }
  }

  Widget _buildTypeIndicator(BuildContext context) {
    final (String symbol, Color color) = switch (type) {
      AppPopupType.success => ('OK', AppColors.success),
      AppPopupType.error => ('!!', AppColors.error),
      AppPopupType.warning => ('??', AppColors.warning),
      AppPopupType.info => ('>>', AppColors.info),
      AppPopupType.none => ('', Colors.transparent),
    };

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: AppDimension.pixelBorderWidth),
      ),
      alignment: Alignment.center,
      child: Text(
        symbol,
        style: GoogleFonts.pressStart2p(
          fontSize: 14,
          color: color,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (buttons.length == 3) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: buttons.map((b) {
          final isLast = b == buttons.last;
          return Padding(
            padding: EdgeInsets.only(
              bottom: isLast ? 0 : AppDimension.space8,
            ),
            child: SizedBox(
              width: double.infinity,
              child: _buildSingleButton(context, b),
            ),
          );
        }).toList(),
      );
    }

    return Row(
      children: buttons.map((b) {
        final isFirst = b == buttons.first;
        final isMulti = buttons.length > 1;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: isFirst && isMulti ? AppDimension.space4 : 0,
              left: !isFirst && isMulti ? AppDimension.space4 : 0,
            ),
            child: _buildSingleButton(context, b),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSingleButton(BuildContext context, AppPopupButton button) {
    void action() {
      // if (button.autoPop) context.pop();
      button.onPressed?.call();
      if (button.path != null) {
        var url = button.path!;
        if (button.pathParameters != null) {
          button.pathParameters!.forEach((key, value) {
            url = url.replaceAll(':$key', Uri.encodeComponent(value));
          });
        }
        if (button.queryParameters != null &&
            button.queryParameters!.isNotEmpty) {
          final uri = Uri.parse(url);
          final combined = {...uri.queryParameters, ...button.queryParameters!};
          url = uri.replace(queryParameters: combined).toString();
        }
        if (button.replacement) {
          context.replace(url, extra: button.extra);
        } else {
          context.push(url, extra: button.extra);
        }
      }
    }

    if (button.isPrimary) {
      return WatButton(
        label: button.label,
        onPressed: action,
        backgroundColor: button.color ?? AppColors.primary,
        textColor: AppColors.black,
      );
    } else {
      return WatButton.outlined(
        label: button.label,
        onPressed: action,
        borderColor: button.color,
        textColor: button.color,
      );
    }
  }
}
