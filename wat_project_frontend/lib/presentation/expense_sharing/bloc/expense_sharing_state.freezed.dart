// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_sharing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpenseSharingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSharingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingState()';
}


}

/// @nodoc
class $ExpenseSharingStateCopyWith<$Res>  {
$ExpenseSharingStateCopyWith(ExpenseSharingState _, $Res Function(ExpenseSharingState) __);
}


/// Adds pattern-matching-related methods to [ExpenseSharingState].
extension ExpenseSharingStatePatterns on ExpenseSharingState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExpenseSharingInitial value)?  initial,TResult Function( ExpenseSharingLoading value)?  loading,TResult Function( ListExpensesSuccess value)?  listExpensesSuccess,TResult Function( CreateExpenseSuccess value)?  createExpenseSuccess,TResult Function( GetExpenseDetailSuccess value)?  getExpenseDetailSuccess,TResult Function( DeleteExpenseSuccess value)?  deleteExpenseSuccess,TResult Function( ListPendingSplitsSuccess value)?  listPendingSplitsSuccess,TResult Function( PayExpenseSplitSuccess value)?  payExpenseSplitSuccess,TResult Function( ApproveExpenseSplitPaymentSuccess value)?  approveExpenseSplitPaymentSuccess,TResult Function( ExpenseSharingFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExpenseSharingInitial() when initial != null:
return initial(_that);case ExpenseSharingLoading() when loading != null:
return loading(_that);case ListExpensesSuccess() when listExpensesSuccess != null:
return listExpensesSuccess(_that);case CreateExpenseSuccess() when createExpenseSuccess != null:
return createExpenseSuccess(_that);case GetExpenseDetailSuccess() when getExpenseDetailSuccess != null:
return getExpenseDetailSuccess(_that);case DeleteExpenseSuccess() when deleteExpenseSuccess != null:
return deleteExpenseSuccess(_that);case ListPendingSplitsSuccess() when listPendingSplitsSuccess != null:
return listPendingSplitsSuccess(_that);case PayExpenseSplitSuccess() when payExpenseSplitSuccess != null:
return payExpenseSplitSuccess(_that);case ApproveExpenseSplitPaymentSuccess() when approveExpenseSplitPaymentSuccess != null:
return approveExpenseSplitPaymentSuccess(_that);case ExpenseSharingFailure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExpenseSharingInitial value)  initial,required TResult Function( ExpenseSharingLoading value)  loading,required TResult Function( ListExpensesSuccess value)  listExpensesSuccess,required TResult Function( CreateExpenseSuccess value)  createExpenseSuccess,required TResult Function( GetExpenseDetailSuccess value)  getExpenseDetailSuccess,required TResult Function( DeleteExpenseSuccess value)  deleteExpenseSuccess,required TResult Function( ListPendingSplitsSuccess value)  listPendingSplitsSuccess,required TResult Function( PayExpenseSplitSuccess value)  payExpenseSplitSuccess,required TResult Function( ApproveExpenseSplitPaymentSuccess value)  approveExpenseSplitPaymentSuccess,required TResult Function( ExpenseSharingFailure value)  failure,}){
final _that = this;
switch (_that) {
case ExpenseSharingInitial():
return initial(_that);case ExpenseSharingLoading():
return loading(_that);case ListExpensesSuccess():
return listExpensesSuccess(_that);case CreateExpenseSuccess():
return createExpenseSuccess(_that);case GetExpenseDetailSuccess():
return getExpenseDetailSuccess(_that);case DeleteExpenseSuccess():
return deleteExpenseSuccess(_that);case ListPendingSplitsSuccess():
return listPendingSplitsSuccess(_that);case PayExpenseSplitSuccess():
return payExpenseSplitSuccess(_that);case ApproveExpenseSplitPaymentSuccess():
return approveExpenseSplitPaymentSuccess(_that);case ExpenseSharingFailure():
return failure(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExpenseSharingInitial value)?  initial,TResult? Function( ExpenseSharingLoading value)?  loading,TResult? Function( ListExpensesSuccess value)?  listExpensesSuccess,TResult? Function( CreateExpenseSuccess value)?  createExpenseSuccess,TResult? Function( GetExpenseDetailSuccess value)?  getExpenseDetailSuccess,TResult? Function( DeleteExpenseSuccess value)?  deleteExpenseSuccess,TResult? Function( ListPendingSplitsSuccess value)?  listPendingSplitsSuccess,TResult? Function( PayExpenseSplitSuccess value)?  payExpenseSplitSuccess,TResult? Function( ApproveExpenseSplitPaymentSuccess value)?  approveExpenseSplitPaymentSuccess,TResult? Function( ExpenseSharingFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ExpenseSharingInitial() when initial != null:
return initial(_that);case ExpenseSharingLoading() when loading != null:
return loading(_that);case ListExpensesSuccess() when listExpensesSuccess != null:
return listExpensesSuccess(_that);case CreateExpenseSuccess() when createExpenseSuccess != null:
return createExpenseSuccess(_that);case GetExpenseDetailSuccess() when getExpenseDetailSuccess != null:
return getExpenseDetailSuccess(_that);case DeleteExpenseSuccess() when deleteExpenseSuccess != null:
return deleteExpenseSuccess(_that);case ListPendingSplitsSuccess() when listPendingSplitsSuccess != null:
return listPendingSplitsSuccess(_that);case PayExpenseSplitSuccess() when payExpenseSplitSuccess != null:
return payExpenseSplitSuccess(_that);case ApproveExpenseSplitPaymentSuccess() when approveExpenseSplitPaymentSuccess != null:
return approveExpenseSplitPaymentSuccess(_that);case ExpenseSharingFailure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ExpenseTransactionModel> expenses)?  listExpensesSuccess,TResult Function()?  createExpenseSuccess,TResult Function( ExpenseDetailModel expenseDetail)?  getExpenseDetailSuccess,TResult Function()?  deleteExpenseSuccess,TResult Function( List<ExpenseSplitModel> pendingSplits)?  listPendingSplitsSuccess,TResult Function()?  payExpenseSplitSuccess,TResult Function()?  approveExpenseSplitPaymentSuccess,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExpenseSharingInitial() when initial != null:
return initial();case ExpenseSharingLoading() when loading != null:
return loading();case ListExpensesSuccess() when listExpensesSuccess != null:
return listExpensesSuccess(_that.expenses);case CreateExpenseSuccess() when createExpenseSuccess != null:
return createExpenseSuccess();case GetExpenseDetailSuccess() when getExpenseDetailSuccess != null:
return getExpenseDetailSuccess(_that.expenseDetail);case DeleteExpenseSuccess() when deleteExpenseSuccess != null:
return deleteExpenseSuccess();case ListPendingSplitsSuccess() when listPendingSplitsSuccess != null:
return listPendingSplitsSuccess(_that.pendingSplits);case PayExpenseSplitSuccess() when payExpenseSplitSuccess != null:
return payExpenseSplitSuccess();case ApproveExpenseSplitPaymentSuccess() when approveExpenseSplitPaymentSuccess != null:
return approveExpenseSplitPaymentSuccess();case ExpenseSharingFailure() when failure != null:
return failure(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ExpenseTransactionModel> expenses)  listExpensesSuccess,required TResult Function()  createExpenseSuccess,required TResult Function( ExpenseDetailModel expenseDetail)  getExpenseDetailSuccess,required TResult Function()  deleteExpenseSuccess,required TResult Function( List<ExpenseSplitModel> pendingSplits)  listPendingSplitsSuccess,required TResult Function()  payExpenseSplitSuccess,required TResult Function()  approveExpenseSplitPaymentSuccess,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ExpenseSharingInitial():
return initial();case ExpenseSharingLoading():
return loading();case ListExpensesSuccess():
return listExpensesSuccess(_that.expenses);case CreateExpenseSuccess():
return createExpenseSuccess();case GetExpenseDetailSuccess():
return getExpenseDetailSuccess(_that.expenseDetail);case DeleteExpenseSuccess():
return deleteExpenseSuccess();case ListPendingSplitsSuccess():
return listPendingSplitsSuccess(_that.pendingSplits);case PayExpenseSplitSuccess():
return payExpenseSplitSuccess();case ApproveExpenseSplitPaymentSuccess():
return approveExpenseSplitPaymentSuccess();case ExpenseSharingFailure():
return failure(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ExpenseTransactionModel> expenses)?  listExpensesSuccess,TResult? Function()?  createExpenseSuccess,TResult? Function( ExpenseDetailModel expenseDetail)?  getExpenseDetailSuccess,TResult? Function()?  deleteExpenseSuccess,TResult? Function( List<ExpenseSplitModel> pendingSplits)?  listPendingSplitsSuccess,TResult? Function()?  payExpenseSplitSuccess,TResult? Function()?  approveExpenseSplitPaymentSuccess,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ExpenseSharingInitial() when initial != null:
return initial();case ExpenseSharingLoading() when loading != null:
return loading();case ListExpensesSuccess() when listExpensesSuccess != null:
return listExpensesSuccess(_that.expenses);case CreateExpenseSuccess() when createExpenseSuccess != null:
return createExpenseSuccess();case GetExpenseDetailSuccess() when getExpenseDetailSuccess != null:
return getExpenseDetailSuccess(_that.expenseDetail);case DeleteExpenseSuccess() when deleteExpenseSuccess != null:
return deleteExpenseSuccess();case ListPendingSplitsSuccess() when listPendingSplitsSuccess != null:
return listPendingSplitsSuccess(_that.pendingSplits);case PayExpenseSplitSuccess() when payExpenseSplitSuccess != null:
return payExpenseSplitSuccess();case ApproveExpenseSplitPaymentSuccess() when approveExpenseSplitPaymentSuccess != null:
return approveExpenseSplitPaymentSuccess();case ExpenseSharingFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ExpenseSharingInitial implements ExpenseSharingState {
  const ExpenseSharingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSharingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingState.initial()';
}


}




/// @nodoc


class ExpenseSharingLoading implements ExpenseSharingState {
  const ExpenseSharingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSharingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingState.loading()';
}


}




/// @nodoc


class ListExpensesSuccess implements ExpenseSharingState {
  const ListExpensesSuccess({required final  List<ExpenseTransactionModel> expenses}): _expenses = expenses;
  

 final  List<ExpenseTransactionModel> _expenses;
 List<ExpenseTransactionModel> get expenses {
  if (_expenses is EqualUnmodifiableListView) return _expenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expenses);
}


/// Create a copy of ExpenseSharingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListExpensesSuccessCopyWith<ListExpensesSuccess> get copyWith => _$ListExpensesSuccessCopyWithImpl<ListExpensesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListExpensesSuccess&&const DeepCollectionEquality().equals(other._expenses, _expenses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_expenses));

@override
String toString() {
  return 'ExpenseSharingState.listExpensesSuccess(expenses: $expenses)';
}


}

/// @nodoc
abstract mixin class $ListExpensesSuccessCopyWith<$Res> implements $ExpenseSharingStateCopyWith<$Res> {
  factory $ListExpensesSuccessCopyWith(ListExpensesSuccess value, $Res Function(ListExpensesSuccess) _then) = _$ListExpensesSuccessCopyWithImpl;
@useResult
$Res call({
 List<ExpenseTransactionModel> expenses
});




}
/// @nodoc
class _$ListExpensesSuccessCopyWithImpl<$Res>
    implements $ListExpensesSuccessCopyWith<$Res> {
  _$ListExpensesSuccessCopyWithImpl(this._self, this._then);

  final ListExpensesSuccess _self;
  final $Res Function(ListExpensesSuccess) _then;

/// Create a copy of ExpenseSharingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenses = null,}) {
  return _then(ListExpensesSuccess(
expenses: null == expenses ? _self._expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<ExpenseTransactionModel>,
  ));
}


}

/// @nodoc


class CreateExpenseSuccess implements ExpenseSharingState {
  const CreateExpenseSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateExpenseSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingState.createExpenseSuccess()';
}


}




/// @nodoc


class GetExpenseDetailSuccess implements ExpenseSharingState {
  const GetExpenseDetailSuccess({required this.expenseDetail});
  

 final  ExpenseDetailModel expenseDetail;

/// Create a copy of ExpenseSharingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetExpenseDetailSuccessCopyWith<GetExpenseDetailSuccess> get copyWith => _$GetExpenseDetailSuccessCopyWithImpl<GetExpenseDetailSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetExpenseDetailSuccess&&(identical(other.expenseDetail, expenseDetail) || other.expenseDetail == expenseDetail));
}


@override
int get hashCode => Object.hash(runtimeType,expenseDetail);

@override
String toString() {
  return 'ExpenseSharingState.getExpenseDetailSuccess(expenseDetail: $expenseDetail)';
}


}

/// @nodoc
abstract mixin class $GetExpenseDetailSuccessCopyWith<$Res> implements $ExpenseSharingStateCopyWith<$Res> {
  factory $GetExpenseDetailSuccessCopyWith(GetExpenseDetailSuccess value, $Res Function(GetExpenseDetailSuccess) _then) = _$GetExpenseDetailSuccessCopyWithImpl;
@useResult
$Res call({
 ExpenseDetailModel expenseDetail
});




}
/// @nodoc
class _$GetExpenseDetailSuccessCopyWithImpl<$Res>
    implements $GetExpenseDetailSuccessCopyWith<$Res> {
  _$GetExpenseDetailSuccessCopyWithImpl(this._self, this._then);

  final GetExpenseDetailSuccess _self;
  final $Res Function(GetExpenseDetailSuccess) _then;

/// Create a copy of ExpenseSharingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenseDetail = null,}) {
  return _then(GetExpenseDetailSuccess(
expenseDetail: null == expenseDetail ? _self.expenseDetail : expenseDetail // ignore: cast_nullable_to_non_nullable
as ExpenseDetailModel,
  ));
}


}

/// @nodoc


class DeleteExpenseSuccess implements ExpenseSharingState {
  const DeleteExpenseSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteExpenseSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingState.deleteExpenseSuccess()';
}


}




/// @nodoc


class ListPendingSplitsSuccess implements ExpenseSharingState {
  const ListPendingSplitsSuccess({required final  List<ExpenseSplitModel> pendingSplits}): _pendingSplits = pendingSplits;
  

 final  List<ExpenseSplitModel> _pendingSplits;
 List<ExpenseSplitModel> get pendingSplits {
  if (_pendingSplits is EqualUnmodifiableListView) return _pendingSplits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingSplits);
}


/// Create a copy of ExpenseSharingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListPendingSplitsSuccessCopyWith<ListPendingSplitsSuccess> get copyWith => _$ListPendingSplitsSuccessCopyWithImpl<ListPendingSplitsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListPendingSplitsSuccess&&const DeepCollectionEquality().equals(other._pendingSplits, _pendingSplits));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pendingSplits));

@override
String toString() {
  return 'ExpenseSharingState.listPendingSplitsSuccess(pendingSplits: $pendingSplits)';
}


}

/// @nodoc
abstract mixin class $ListPendingSplitsSuccessCopyWith<$Res> implements $ExpenseSharingStateCopyWith<$Res> {
  factory $ListPendingSplitsSuccessCopyWith(ListPendingSplitsSuccess value, $Res Function(ListPendingSplitsSuccess) _then) = _$ListPendingSplitsSuccessCopyWithImpl;
@useResult
$Res call({
 List<ExpenseSplitModel> pendingSplits
});




}
/// @nodoc
class _$ListPendingSplitsSuccessCopyWithImpl<$Res>
    implements $ListPendingSplitsSuccessCopyWith<$Res> {
  _$ListPendingSplitsSuccessCopyWithImpl(this._self, this._then);

  final ListPendingSplitsSuccess _self;
  final $Res Function(ListPendingSplitsSuccess) _then;

/// Create a copy of ExpenseSharingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pendingSplits = null,}) {
  return _then(ListPendingSplitsSuccess(
pendingSplits: null == pendingSplits ? _self._pendingSplits : pendingSplits // ignore: cast_nullable_to_non_nullable
as List<ExpenseSplitModel>,
  ));
}


}

/// @nodoc


class PayExpenseSplitSuccess implements ExpenseSharingState {
  const PayExpenseSplitSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayExpenseSplitSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingState.payExpenseSplitSuccess()';
}


}




/// @nodoc


class ApproveExpenseSplitPaymentSuccess implements ExpenseSharingState {
  const ApproveExpenseSplitPaymentSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveExpenseSplitPaymentSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingState.approveExpenseSplitPaymentSuccess()';
}


}




/// @nodoc


class ExpenseSharingFailure implements ExpenseSharingState {
  const ExpenseSharingFailure({required this.message});
  

 final  String message;

/// Create a copy of ExpenseSharingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseSharingFailureCopyWith<ExpenseSharingFailure> get copyWith => _$ExpenseSharingFailureCopyWithImpl<ExpenseSharingFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSharingFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ExpenseSharingState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ExpenseSharingFailureCopyWith<$Res> implements $ExpenseSharingStateCopyWith<$Res> {
  factory $ExpenseSharingFailureCopyWith(ExpenseSharingFailure value, $Res Function(ExpenseSharingFailure) _then) = _$ExpenseSharingFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ExpenseSharingFailureCopyWithImpl<$Res>
    implements $ExpenseSharingFailureCopyWith<$Res> {
  _$ExpenseSharingFailureCopyWithImpl(this._self, this._then);

  final ExpenseSharingFailure _self;
  final $Res Function(ExpenseSharingFailure) _then;

/// Create a copy of ExpenseSharingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ExpenseSharingFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
