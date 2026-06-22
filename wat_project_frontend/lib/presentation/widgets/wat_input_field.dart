import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
class WatInputField extends StatelessWidget {
  final String label;
  final String hint;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const WatInputField({
    super.key,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimension.space4),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: AppDimension.space16),
          decoration: BoxDecoration(
            color: AppColors.backgroundAlt,
            borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
            border: errorText != null ? Border.all(color: Colors.red.shade300) : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (suffixIcon != null) suffixIcon!,
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: TextStyle(
              fontSize: 12,
              color: Colors.red.shade400,
            ),
          ),
        ]
      ],
    );
  }
}
