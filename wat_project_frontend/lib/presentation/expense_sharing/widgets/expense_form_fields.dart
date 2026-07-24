import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class ExpenseFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final TextEditingController memoController;
  final String selectedCurrency;
  final ValueChanged<String?> onCurrencyChanged;
  final DateTime? selectedDueDate;
  final VoidCallback onSelectDueDate;

  const ExpenseFormFields({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.memoController,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
    required this.selectedDueDate,
    required this.onSelectDueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.backgroundAlt,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.space16),
        child: Column(
          children: [
            WatInputField(
              label: 'Title',
              hint: 'e.g. Pizza Night',
              controller: titleController,
            ),
            const SizedBox(height: AppDimension.space16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: WatInputField(
                    label: 'Total Amount',
                    hint: '0.00',
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimension.space12),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Currency',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                            AppDimension.radiusSmall,
                          ),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCurrency,
                            isExpanded: true,
                            items: const ['USD', 'THB', 'EUR', 'JPY', 'GBP']
                                .map(
                                  (c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(
                                      c,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: onCurrencyChanged,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimension.space16),
            WatInputField(
              label: 'Memo / Notes',
              hint: 'Add additional details...',
              controller: memoController,
            ),
            const SizedBox(height: AppDimension.space16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Due Date',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      selectedDueDate == null
                          ? 'Not Selected'
                          : DateFormat.yMMMMd().format(selectedDueDate!),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimension.radiusSmall,
                      ),
                    ),
                  ),
                  onPressed: onSelectDueDate,
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: const Text('Pick Date'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
