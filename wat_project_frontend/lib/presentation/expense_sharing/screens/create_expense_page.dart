import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/expense/create_expense_request.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_bloc.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_event.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_state.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class FriendshipMock {
  final String userId;
  final String name;

  const FriendshipMock({required this.userId, required this.name});
}

const List<FriendshipMock> _allFriendsMock = [
  FriendshipMock(userId: 'usr_alex', name: 'Alex Smith'),
  FriendshipMock(userId: 'usr_maria', name: 'Maria Garcia'),
  FriendshipMock(userId: 'usr_john', name: 'John Doe'),
  FriendshipMock(userId: 'usr_jane', name: 'Jane Doe'),
  FriendshipMock(userId: 'usr_somsak', name: 'Somsak Saetang'),
  FriendshipMock(userId: 'usr_somchai', name: 'Somchai Rakdee'),
];

class CreateExpensePage extends StatefulWidget {
  const CreateExpensePage({super.key});

  @override
  State<CreateExpensePage> createState() => _CreateExpensePageState();
}

class _CreateExpensePageState extends State<CreateExpensePage> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _memoController = TextEditingController();
  final _searchController = TextEditingController();
  
  String _selectedCurrency = 'USD';
  DateTime? _selectedDueDate;
  bool _equalSplit = true;
  
  final Set<String> _selectedFriendIds = {'usr_alex', 'usr_maria'};
  final Map<String, TextEditingController> _oweControllers = {};
  
  late final ExpenseSharingBloc _bloc;
  bool _isSubmitting = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ExpenseSharingBloc>();
    
    _amountController.addListener(_onAmountOrSplitChanged);
    _searchController.addListener(_onSearchChanged);
    
    // Initialize default owe controllers
    for (final friend in _allFriendsMock) {
      _oweControllers[friend.userId] = TextEditingController();
    }
    
    // Setup initial due date (today + 7 days)
    _selectedDueDate = DateTime.now().add(const Duration(days: 7));
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onAmountOrSplitChanged();
    });
  }

  void _onAmountOrSplitChanged() {
    if (!_equalSplit) return;
    
    final total = double.tryParse(_amountController.text) ?? 0.0;
    if (total > 0) {
      final selectedCount = 1 + _selectedFriendIds.length;
      final splitAmount = (total / selectedCount).toStringAsFixed(2);
      
      for (final friendId in _oweControllers.keys) {
        if (_selectedFriendIds.contains(friendId)) {
          _oweControllers[friendId]?.text = splitAmount;
        } else {
          _oweControllers[friendId]?.clear();
        }
      }
    } else {
      for (final controller in _oweControllers.values) {
        controller.clear();
      }
    }
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _memoController.dispose();
    _searchController.dispose();
    for (final controller in _oweControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  void _submit() {
    final title = _titleController.text.trim();
    final totalAmount = double.tryParse(_amountController.text) ?? 0.0;

    if (title.isEmpty) {
      _showWarning('Validation', 'Please enter a description.');
      return;
    }

    if (totalAmount <= 0) {
      _showWarning('Validation', 'Please enter a valid amount.');
      return;
    }

    if (_selectedDueDate == null) {
      _showWarning('Validation', 'Please select a due date.');
      return;
    }

    final splits = <ExpenseSplitRequest>[];
    for (final friendId in _selectedFriendIds) {
      final owe = double.tryParse(_oweControllers[friendId]?.text ?? '') ?? 0.0;
      if (owe > 0) {
        splits.add(ExpenseSplitRequest(userId: friendId, oweAmount: owe));
      }
    }

    if (splits.isEmpty) {
      _showWarning('Validation', 'Please split with at least one member with amount > 0.');
      return;
    }

    final dueDateStr = DateFormat('yyyy-MM-dd').format(_selectedDueDate!);

    setState(() => _isSubmitting = true);

    _bloc.add(
      ExpenseSharingEvent.createExpenseSubmitted(
        CreateExpenseRequest(
          title: title,
          totalAmount: totalAmount,
          currency: _selectedCurrency,
          dueDate: dueDateStr,
          splits: splits,
          memo: _memoController.text.trim().isEmpty ? 'General' : _memoController.text.trim(),
        ),
      ),
    );
  }

  void _showWarning(String title, String message) {
    AppPopup.show<void>(
      context: context,
      type: AppPopupType.warning,
      title: title,
      message: message,
      buttons: [
        AppPopupButton(
          label: 'OK', 
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredFriends = _allFriendsMock.where((friend) {
      return friend.name.toLowerCase().contains(_searchQuery);
    }).toList();

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<ExpenseSharingBloc, ExpenseSharingState>(
        listener: (context, state) {
          state.whenOrNull(
            createExpenseSuccess: () {
              setState(() => _isSubmitting = false);
              Navigator.pop(context);
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
                  )
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
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.space16,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Core Fields Card
                  Card(
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
                            label: 'Description',
                            hint: 'e.g. Pizza Night',
                            controller: _titleController,
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
                                  controller: _amountController,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                                        borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                                        border: Border.all(color: Colors.grey[300]!),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _selectedCurrency,
                                          isExpanded: true,
                                          items: ['USD', 'THB', 'EUR', 'JPY', 'GBP']
                                              .map((c) => DropdownMenuItem(
                                                    value: c,
                                                    child: Text(c, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                  ))
                                              .toList(),
                                          onChanged: (val) {
                                            if (val != null) {
                                              setState(() => _selectedCurrency = val);
                                            }
                                          },
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
                            controller: _memoController,
                          ),
                          const SizedBox(height: AppDimension.space16),
                          // Due Date Selector
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
                                    _selectedDueDate == null
                                        ? 'Not Selected'
                                        : DateFormat.yMMMMd().format(_selectedDueDate!),
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
                                    borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                                  ),
                                ),
                                onPressed: () => _selectDueDate(context),
                                icon: const Icon(Icons.calendar_today, size: 16),
                                label: const Text('Pick Date'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  
                  // Equal Split Control
                  Row(
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
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: _equalSplit,
                        activeColor: AppColors.primary,
                        onChanged: (val) {
                          setState(() {
                            _equalSplit = val;
                          });
                          _onAmountOrSplitChanged();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimension.space16),

                  // Search Friend Box
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search friends by name...',
                      prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      filled: true,
                      fillColor: AppColors.backgroundAlt,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space16),

                  // Friend Split List
                  const Text(
                    'Split Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space8),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredFriends.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final friend = filteredFriends[index];
                      final isSelected = _selectedFriendIds.contains(friend.userId);
                      final oweController = _oweControllers[friend.userId]!;
                      
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: AppDimension.space8),
                        child: Row(
                          children: [
                            Checkbox(
                              value: isSelected,
                              activeColor: AppColors.primary,
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    _selectedFriendIds.add(friend.userId);
                                  } else {
                                    _selectedFriendIds.remove(friend.userId);
                                    oweController.clear();
                                  }
                                });
                                _onAmountOrSplitChanged();
                              },
                            ),
                            const SizedBox(width: AppDimension.space8),
                            Expanded(
                              child: Text(
                                friend.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (isSelected)
                              SizedBox(
                                width: 110,
                                height: 44,
                                child: TextField(
                                  controller: oweController,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  textAlign: TextAlign.end,
                                  readOnly: _equalSplit,
                                  decoration: InputDecoration(
                                    prefixText: _selectedCurrency == 'USD' ? '\$ ' : '$_selectedCurrency ',
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                                    ),
                                    fillColor: _equalSplit ? Colors.grey[100] : Colors.white,
                                    filled: true,
                                  ),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  onChanged: (val) {
                                    if (!_equalSplit) {
                                      // recalculate total amount optionally, or let manual edit stand
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
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
