import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/expense/create_expense_request.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_event.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_state.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/split_member_input_row.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
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
  late final ExpenseSharingBloc _bloc;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ExpenseSharingBloc>();
    // Set default split values if total amount is typed
    _amountController.addListener(_onAmountChanged);
  }

  void _onAmountChanged() {
    final total = double.tryParse(_amountController.text) ?? 0.0;
    if (total > 0) {
      // Split equally between owner and selected members
      int selectedCount = 1; // count the owner
      for (var selected in _memberSelected) {
        if (selected) selectedCount++;
      }
      final splitAmount = (total / selectedCount).toStringAsFixed(2);
      for (int i = 0; i < _memberControllers.length; i++) {
        if (_memberSelected[i]) {
          _memberControllers[i].text = splitAmount;
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _amountController.removeListener(_onAmountChanged);
    for (var controller in _memberControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    final totalAmount = double.tryParse(_amountController.text) ?? 0.0;

    if (title.isEmpty) {
      AppPopup.show(
        context: context,
        type: AppPopupType.warning,
        title: 'Validation',
        message: 'Please enter a description.',
        buttons: [AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context))],
      );
      return;
    }

    if (totalAmount <= 0) {
      AppPopup.show(
        context: context,
        type: AppPopupType.warning,
        title: 'Validation',
        message: 'Please enter a valid amount.',
        buttons: [AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context))],
      );
      return;
    }

    final splits = <ExpenseSplitRequest>[];
    final memberIds = ['usr_alex', 'usr_maria'];
    for (int i = 0; i < _memberSelected.length; i++) {
      if (_memberSelected[i]) {
        final owe = double.tryParse(_memberControllers[i].text) ?? 0.0;
        if (owe > 0) {
          splits.add(ExpenseSplitRequest(userId: memberIds[i], oweAmount: owe));
        }
      }
    }

    if (splits.isEmpty) {
      AppPopup.show(
        context: context,
        type: AppPopupType.warning,
        title: 'Validation',
        message: 'Please split with at least one member with amount > 0.',
        buttons: [AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context))],
      );
      return;
    }

    final todayPlus7 = DateTime.now().add(const Duration(days: 7));
    final dueDateStr = DateFormat('yyyy-MM-dd').format(todayPlus7);

    setState(() => _isSubmitting = true);

    _bloc.add(
      CreateExpenseSubmitted(
        CreateExpenseRequest(
          title: title,
          totalAmount: totalAmount,
          currency: 'USD',
          dueDate: dueDateStr,
          splits: splits,
          memo: 'General',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<ExpenseSharingBloc, ExpenseSharingState>(
        listener: (context, state) {
          if (state is CreateExpenseSuccess) {
            setState(() => _isSubmitting = false);
            Navigator.pop(context);
          } else if (state is ExpenseSharingFailure) {
            setState(() => _isSubmitting = false);
            AppPopup.show(
              context: context,
              type: AppPopupType.error,
              title: 'Error',
              message: state.message,
              buttons: [AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context))],
            );
          }
        },
        child: Scaffold(
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
                    onSelected: (val) {
                      setState(() => _memberSelected[0] = val ?? false);
                      _onAmountChanged();
                    },
                  ),
                  SplitMemberInputRow(
                    name: 'Maria Garcia',
                    amountController: _memberControllers[1],
                    isSelected: _memberSelected[1],
                    onSelected: (val) {
                      setState(() => _memberSelected[1] = val ?? false);
                      _onAmountChanged();
                    },
                  ),
                  const SizedBox(height: AppDimension.space32),
                  WatButton(
                    label: 'Create Bill',
                    isLoading: _isSubmitting,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: AppDimension.space50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
