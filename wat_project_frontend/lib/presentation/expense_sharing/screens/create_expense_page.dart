import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/expense_form_fields.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/equal_split_toggle.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/friend_split_list.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/friendship_mock.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/create_expense_form_controller.dart';

class CreateExpensePage extends StatefulWidget {
  const CreateExpensePage({super.key});

  @override
  State<CreateExpensePage> createState() => _CreateExpensePageState();
}

class _CreateExpensePageState extends State<CreateExpensePage> {
  final _formController = CreateExpenseFormController();
  late final ExpenseSharingBloc _bloc;
  bool _isSubmitting = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ExpenseSharingBloc>();
    _formController.amountController.addListener(_onAmountOrSplitChanged);
    _formController.searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _onAmountOrSplitChanged(),
    );
  }

  void _onAmountOrSplitChanged() => _formController.updateSplitAmounts();
  void _onSearchChanged() => setState(
    () => _searchQuery = _formController.searchController.text
        .trim()
        .toLowerCase(),
  );

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _formController.selectedDueDate ??
          DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _formController.selectedDueDate) {
      setState(() => _formController.selectedDueDate = picked);
    }
  }

  void _submit() {
    final request = _formController.validateAndCreateRequest(_showWarning);
    if (request == null) return;
    setState(() => _isSubmitting = true);
    _bloc.add(ExpenseSharingEvent.createExpenseSubmitted(request));
  }

  void _showWarning(String title, String message) {
    AppPopup.show<void>(
      context: context,
      type: AppPopupType.warning,
      title: title,
      message: message,
      buttons: [
        AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredFriends = allFriendsMock
        .where((f) => f.name.toLowerCase().contains(_searchQuery))
        .toList();

    return BlocProvider<ExpenseSharingBloc>(
      create: (context) => getIt<ExpenseSharingBloc>(),
      child: BlocListener<ExpenseSharingBloc, ExpenseSharingState>(
        listener: (context, state) {
          state.whenOrNull(
            createExpenseSuccess: () {
              setState(() => _isSubmitting = false);
              context.pop();
            },
            failure: (message) {
              setState(() => _isSubmitting = false);
              AppPopup.show<void>(
                context: context,
                type: AppPopupType.error,
                title: 'Error',
                message: message,
                buttons: [
                  AppPopupButton(
                    label: 'OK',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            },
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
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
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.space16,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpenseFormFields(
                    titleController: _formController.titleController,
                    amountController: _formController.amountController,
                    memoController: _formController.memoController,
                    selectedCurrency: _formController.selectedCurrency,
                    onCurrencyChanged: (val) {
                      if (val != null) {
                        setState(() => _formController.selectedCurrency = val);
                        _onAmountOrSplitChanged();
                      }
                    },
                    selectedDueDate: _formController.selectedDueDate,
                    onSelectDueDate: () => _selectDueDate(context),
                  ),
                  const SizedBox(height: 24.0),
                  EqualSplitToggle(
                    equalSplit: _formController.equalSplit,
                    onChanged: (val) {
                      setState(() => _formController.equalSplit = val);
                      _onAmountOrSplitChanged();
                    },
                  ),
                  const SizedBox(height: AppDimension.space16),
                  TextField(
                    controller: _formController.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search friends by name...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.textSecondary,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimension.radiusSmall,
                        ),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimension.radiusSmall,
                        ),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimension.radiusSmall,
                        ),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      filled: true,
                      fillColor: AppColors.backgroundAlt,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space16),
                  const Text(
                    'Split Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space8),
                  FriendSplitList(
                    filteredFriends: filteredFriends,
                    selectedFriendIds: _formController.selectedFriendIds,
                    oweControllers: _formController.oweControllers,
                    equalSplit: _formController.equalSplit,
                    selectedCurrency: _formController.selectedCurrency,
                    onFriendSelected: (friendId, isSelected) {
                      setState(() {
                        if (isSelected) {
                          _formController.selectedFriendIds.add(friendId);
                        } else {
                          _formController.selectedFriendIds.remove(friendId);
                          _formController.oweControllers[friendId]?.clear();
                        }
                      });
                      _onAmountOrSplitChanged();
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
