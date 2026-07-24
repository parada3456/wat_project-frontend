import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class SplitMemberInputRow extends StatelessWidget {
  final String name;
  final TextEditingController amountController;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;

  const SplitMemberInputRow({
    super.key,
    required this.name,
    required this.amountController,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimension.space8),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onSelected,
            activeColor: AppColors.primary,
          ),
          const SizedBox(width: AppDimension.space8),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (isSelected)
            SizedBox(
              width: 100,
              height: 40,
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  prefixText: '\$ ',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimension.radiusSmall,
                    ),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}
