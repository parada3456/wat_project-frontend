// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminDashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminDashboardState()';
}


}

/// @nodoc
class $AdminDashboardStateCopyWith<$Res>  {
$AdminDashboardStateCopyWith(AdminDashboardState _, $Res Function(AdminDashboardState) __);
}


/// Adds pattern-matching-related methods to [AdminDashboardState].
extension AdminDashboardStatePatterns on AdminDashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AdminDashboardInitial value)?  initial,TResult Function( AdminDashboardLoading value)?  loading,TResult Function( AdminDashboardStatsSuccess value)?  statsSuccess,TResult Function( AdminDashboardPendingVerificationsSuccess value)?  pendingVerificationsSuccess,TResult Function( AdminDashboardUsersSuccess value)?  usersSuccess,TResult Function( AdminDashboardUserDetailSuccess value)?  userDetailSuccess,TResult Function( AdminDashboardVerifySuccess value)?  verifySuccess,TResult Function( AdminDashboardAdjustPointsSuccess value)?  adjustPointsSuccess,TResult Function( AdminDashboardFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AdminDashboardInitial() when initial != null:
return initial(_that);case AdminDashboardLoading() when loading != null:
return loading(_that);case AdminDashboardStatsSuccess() when statsSuccess != null:
return statsSuccess(_that);case AdminDashboardPendingVerificationsSuccess() when pendingVerificationsSuccess != null:
return pendingVerificationsSuccess(_that);case AdminDashboardUsersSuccess() when usersSuccess != null:
return usersSuccess(_that);case AdminDashboardUserDetailSuccess() when userDetailSuccess != null:
return userDetailSuccess(_that);case AdminDashboardVerifySuccess() when verifySuccess != null:
return verifySuccess(_that);case AdminDashboardAdjustPointsSuccess() when adjustPointsSuccess != null:
return adjustPointsSuccess(_that);case AdminDashboardFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AdminDashboardInitial value)  initial,required TResult Function( AdminDashboardLoading value)  loading,required TResult Function( AdminDashboardStatsSuccess value)  statsSuccess,required TResult Function( AdminDashboardPendingVerificationsSuccess value)  pendingVerificationsSuccess,required TResult Function( AdminDashboardUsersSuccess value)  usersSuccess,required TResult Function( AdminDashboardUserDetailSuccess value)  userDetailSuccess,required TResult Function( AdminDashboardVerifySuccess value)  verifySuccess,required TResult Function( AdminDashboardAdjustPointsSuccess value)  adjustPointsSuccess,required TResult Function( AdminDashboardFailure value)  failure,}){
final _that = this;
switch (_that) {
case AdminDashboardInitial():
return initial(_that);case AdminDashboardLoading():
return loading(_that);case AdminDashboardStatsSuccess():
return statsSuccess(_that);case AdminDashboardPendingVerificationsSuccess():
return pendingVerificationsSuccess(_that);case AdminDashboardUsersSuccess():
return usersSuccess(_that);case AdminDashboardUserDetailSuccess():
return userDetailSuccess(_that);case AdminDashboardVerifySuccess():
return verifySuccess(_that);case AdminDashboardAdjustPointsSuccess():
return adjustPointsSuccess(_that);case AdminDashboardFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AdminDashboardInitial value)?  initial,TResult? Function( AdminDashboardLoading value)?  loading,TResult? Function( AdminDashboardStatsSuccess value)?  statsSuccess,TResult? Function( AdminDashboardPendingVerificationsSuccess value)?  pendingVerificationsSuccess,TResult? Function( AdminDashboardUsersSuccess value)?  usersSuccess,TResult? Function( AdminDashboardUserDetailSuccess value)?  userDetailSuccess,TResult? Function( AdminDashboardVerifySuccess value)?  verifySuccess,TResult? Function( AdminDashboardAdjustPointsSuccess value)?  adjustPointsSuccess,TResult? Function( AdminDashboardFailure value)?  failure,}){
final _that = this;
switch (_that) {
case AdminDashboardInitial() when initial != null:
return initial(_that);case AdminDashboardLoading() when loading != null:
return loading(_that);case AdminDashboardStatsSuccess() when statsSuccess != null:
return statsSuccess(_that);case AdminDashboardPendingVerificationsSuccess() when pendingVerificationsSuccess != null:
return pendingVerificationsSuccess(_that);case AdminDashboardUsersSuccess() when usersSuccess != null:
return usersSuccess(_that);case AdminDashboardUserDetailSuccess() when userDetailSuccess != null:
return userDetailSuccess(_that);case AdminDashboardVerifySuccess() when verifySuccess != null:
return verifySuccess(_that);case AdminDashboardAdjustPointsSuccess() when adjustPointsSuccess != null:
return adjustPointsSuccess(_that);case AdminDashboardFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( AdminStatsModel stats)?  statsSuccess,TResult Function( List<UserMissionModel> verifications)?  pendingVerificationsSuccess,TResult Function( List<UserModel> users)?  usersSuccess,TResult Function( UserModel user)?  userDetailSuccess,TResult Function( UserMissionModel userMission)?  verifySuccess,TResult Function( PointsAdjustmentResultModel result)?  adjustPointsSuccess,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AdminDashboardInitial() when initial != null:
return initial();case AdminDashboardLoading() when loading != null:
return loading();case AdminDashboardStatsSuccess() when statsSuccess != null:
return statsSuccess(_that.stats);case AdminDashboardPendingVerificationsSuccess() when pendingVerificationsSuccess != null:
return pendingVerificationsSuccess(_that.verifications);case AdminDashboardUsersSuccess() when usersSuccess != null:
return usersSuccess(_that.users);case AdminDashboardUserDetailSuccess() when userDetailSuccess != null:
return userDetailSuccess(_that.user);case AdminDashboardVerifySuccess() when verifySuccess != null:
return verifySuccess(_that.userMission);case AdminDashboardAdjustPointsSuccess() when adjustPointsSuccess != null:
return adjustPointsSuccess(_that.result);case AdminDashboardFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( AdminStatsModel stats)  statsSuccess,required TResult Function( List<UserMissionModel> verifications)  pendingVerificationsSuccess,required TResult Function( List<UserModel> users)  usersSuccess,required TResult Function( UserModel user)  userDetailSuccess,required TResult Function( UserMissionModel userMission)  verifySuccess,required TResult Function( PointsAdjustmentResultModel result)  adjustPointsSuccess,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case AdminDashboardInitial():
return initial();case AdminDashboardLoading():
return loading();case AdminDashboardStatsSuccess():
return statsSuccess(_that.stats);case AdminDashboardPendingVerificationsSuccess():
return pendingVerificationsSuccess(_that.verifications);case AdminDashboardUsersSuccess():
return usersSuccess(_that.users);case AdminDashboardUserDetailSuccess():
return userDetailSuccess(_that.user);case AdminDashboardVerifySuccess():
return verifySuccess(_that.userMission);case AdminDashboardAdjustPointsSuccess():
return adjustPointsSuccess(_that.result);case AdminDashboardFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( AdminStatsModel stats)?  statsSuccess,TResult? Function( List<UserMissionModel> verifications)?  pendingVerificationsSuccess,TResult? Function( List<UserModel> users)?  usersSuccess,TResult? Function( UserModel user)?  userDetailSuccess,TResult? Function( UserMissionModel userMission)?  verifySuccess,TResult? Function( PointsAdjustmentResultModel result)?  adjustPointsSuccess,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case AdminDashboardInitial() when initial != null:
return initial();case AdminDashboardLoading() when loading != null:
return loading();case AdminDashboardStatsSuccess() when statsSuccess != null:
return statsSuccess(_that.stats);case AdminDashboardPendingVerificationsSuccess() when pendingVerificationsSuccess != null:
return pendingVerificationsSuccess(_that.verifications);case AdminDashboardUsersSuccess() when usersSuccess != null:
return usersSuccess(_that.users);case AdminDashboardUserDetailSuccess() when userDetailSuccess != null:
return userDetailSuccess(_that.user);case AdminDashboardVerifySuccess() when verifySuccess != null:
return verifySuccess(_that.userMission);case AdminDashboardAdjustPointsSuccess() when adjustPointsSuccess != null:
return adjustPointsSuccess(_that.result);case AdminDashboardFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AdminDashboardInitial implements AdminDashboardState {
  const AdminDashboardInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminDashboardState.initial()';
}


}




/// @nodoc


class AdminDashboardLoading implements AdminDashboardState {
  const AdminDashboardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminDashboardState.loading()';
}


}




/// @nodoc


class AdminDashboardStatsSuccess implements AdminDashboardState {
  const AdminDashboardStatsSuccess(this.stats);
  

 final  AdminStatsModel stats;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDashboardStatsSuccessCopyWith<AdminDashboardStatsSuccess> get copyWith => _$AdminDashboardStatsSuccessCopyWithImpl<AdminDashboardStatsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardStatsSuccess&&(identical(other.stats, stats) || other.stats == stats));
}


@override
int get hashCode => Object.hash(runtimeType,stats);

@override
String toString() {
  return 'AdminDashboardState.statsSuccess(stats: $stats)';
}


}

/// @nodoc
abstract mixin class $AdminDashboardStatsSuccessCopyWith<$Res> implements $AdminDashboardStateCopyWith<$Res> {
  factory $AdminDashboardStatsSuccessCopyWith(AdminDashboardStatsSuccess value, $Res Function(AdminDashboardStatsSuccess) _then) = _$AdminDashboardStatsSuccessCopyWithImpl;
@useResult
$Res call({
 AdminStatsModel stats
});




}
/// @nodoc
class _$AdminDashboardStatsSuccessCopyWithImpl<$Res>
    implements $AdminDashboardStatsSuccessCopyWith<$Res> {
  _$AdminDashboardStatsSuccessCopyWithImpl(this._self, this._then);

  final AdminDashboardStatsSuccess _self;
  final $Res Function(AdminDashboardStatsSuccess) _then;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stats = null,}) {
  return _then(AdminDashboardStatsSuccess(
null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as AdminStatsModel,
  ));
}


}

/// @nodoc


class AdminDashboardPendingVerificationsSuccess implements AdminDashboardState {
  const AdminDashboardPendingVerificationsSuccess(final  List<UserMissionModel> verifications): _verifications = verifications;
  

 final  List<UserMissionModel> _verifications;
 List<UserMissionModel> get verifications {
  if (_verifications is EqualUnmodifiableListView) return _verifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verifications);
}


/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDashboardPendingVerificationsSuccessCopyWith<AdminDashboardPendingVerificationsSuccess> get copyWith => _$AdminDashboardPendingVerificationsSuccessCopyWithImpl<AdminDashboardPendingVerificationsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardPendingVerificationsSuccess&&const DeepCollectionEquality().equals(other._verifications, _verifications));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_verifications));

@override
String toString() {
  return 'AdminDashboardState.pendingVerificationsSuccess(verifications: $verifications)';
}


}

/// @nodoc
abstract mixin class $AdminDashboardPendingVerificationsSuccessCopyWith<$Res> implements $AdminDashboardStateCopyWith<$Res> {
  factory $AdminDashboardPendingVerificationsSuccessCopyWith(AdminDashboardPendingVerificationsSuccess value, $Res Function(AdminDashboardPendingVerificationsSuccess) _then) = _$AdminDashboardPendingVerificationsSuccessCopyWithImpl;
@useResult
$Res call({
 List<UserMissionModel> verifications
});




}
/// @nodoc
class _$AdminDashboardPendingVerificationsSuccessCopyWithImpl<$Res>
    implements $AdminDashboardPendingVerificationsSuccessCopyWith<$Res> {
  _$AdminDashboardPendingVerificationsSuccessCopyWithImpl(this._self, this._then);

  final AdminDashboardPendingVerificationsSuccess _self;
  final $Res Function(AdminDashboardPendingVerificationsSuccess) _then;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? verifications = null,}) {
  return _then(AdminDashboardPendingVerificationsSuccess(
null == verifications ? _self._verifications : verifications // ignore: cast_nullable_to_non_nullable
as List<UserMissionModel>,
  ));
}


}

/// @nodoc


class AdminDashboardUsersSuccess implements AdminDashboardState {
  const AdminDashboardUsersSuccess(final  List<UserModel> users): _users = users;
  

 final  List<UserModel> _users;
 List<UserModel> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}


/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDashboardUsersSuccessCopyWith<AdminDashboardUsersSuccess> get copyWith => _$AdminDashboardUsersSuccessCopyWithImpl<AdminDashboardUsersSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardUsersSuccess&&const DeepCollectionEquality().equals(other._users, _users));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_users));

@override
String toString() {
  return 'AdminDashboardState.usersSuccess(users: $users)';
}


}

/// @nodoc
abstract mixin class $AdminDashboardUsersSuccessCopyWith<$Res> implements $AdminDashboardStateCopyWith<$Res> {
  factory $AdminDashboardUsersSuccessCopyWith(AdminDashboardUsersSuccess value, $Res Function(AdminDashboardUsersSuccess) _then) = _$AdminDashboardUsersSuccessCopyWithImpl;
@useResult
$Res call({
 List<UserModel> users
});




}
/// @nodoc
class _$AdminDashboardUsersSuccessCopyWithImpl<$Res>
    implements $AdminDashboardUsersSuccessCopyWith<$Res> {
  _$AdminDashboardUsersSuccessCopyWithImpl(this._self, this._then);

  final AdminDashboardUsersSuccess _self;
  final $Res Function(AdminDashboardUsersSuccess) _then;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? users = null,}) {
  return _then(AdminDashboardUsersSuccess(
null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<UserModel>,
  ));
}


}

/// @nodoc


class AdminDashboardUserDetailSuccess implements AdminDashboardState {
  const AdminDashboardUserDetailSuccess(this.user);
  

 final  UserModel user;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDashboardUserDetailSuccessCopyWith<AdminDashboardUserDetailSuccess> get copyWith => _$AdminDashboardUserDetailSuccessCopyWithImpl<AdminDashboardUserDetailSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardUserDetailSuccess&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AdminDashboardState.userDetailSuccess(user: $user)';
}


}

/// @nodoc
abstract mixin class $AdminDashboardUserDetailSuccessCopyWith<$Res> implements $AdminDashboardStateCopyWith<$Res> {
  factory $AdminDashboardUserDetailSuccessCopyWith(AdminDashboardUserDetailSuccess value, $Res Function(AdminDashboardUserDetailSuccess) _then) = _$AdminDashboardUserDetailSuccessCopyWithImpl;
@useResult
$Res call({
 UserModel user
});




}
/// @nodoc
class _$AdminDashboardUserDetailSuccessCopyWithImpl<$Res>
    implements $AdminDashboardUserDetailSuccessCopyWith<$Res> {
  _$AdminDashboardUserDetailSuccessCopyWithImpl(this._self, this._then);

  final AdminDashboardUserDetailSuccess _self;
  final $Res Function(AdminDashboardUserDetailSuccess) _then;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(AdminDashboardUserDetailSuccess(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,
  ));
}


}

/// @nodoc


class AdminDashboardVerifySuccess implements AdminDashboardState {
  const AdminDashboardVerifySuccess(this.userMission);
  

 final  UserMissionModel userMission;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDashboardVerifySuccessCopyWith<AdminDashboardVerifySuccess> get copyWith => _$AdminDashboardVerifySuccessCopyWithImpl<AdminDashboardVerifySuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardVerifySuccess&&(identical(other.userMission, userMission) || other.userMission == userMission));
}


@override
int get hashCode => Object.hash(runtimeType,userMission);

@override
String toString() {
  return 'AdminDashboardState.verifySuccess(userMission: $userMission)';
}


}

/// @nodoc
abstract mixin class $AdminDashboardVerifySuccessCopyWith<$Res> implements $AdminDashboardStateCopyWith<$Res> {
  factory $AdminDashboardVerifySuccessCopyWith(AdminDashboardVerifySuccess value, $Res Function(AdminDashboardVerifySuccess) _then) = _$AdminDashboardVerifySuccessCopyWithImpl;
@useResult
$Res call({
 UserMissionModel userMission
});




}
/// @nodoc
class _$AdminDashboardVerifySuccessCopyWithImpl<$Res>
    implements $AdminDashboardVerifySuccessCopyWith<$Res> {
  _$AdminDashboardVerifySuccessCopyWithImpl(this._self, this._then);

  final AdminDashboardVerifySuccess _self;
  final $Res Function(AdminDashboardVerifySuccess) _then;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userMission = null,}) {
  return _then(AdminDashboardVerifySuccess(
null == userMission ? _self.userMission : userMission // ignore: cast_nullable_to_non_nullable
as UserMissionModel,
  ));
}


}

/// @nodoc


class AdminDashboardAdjustPointsSuccess implements AdminDashboardState {
  const AdminDashboardAdjustPointsSuccess(this.result);
  

 final  PointsAdjustmentResultModel result;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDashboardAdjustPointsSuccessCopyWith<AdminDashboardAdjustPointsSuccess> get copyWith => _$AdminDashboardAdjustPointsSuccessCopyWithImpl<AdminDashboardAdjustPointsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardAdjustPointsSuccess&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'AdminDashboardState.adjustPointsSuccess(result: $result)';
}


}

/// @nodoc
abstract mixin class $AdminDashboardAdjustPointsSuccessCopyWith<$Res> implements $AdminDashboardStateCopyWith<$Res> {
  factory $AdminDashboardAdjustPointsSuccessCopyWith(AdminDashboardAdjustPointsSuccess value, $Res Function(AdminDashboardAdjustPointsSuccess) _then) = _$AdminDashboardAdjustPointsSuccessCopyWithImpl;
@useResult
$Res call({
 PointsAdjustmentResultModel result
});




}
/// @nodoc
class _$AdminDashboardAdjustPointsSuccessCopyWithImpl<$Res>
    implements $AdminDashboardAdjustPointsSuccessCopyWith<$Res> {
  _$AdminDashboardAdjustPointsSuccessCopyWithImpl(this._self, this._then);

  final AdminDashboardAdjustPointsSuccess _self;
  final $Res Function(AdminDashboardAdjustPointsSuccess) _then;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(AdminDashboardAdjustPointsSuccess(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as PointsAdjustmentResultModel,
  ));
}


}

/// @nodoc


class AdminDashboardFailure implements AdminDashboardState {
  const AdminDashboardFailure(this.message);
  

 final  String message;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDashboardFailureCopyWith<AdminDashboardFailure> get copyWith => _$AdminDashboardFailureCopyWithImpl<AdminDashboardFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AdminDashboardState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AdminDashboardFailureCopyWith<$Res> implements $AdminDashboardStateCopyWith<$Res> {
  factory $AdminDashboardFailureCopyWith(AdminDashboardFailure value, $Res Function(AdminDashboardFailure) _then) = _$AdminDashboardFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AdminDashboardFailureCopyWithImpl<$Res>
    implements $AdminDashboardFailureCopyWith<$Res> {
  _$AdminDashboardFailureCopyWithImpl(this._self, this._then);

  final AdminDashboardFailure _self;
  final $Res Function(AdminDashboardFailure) _then;

/// Create a copy of AdminDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AdminDashboardFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
