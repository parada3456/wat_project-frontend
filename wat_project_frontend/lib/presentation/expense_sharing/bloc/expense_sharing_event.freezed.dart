// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_sharing_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpenseSharingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSharingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingEvent()';
}


}

/// @nodoc
class $ExpenseSharingEventCopyWith<$Res>  {
$ExpenseSharingEventCopyWith(ExpenseSharingEvent _, $Res Function(ExpenseSharingEvent) __);
}


/// Adds pattern-matching-related methods to [ExpenseSharingEvent].
extension ExpenseSharingEventPatterns on ExpenseSharingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ListExpensesRequested value)?  listExpensesRequested,TResult Function( CreateExpenseSubmitted value)?  createExpenseSubmitted,TResult Function( GetExpenseDetailRequested value)?  getExpenseDetailRequested,TResult Function( DeleteExpenseSubmitted value)?  deleteExpenseSubmitted,TResult Function( ListPendingSplitsRequested value)?  listPendingSplitsRequested,TResult Function( PayExpenseSplitSubmitted value)?  payExpenseSplitSubmitted,TResult Function( ApproveExpenseSplitPaymentSubmitted value)?  approveExpenseSplitPaymentSubmitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ListExpensesRequested() when listExpensesRequested != null:
return listExpensesRequested(_that);case CreateExpenseSubmitted() when createExpenseSubmitted != null:
return createExpenseSubmitted(_that);case GetExpenseDetailRequested() when getExpenseDetailRequested != null:
return getExpenseDetailRequested(_that);case DeleteExpenseSubmitted() when deleteExpenseSubmitted != null:
return deleteExpenseSubmitted(_that);case ListPendingSplitsRequested() when listPendingSplitsRequested != null:
return listPendingSplitsRequested(_that);case PayExpenseSplitSubmitted() when payExpenseSplitSubmitted != null:
return payExpenseSplitSubmitted(_that);case ApproveExpenseSplitPaymentSubmitted() when approveExpenseSplitPaymentSubmitted != null:
return approveExpenseSplitPaymentSubmitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ListExpensesRequested value)  listExpensesRequested,required TResult Function( CreateExpenseSubmitted value)  createExpenseSubmitted,required TResult Function( GetExpenseDetailRequested value)  getExpenseDetailRequested,required TResult Function( DeleteExpenseSubmitted value)  deleteExpenseSubmitted,required TResult Function( ListPendingSplitsRequested value)  listPendingSplitsRequested,required TResult Function( PayExpenseSplitSubmitted value)  payExpenseSplitSubmitted,required TResult Function( ApproveExpenseSplitPaymentSubmitted value)  approveExpenseSplitPaymentSubmitted,}){
final _that = this;
switch (_that) {
case ListExpensesRequested():
return listExpensesRequested(_that);case CreateExpenseSubmitted():
return createExpenseSubmitted(_that);case GetExpenseDetailRequested():
return getExpenseDetailRequested(_that);case DeleteExpenseSubmitted():
return deleteExpenseSubmitted(_that);case ListPendingSplitsRequested():
return listPendingSplitsRequested(_that);case PayExpenseSplitSubmitted():
return payExpenseSplitSubmitted(_that);case ApproveExpenseSplitPaymentSubmitted():
return approveExpenseSplitPaymentSubmitted(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ListExpensesRequested value)?  listExpensesRequested,TResult? Function( CreateExpenseSubmitted value)?  createExpenseSubmitted,TResult? Function( GetExpenseDetailRequested value)?  getExpenseDetailRequested,TResult? Function( DeleteExpenseSubmitted value)?  deleteExpenseSubmitted,TResult? Function( ListPendingSplitsRequested value)?  listPendingSplitsRequested,TResult? Function( PayExpenseSplitSubmitted value)?  payExpenseSplitSubmitted,TResult? Function( ApproveExpenseSplitPaymentSubmitted value)?  approveExpenseSplitPaymentSubmitted,}){
final _that = this;
switch (_that) {
case ListExpensesRequested() when listExpensesRequested != null:
return listExpensesRequested(_that);case CreateExpenseSubmitted() when createExpenseSubmitted != null:
return createExpenseSubmitted(_that);case GetExpenseDetailRequested() when getExpenseDetailRequested != null:
return getExpenseDetailRequested(_that);case DeleteExpenseSubmitted() when deleteExpenseSubmitted != null:
return deleteExpenseSubmitted(_that);case ListPendingSplitsRequested() when listPendingSplitsRequested != null:
return listPendingSplitsRequested(_that);case PayExpenseSplitSubmitted() when payExpenseSplitSubmitted != null:
return payExpenseSplitSubmitted(_that);case ApproveExpenseSplitPaymentSubmitted() when approveExpenseSplitPaymentSubmitted != null:
return approveExpenseSplitPaymentSubmitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  listExpensesRequested,TResult Function( CreateExpenseRequest request)?  createExpenseSubmitted,TResult Function( String id)?  getExpenseDetailRequested,TResult Function( String id)?  deleteExpenseSubmitted,TResult Function()?  listPendingSplitsRequested,TResult Function( String expenseId,  String splitId,  File file)?  payExpenseSplitSubmitted,TResult Function( String expenseId,  String splitId)?  approveExpenseSplitPaymentSubmitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ListExpensesRequested() when listExpensesRequested != null:
return listExpensesRequested();case CreateExpenseSubmitted() when createExpenseSubmitted != null:
return createExpenseSubmitted(_that.request);case GetExpenseDetailRequested() when getExpenseDetailRequested != null:
return getExpenseDetailRequested(_that.id);case DeleteExpenseSubmitted() when deleteExpenseSubmitted != null:
return deleteExpenseSubmitted(_that.id);case ListPendingSplitsRequested() when listPendingSplitsRequested != null:
return listPendingSplitsRequested();case PayExpenseSplitSubmitted() when payExpenseSplitSubmitted != null:
return payExpenseSplitSubmitted(_that.expenseId,_that.splitId,_that.file);case ApproveExpenseSplitPaymentSubmitted() when approveExpenseSplitPaymentSubmitted != null:
return approveExpenseSplitPaymentSubmitted(_that.expenseId,_that.splitId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  listExpensesRequested,required TResult Function( CreateExpenseRequest request)  createExpenseSubmitted,required TResult Function( String id)  getExpenseDetailRequested,required TResult Function( String id)  deleteExpenseSubmitted,required TResult Function()  listPendingSplitsRequested,required TResult Function( String expenseId,  String splitId,  File file)  payExpenseSplitSubmitted,required TResult Function( String expenseId,  String splitId)  approveExpenseSplitPaymentSubmitted,}) {final _that = this;
switch (_that) {
case ListExpensesRequested():
return listExpensesRequested();case CreateExpenseSubmitted():
return createExpenseSubmitted(_that.request);case GetExpenseDetailRequested():
return getExpenseDetailRequested(_that.id);case DeleteExpenseSubmitted():
return deleteExpenseSubmitted(_that.id);case ListPendingSplitsRequested():
return listPendingSplitsRequested();case PayExpenseSplitSubmitted():
return payExpenseSplitSubmitted(_that.expenseId,_that.splitId,_that.file);case ApproveExpenseSplitPaymentSubmitted():
return approveExpenseSplitPaymentSubmitted(_that.expenseId,_that.splitId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  listExpensesRequested,TResult? Function( CreateExpenseRequest request)?  createExpenseSubmitted,TResult? Function( String id)?  getExpenseDetailRequested,TResult? Function( String id)?  deleteExpenseSubmitted,TResult? Function()?  listPendingSplitsRequested,TResult? Function( String expenseId,  String splitId,  File file)?  payExpenseSplitSubmitted,TResult? Function( String expenseId,  String splitId)?  approveExpenseSplitPaymentSubmitted,}) {final _that = this;
switch (_that) {
case ListExpensesRequested() when listExpensesRequested != null:
return listExpensesRequested();case CreateExpenseSubmitted() when createExpenseSubmitted != null:
return createExpenseSubmitted(_that.request);case GetExpenseDetailRequested() when getExpenseDetailRequested != null:
return getExpenseDetailRequested(_that.id);case DeleteExpenseSubmitted() when deleteExpenseSubmitted != null:
return deleteExpenseSubmitted(_that.id);case ListPendingSplitsRequested() when listPendingSplitsRequested != null:
return listPendingSplitsRequested();case PayExpenseSplitSubmitted() when payExpenseSplitSubmitted != null:
return payExpenseSplitSubmitted(_that.expenseId,_that.splitId,_that.file);case ApproveExpenseSplitPaymentSubmitted() when approveExpenseSplitPaymentSubmitted != null:
return approveExpenseSplitPaymentSubmitted(_that.expenseId,_that.splitId);case _:
  return null;

}
}

}

/// @nodoc


class ListExpensesRequested implements ExpenseSharingEvent {
  const ListExpensesRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListExpensesRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingEvent.listExpensesRequested()';
}


}




/// @nodoc


class CreateExpenseSubmitted implements ExpenseSharingEvent {
  const CreateExpenseSubmitted(this.request);
  

 final  CreateExpenseRequest request;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateExpenseSubmittedCopyWith<CreateExpenseSubmitted> get copyWith => _$CreateExpenseSubmittedCopyWithImpl<CreateExpenseSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateExpenseSubmitted&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'ExpenseSharingEvent.createExpenseSubmitted(request: $request)';
}


}

/// @nodoc
abstract mixin class $CreateExpenseSubmittedCopyWith<$Res> implements $ExpenseSharingEventCopyWith<$Res> {
  factory $CreateExpenseSubmittedCopyWith(CreateExpenseSubmitted value, $Res Function(CreateExpenseSubmitted) _then) = _$CreateExpenseSubmittedCopyWithImpl;
@useResult
$Res call({
 CreateExpenseRequest request
});




}
/// @nodoc
class _$CreateExpenseSubmittedCopyWithImpl<$Res>
    implements $CreateExpenseSubmittedCopyWith<$Res> {
  _$CreateExpenseSubmittedCopyWithImpl(this._self, this._then);

  final CreateExpenseSubmitted _self;
  final $Res Function(CreateExpenseSubmitted) _then;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(CreateExpenseSubmitted(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CreateExpenseRequest,
  ));
}


}

/// @nodoc


class GetExpenseDetailRequested implements ExpenseSharingEvent {
  const GetExpenseDetailRequested(this.id);
  

 final  String id;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetExpenseDetailRequestedCopyWith<GetExpenseDetailRequested> get copyWith => _$GetExpenseDetailRequestedCopyWithImpl<GetExpenseDetailRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetExpenseDetailRequested&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ExpenseSharingEvent.getExpenseDetailRequested(id: $id)';
}


}

/// @nodoc
abstract mixin class $GetExpenseDetailRequestedCopyWith<$Res> implements $ExpenseSharingEventCopyWith<$Res> {
  factory $GetExpenseDetailRequestedCopyWith(GetExpenseDetailRequested value, $Res Function(GetExpenseDetailRequested) _then) = _$GetExpenseDetailRequestedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$GetExpenseDetailRequestedCopyWithImpl<$Res>
    implements $GetExpenseDetailRequestedCopyWith<$Res> {
  _$GetExpenseDetailRequestedCopyWithImpl(this._self, this._then);

  final GetExpenseDetailRequested _self;
  final $Res Function(GetExpenseDetailRequested) _then;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(GetExpenseDetailRequested(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DeleteExpenseSubmitted implements ExpenseSharingEvent {
  const DeleteExpenseSubmitted(this.id);
  

 final  String id;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteExpenseSubmittedCopyWith<DeleteExpenseSubmitted> get copyWith => _$DeleteExpenseSubmittedCopyWithImpl<DeleteExpenseSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteExpenseSubmitted&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ExpenseSharingEvent.deleteExpenseSubmitted(id: $id)';
}


}

/// @nodoc
abstract mixin class $DeleteExpenseSubmittedCopyWith<$Res> implements $ExpenseSharingEventCopyWith<$Res> {
  factory $DeleteExpenseSubmittedCopyWith(DeleteExpenseSubmitted value, $Res Function(DeleteExpenseSubmitted) _then) = _$DeleteExpenseSubmittedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$DeleteExpenseSubmittedCopyWithImpl<$Res>
    implements $DeleteExpenseSubmittedCopyWith<$Res> {
  _$DeleteExpenseSubmittedCopyWithImpl(this._self, this._then);

  final DeleteExpenseSubmitted _self;
  final $Res Function(DeleteExpenseSubmitted) _then;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(DeleteExpenseSubmitted(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ListPendingSplitsRequested implements ExpenseSharingEvent {
  const ListPendingSplitsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListPendingSplitsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSharingEvent.listPendingSplitsRequested()';
}


}




/// @nodoc


class PayExpenseSplitSubmitted implements ExpenseSharingEvent {
  const PayExpenseSplitSubmitted({required this.expenseId, required this.splitId, required this.file});
  

 final  String expenseId;
 final  String splitId;
 final  File file;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayExpenseSplitSubmittedCopyWith<PayExpenseSplitSubmitted> get copyWith => _$PayExpenseSplitSubmittedCopyWithImpl<PayExpenseSplitSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayExpenseSplitSubmitted&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId)&&(identical(other.splitId, splitId) || other.splitId == splitId)&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,expenseId,splitId,file);

@override
String toString() {
  return 'ExpenseSharingEvent.payExpenseSplitSubmitted(expenseId: $expenseId, splitId: $splitId, file: $file)';
}


}

/// @nodoc
abstract mixin class $PayExpenseSplitSubmittedCopyWith<$Res> implements $ExpenseSharingEventCopyWith<$Res> {
  factory $PayExpenseSplitSubmittedCopyWith(PayExpenseSplitSubmitted value, $Res Function(PayExpenseSplitSubmitted) _then) = _$PayExpenseSplitSubmittedCopyWithImpl;
@useResult
$Res call({
 String expenseId, String splitId, File file
});




}
/// @nodoc
class _$PayExpenseSplitSubmittedCopyWithImpl<$Res>
    implements $PayExpenseSplitSubmittedCopyWith<$Res> {
  _$PayExpenseSplitSubmittedCopyWithImpl(this._self, this._then);

  final PayExpenseSplitSubmitted _self;
  final $Res Function(PayExpenseSplitSubmitted) _then;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenseId = null,Object? splitId = null,Object? file = null,}) {
  return _then(PayExpenseSplitSubmitted(
expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,splitId: null == splitId ? _self.splitId : splitId // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class ApproveExpenseSplitPaymentSubmitted implements ExpenseSharingEvent {
  const ApproveExpenseSplitPaymentSubmitted({required this.expenseId, required this.splitId});
  

 final  String expenseId;
 final  String splitId;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApproveExpenseSplitPaymentSubmittedCopyWith<ApproveExpenseSplitPaymentSubmitted> get copyWith => _$ApproveExpenseSplitPaymentSubmittedCopyWithImpl<ApproveExpenseSplitPaymentSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveExpenseSplitPaymentSubmitted&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId)&&(identical(other.splitId, splitId) || other.splitId == splitId));
}


@override
int get hashCode => Object.hash(runtimeType,expenseId,splitId);

@override
String toString() {
  return 'ExpenseSharingEvent.approveExpenseSplitPaymentSubmitted(expenseId: $expenseId, splitId: $splitId)';
}


}

/// @nodoc
abstract mixin class $ApproveExpenseSplitPaymentSubmittedCopyWith<$Res> implements $ExpenseSharingEventCopyWith<$Res> {
  factory $ApproveExpenseSplitPaymentSubmittedCopyWith(ApproveExpenseSplitPaymentSubmitted value, $Res Function(ApproveExpenseSplitPaymentSubmitted) _then) = _$ApproveExpenseSplitPaymentSubmittedCopyWithImpl;
@useResult
$Res call({
 String expenseId, String splitId
});




}
/// @nodoc
class _$ApproveExpenseSplitPaymentSubmittedCopyWithImpl<$Res>
    implements $ApproveExpenseSplitPaymentSubmittedCopyWith<$Res> {
  _$ApproveExpenseSplitPaymentSubmittedCopyWithImpl(this._self, this._then);

  final ApproveExpenseSplitPaymentSubmitted _self;
  final $Res Function(ApproveExpenseSplitPaymentSubmitted) _then;

/// Create a copy of ExpenseSharingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenseId = null,Object? splitId = null,}) {
  return _then(ApproveExpenseSplitPaymentSubmitted(
expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,splitId: null == splitId ? _self.splitId : splitId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
