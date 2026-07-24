import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class EqualSplitToggle extends StatelessWidget {
  final bool equalSplit;
  final ValueChanged<bool> onChanged;

  const EqualSplitToggle({
    super.key,
    required this.equalSplit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Split Equally (หารเท่า)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Auto-calculate equal shares',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
        Switch.adaptive(
          value: equalSplit,
          activeTrackColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
