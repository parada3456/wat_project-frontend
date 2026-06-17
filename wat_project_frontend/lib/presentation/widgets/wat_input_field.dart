import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
class WatInputField extends StatelessWidget {
  final String label;
  final String hint;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const WatInputField({
    super.key,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.onChanged,
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
      ],
    );
  }
}
