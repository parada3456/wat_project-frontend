import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/expense/create_expense_request.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/friendship_mock.dart';

class CreateExpenseFormController {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final memoController = TextEditingController();
  final searchController = TextEditingController();

  String selectedCurrency = 'USD';
  DateTime? selectedDueDate = DateTime.now().add(const Duration(days: 7));
  bool equalSplit = true;

  final Set<String> selectedFriendIds = {'usr_alex', 'usr_maria'};
  final Map<String, TextEditingController> oweControllers = {};

  CreateExpenseFormController() {
    for (final friend in allFriendsMock) {
      oweControllers[friend.userId] = TextEditingController();
    }
  }

  void dispose() {
    titleController.dispose();
    amountController.dispose();
    memoController.dispose();
    searchController.dispose();
    for (final controller in oweControllers.values) {
      controller.dispose();
    }
  }

  void updateSplitAmounts() {
    if (!equalSplit) return;
    final total = double.tryParse(amountController.text) ?? 0.0;
    if (total > 0) {
      final selectedCount = 1 + selectedFriendIds.length;
      final splitAmount = (total / selectedCount).toStringAsFixed(2);
      for (final friendId in oweControllers.keys) {
        if (selectedFriendIds.contains(friendId)) {
          oweControllers[friendId]?.text = splitAmount;
        } else {
          oweControllers[friendId]?.clear();
        }
      }
    } else {
      for (final controller in oweControllers.values) {
        controller.clear();
      }
    }
  }

  CreateExpenseRequest? validateAndCreateRequest(
    void Function(String, String) onError,
  ) {
    final title = titleController.text.trim();
    final totalAmount = double.tryParse(amountController.text) ?? 0.0;

    if (title.isEmpty) {
      onError('Validation', 'Please enter a Title.');
      return null;
    }
    if (totalAmount <= 0) {
      onError('Validation', 'Please enter a valid amount.');
      return null;
    }
    if (selectedDueDate == null) {
      onError('Validation', 'Please select a due date.');
      return null;
    }

    final splits = <ExpenseSplitRequest>[];
    for (final friendId in selectedFriendIds) {
      final owe = double.tryParse(oweControllers[friendId]?.text ?? '') ?? 0.0;
      if (owe > 0) {
        splits.add(ExpenseSplitRequest(userId: friendId, oweAmount: owe));
      }
    }

    if (splits.isEmpty) {
      onError(
        'Validation',
        'Please split with at least one member with amount > 0.',
      );
      return null;
    }

    final dueDateStr = DateFormat('yyyy-MM-dd').format(selectedDueDate!);
    return CreateExpenseRequest(
      title: title,
      totalAmount: totalAmount,
      currency: selectedCurrency,
      dueDate: dueDateStr,
      splits: splits,
      memo: memoController.text.trim().isEmpty
          ? 'General'
          : memoController.text.trim(),
    );
  }
}
