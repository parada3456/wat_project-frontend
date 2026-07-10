import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/split_member_input_row.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class CreateExpensePage extends StatefulWidget {
  const CreateExpensePage({super.key});

  @override
  State<CreateExpensePage> createState() => _CreateExpensePageState();
}

class _CreateExpensePageState extends State<CreateExpensePage> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final List<TextEditingController> _memberControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List<bool> _memberSelected = [true, true];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    for (var controller in _memberControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Expense',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimension.space32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WatInputField(
                label: 'Description',
                hint: 'e.g. Pizza Night',
                controller: _titleController,
              ),
              const SizedBox(height: AppDimension.space16),
              WatInputField(
                label: 'Total Amount',
                hint: '0.00',
                controller: _amountController,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    '\$',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: AppDimension.space32),
              const Text(
                'Split with Friends',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimension.space16),
              SplitMemberInputRow(
                name: 'Alex Smith',
                amountController: _memberControllers[0],
                isSelected: _memberSelected[0],
                onSelected: (val) =>
                    setState(() => _memberSelected[0] = val ?? false),
              ),
              SplitMemberInputRow(
                name: 'Maria Garcia',
                amountController: _memberControllers[1],
                isSelected: _memberSelected[1],
                onSelected: (val) =>
                    setState(() => _memberSelected[1] = val ?? false),
              ),
              const SizedBox(height: AppDimension.space32),
              WatButton(
                label: 'Create Bill',
                onPressed: () {
                  // TODO: Implement Create Expense
                },
              ),
              const SizedBox(height: AppDimension.space50),
            ],
          ),
        ),
      ),
    );
  }
}
