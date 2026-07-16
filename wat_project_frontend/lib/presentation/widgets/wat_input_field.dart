import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/extension/extension.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

/// WatInputField — Pixel RPG styled text input.
/// Hard-corner border that changes color on focus. Error state in red pixel font.
class WatInputField extends StatefulWidget {
  final String label;
  final String hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool enabled;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  const WatInputField({
    super.key,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.obscureText = false,
    this.onChanged,
    this.errorText,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.keyboardType,
    this.maxLines = 1,
    this.enabled = true,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  State<WatInputField> createState() => _WatInputFieldState();
}

class _WatInputFieldState extends State<WatInputField> {
  late final FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() => _hasFocus = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color borderColor = widget.errorText != null
        ? AppColors.error
        : _hasFocus
            ? AppColors.primary
            : (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    final Color bgColor =
        isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt;
    final Color textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final Color hintColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final Color labelColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Label ───
        Text(
          widget.label.toUpperCase(),
          style: context.textTheme.labelMedium?.copyWith(color: labelColor,),
        ),
        const SizedBox(height: AppDimension.space4),

        // ─── Input box with pixel border ───
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: borderColor,
              width: AppDimension.pixelBorderWidth,
            ),
          ),
          child: Row(
            children: [
              if (widget.prefixIcon != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.space8,
                  ),
                  child: widget.prefixIcon!,
                ),
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.obscureText,
                  onChanged: widget.onChanged,
                  autocorrect: widget.autocorrect,
                  enableSuggestions: widget.enableSuggestions,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.obscureText ? 1 : widget.maxLines,
                  enabled: widget.enabled,
                  focusNode: _focusNode,
                  textInputAction: widget.textInputAction,
                  onEditingComplete: widget.onEditingComplete,
                  style: context.textTheme.bodySmall?.copyWith(color: textColor,),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: context.textTheme.bodySmall?.copyWith(color: hintColor,),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDimension.space12,
                      vertical: AppDimension.space12,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              if (widget.suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.space8,
                  ),
                  child: widget.suffixIcon!,
                ),
            ],
          ),
        ),

        // ─── Error text ───
        if (widget.errorText != null) ...[
          const SizedBox(height: AppDimension.space4),
          Text(
            '! ${widget.errorText!}',
            style: context.textTheme.labelSmall?.copyWith(color: AppColors.error,),
          ),
        ],
      ],
    );
  }
}
