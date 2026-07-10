import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/admin_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/expense_usecases.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_event.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/bloc/expense_sharing_state.dart';

class ExpenseSharingBloc
    extends Bloc<ExpenseSharingEvent, ExpenseSharingState> {
  final ListExpensesUseCase _listExpensesUseCase;
  final CreateExpenseUseCase _createExpenseUseCase;
  final GetExpenseDetailUseCase _getExpenseDetailUseCase;
  final DeleteExpenseUseCase _deleteExpenseUseCase;
  final ListPendingSplitsUseCase _listPendingSplitsUseCase;
  final PayExpenseSplitUseCase _payExpenseSplitUseCase;
  final ApproveExpenseSplitPaymentUseCase _approveExpenseSplitPaymentUseCase;

  ExpenseSharingBloc(
    this._listExpensesUseCase,
    this._createExpenseUseCase,
    this._getExpenseDetailUseCase,
    this._deleteExpenseUseCase,
    this._listPendingSplitsUseCase,
    this._payExpenseSplitUseCase,
    this._approveExpenseSplitPaymentUseCase,
  ) : super(const ExpenseSharingInitial()) {
    on<ListExpensesRequested>(_onListExpenses);
    on<CreateExpenseSubmitted>(_onCreateExpense);
    on<GetExpenseDetailRequested>(_onGetExpenseDetail);
    on<DeleteExpenseSubmitted>(_onDeleteExpense);
    on<ListPendingSplitsRequested>(_onListPendingSplits);
    on<PayExpenseSplitSubmitted>(_onPayExpenseSplit);
    on<ApproveExpenseSplitPaymentSubmitted>(_onApproveExpenseSplitPayment);
  }

  Future<void> _onListExpenses(
    ListExpensesRequested event,
    Emitter<ExpenseSharingState> emit,
  ) async {
    emit(const ExpenseSharingLoading());
    final result = await _listExpensesUseCase();
    result.fold(
      (failure) => emit(ExpenseSharingFailure(failure.message)),
      (expenses) => emit(ListExpensesSuccess(expenses)),
    );
  }

  Future<void> _onCreateExpense(
    CreateExpenseSubmitted event,
    Emitter<ExpenseSharingState> emit,
  ) async {
    emit(const ExpenseSharingLoading());
    final result = await _createExpenseUseCase(event.request);
    result.fold(
      (failure) => emit(ExpenseSharingFailure(failure.message)),
      (_) => emit(const CreateExpenseSuccess()),
    );
  }

  Future<void> _onGetExpenseDetail(
    GetExpenseDetailRequested event,
    Emitter<ExpenseSharingState> emit,
  ) async {
    emit(const ExpenseSharingLoading());
    final result = await _getExpenseDetailUseCase(event.id);
    result.fold(
      (failure) => emit(ExpenseSharingFailure(failure.message)),
      (detail) => emit(GetExpenseDetailSuccess(detail)),
    );
  }

  Future<void> _onDeleteExpense(
    DeleteExpenseSubmitted event,
    Emitter<ExpenseSharingState> emit,
  ) async {
    emit(const ExpenseSharingLoading());
    final result = await _deleteExpenseUseCase(event.id);
    result.fold(
      (failure) => emit(ExpenseSharingFailure(failure.message)),
      (_) => emit(const DeleteExpenseSuccess()),
    );
  }

  Future<void> _onListPendingSplits(
    ListPendingSplitsRequested event,
    Emitter<ExpenseSharingState> emit,
  ) async {
    emit(const ExpenseSharingLoading());
    final result = await _listPendingSplitsUseCase();
    result.fold(
      (failure) => emit(ExpenseSharingFailure(failure.message)),
      (splits) => emit(ListPendingSplitsSuccess(splits)),
    );
  }

  Future<void> _onPayExpenseSplit(
    PayExpenseSplitSubmitted event,
    Emitter<ExpenseSharingState> emit,
  ) async {
    emit(const ExpenseSharingLoading());
    final result = await _payExpenseSplitUseCase(
      event.expenseId,
      event.splitId,
      event.file,
    );
    result.fold(
      (failure) => emit(ExpenseSharingFailure(failure.message)),
      (_) => emit(const PayExpenseSplitSuccess()),
    );
  }

  Future<void> _onApproveExpenseSplitPayment(
    ApproveExpenseSplitPaymentSubmitted event,
    Emitter<ExpenseSharingState> emit,
  ) async {
    emit(const ExpenseSharingLoading());
    final result = await _approveExpenseSplitPaymentUseCase(
      event.expenseId,
      event.splitId,
    );
    result.fold(
      (failure) => emit(ExpenseSharingFailure(failure.message)),
      (_) => emit(const ApproveExpenseSplitPaymentSuccess()),
    );
  }
}
