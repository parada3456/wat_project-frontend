// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_dashboard_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminDashboardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminDashboardEvent()';
}


}

/// @nodoc
class $AdminDashboardEventCopyWith<$Res>  {
$AdminDashboardEventCopyWith(AdminDashboardEvent _, $Res Function(AdminDashboardEvent) __);
}


/// Adds pattern-matching-related methods to [AdminDashboardEvent].
extension AdminDashboardEventPatterns on AdminDashboardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AdminStatsRequested value)?  statsRequested,TResult Function( AdminPendingVerificationsRequested value)?  pendingVerificationsRequested,TResult Function( AdminVerifyMissionSubmitted value)?  verifyMissionSubmitted,TResult Function( AdminUsersSearchRequested value)?  usersSearchRequested,TResult Function( AdminUserDetailRequested value)?  userDetailRequested,TResult Function( AdminAdjustPointsSubmitted value)?  adjustPointsSubmitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AdminStatsRequested() when statsRequested != null:
return statsRequested(_that);case AdminPendingVerificationsRequested() when pendingVerificationsRequested != null:
return pendingVerificationsRequested(_that);case AdminVerifyMissionSubmitted() when verifyMissionSubmitted != null:
return verifyMissionSubmitted(_that);case AdminUsersSearchRequested() when usersSearchRequested != null:
return usersSearchRequested(_that);case AdminUserDetailRequested() when userDetailRequested != null:
return userDetailRequested(_that);case AdminAdjustPointsSubmitted() when adjustPointsSubmitted != null:
return adjustPointsSubmitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AdminStatsRequested value)  statsRequested,required TResult Function( AdminPendingVerificationsRequested value)  pendingVerificationsRequested,required TResult Function( AdminVerifyMissionSubmitted value)  verifyMissionSubmitted,required TResult Function( AdminUsersSearchRequested value)  usersSearchRequested,required TResult Function( AdminUserDetailRequested value)  userDetailRequested,required TResult Function( AdminAdjustPointsSubmitted value)  adjustPointsSubmitted,}){
final _that = this;
switch (_that) {
case AdminStatsRequested():
return statsRequested(_that);case AdminPendingVerificationsRequested():
return pendingVerificationsRequested(_that);case AdminVerifyMissionSubmitted():
return verifyMissionSubmitted(_that);case AdminUsersSearchRequested():
return usersSearchRequested(_that);case AdminUserDetailRequested():
return userDetailRequested(_that);case AdminAdjustPointsSubmitted():
return adjustPointsSubmitted(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AdminStatsRequested value)?  statsRequested,TResult? Function( AdminPendingVerificationsRequested value)?  pendingVerificationsRequested,TResult? Function( AdminVerifyMissionSubmitted value)?  verifyMissionSubmitted,TResult? Function( AdminUsersSearchRequested value)?  usersSearchRequested,TResult? Function( AdminUserDetailRequested value)?  userDetailRequested,TResult? Function( AdminAdjustPointsSubmitted value)?  adjustPointsSubmitted,}){
final _that = this;
switch (_that) {
case AdminStatsRequested() when statsRequested != null:
return statsRequested(_that);case AdminPendingVerificationsRequested() when pendingVerificationsRequested != null:
return pendingVerificationsRequested(_that);case AdminVerifyMissionSubmitted() when verifyMissionSubmitted != null:
return verifyMissionSubmitted(_that);case AdminUsersSearchRequested() when usersSearchRequested != null:
return usersSearchRequested(_that);case AdminUserDetailRequested() when userDetailRequested != null:
return userDetailRequested(_that);case AdminAdjustPointsSubmitted() when adjustPointsSubmitted != null:
return adjustPointsSubmitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  statsRequested,TResult Function()?  pendingVerificationsRequested,TResult Function( String userMissionId,  bool approved,  String? reason)?  verifyMissionSubmitted,TResult Function( String search)?  usersSearchRequested,TResult Function( String userId)?  userDetailRequested,TResult Function( String userId,  int pointsDelta,  String reason)?  adjustPointsSubmitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AdminStatsRequested() when statsRequested != null:
return statsRequested();case AdminPendingVerificationsRequested() when pendingVerificationsRequested != null:
return pendingVerificationsRequested();case AdminVerifyMissionSubmitted() when verifyMissionSubmitted != null:
return verifyMissionSubmitted(_that.userMissionId,_that.approved,_that.reason);case AdminUsersSearchRequested() when usersSearchRequested != null:
return usersSearchRequested(_that.search);case AdminUserDetailRequested() when userDetailRequested != null:
return userDetailRequested(_that.userId);case AdminAdjustPointsSubmitted() when adjustPointsSubmitted != null:
return adjustPointsSubmitted(_that.userId,_that.pointsDelta,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  statsRequested,required TResult Function()  pendingVerificationsRequested,required TResult Function( String userMissionId,  bool approved,  String? reason)  verifyMissionSubmitted,required TResult Function( String search)  usersSearchRequested,required TResult Function( String userId)  userDetailRequested,required TResult Function( String userId,  int pointsDelta,  String reason)  adjustPointsSubmitted,}) {final _that = this;
switch (_that) {
case AdminStatsRequested():
return statsRequested();case AdminPendingVerificationsRequested():
return pendingVerificationsRequested();case AdminVerifyMissionSubmitted():
return verifyMissionSubmitted(_that.userMissionId,_that.approved,_that.reason);case AdminUsersSearchRequested():
return usersSearchRequested(_that.search);case AdminUserDetailRequested():
return userDetailRequested(_that.userId);case AdminAdjustPointsSubmitted():
return adjustPointsSubmitted(_that.userId,_that.pointsDelta,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  statsRequested,TResult? Function()?  pendingVerificationsRequested,TResult? Function( String userMissionId,  bool approved,  String? reason)?  verifyMissionSubmitted,TResult? Function( String search)?  usersSearchRequested,TResult? Function( String userId)?  userDetailRequested,TResult? Function( String userId,  int pointsDelta,  String reason)?  adjustPointsSubmitted,}) {final _that = this;
switch (_that) {
case AdminStatsRequested() when statsRequested != null:
return statsRequested();case AdminPendingVerificationsRequested() when pendingVerificationsRequested != null:
return pendingVerificationsRequested();case AdminVerifyMissionSubmitted() when verifyMissionSubmitted != null:
return verifyMissionSubmitted(_that.userMissionId,_that.approved,_that.reason);case AdminUsersSearchRequested() when usersSearchRequested != null:
return usersSearchRequested(_that.search);case AdminUserDetailRequested() when userDetailRequested != null:
return userDetailRequested(_that.userId);case AdminAdjustPointsSubmitted() when adjustPointsSubmitted != null:
return adjustPointsSubmitted(_that.userId,_that.pointsDelta,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class AdminStatsRequested implements AdminDashboardEvent {
  const AdminStatsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminStatsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminDashboardEvent.statsRequested()';
}


}




/// @nodoc


class AdminPendingVerificationsRequested implements AdminDashboardEvent {
  const AdminPendingVerificationsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminPendingVerificationsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminDashboardEvent.pendingVerificationsRequested()';
}


}




/// @nodoc


class AdminVerifyMissionSubmitted implements AdminDashboardEvent {
  const AdminVerifyMissionSubmitted({required this.userMissionId, required this.approved, this.reason});
  

 final  String userMissionId;
 final  bool approved;
 final  String? reason;

/// Create a copy of AdminDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminVerifyMissionSubmittedCopyWith<AdminVerifyMissionSubmitted> get copyWith => _$AdminVerifyMissionSubmittedCopyWithImpl<AdminVerifyMissionSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminVerifyMissionSubmitted&&(identical(other.userMissionId, userMissionId) || other.userMissionId == userMissionId)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,userMissionId,approved,reason);

@override
String toString() {
  return 'AdminDashboardEvent.verifyMissionSubmitted(userMissionId: $userMissionId, approved: $approved, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $AdminVerifyMissionSubmittedCopyWith<$Res> implements $AdminDashboardEventCopyWith<$Res> {
  factory $AdminVerifyMissionSubmittedCopyWith(AdminVerifyMissionSubmitted value, $Res Function(AdminVerifyMissionSubmitted) _then) = _$AdminVerifyMissionSubmittedCopyWithImpl;
@useResult
$Res call({
 String userMissionId, bool approved, String? reason
});




}
/// @nodoc
class _$AdminVerifyMissionSubmittedCopyWithImpl<$Res>
    implements $AdminVerifyMissionSubmittedCopyWith<$Res> {
  _$AdminVerifyMissionSubmittedCopyWithImpl(this._self, this._then);

  final AdminVerifyMissionSubmitted _self;
  final $Res Function(AdminVerifyMissionSubmitted) _then;

/// Create a copy of AdminDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userMissionId = null,Object? approved = null,Object? reason = freezed,}) {
  return _then(AdminVerifyMissionSubmitted(
userMissionId: null == userMissionId ? _self.userMissionId : userMissionId // ignore: cast_nullable_to_non_nullable
as String,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AdminUsersSearchRequested implements AdminDashboardEvent {
  const AdminUsersSearchRequested(this.search);
  

 final  String search;

/// Create a copy of AdminDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminUsersSearchRequestedCopyWith<AdminUsersSearchRequested> get copyWith => _$AdminUsersSearchRequestedCopyWithImpl<AdminUsersSearchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminUsersSearchRequested&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,search);

@override
String toString() {
  return 'AdminDashboardEvent.usersSearchRequested(search: $search)';
}


}

/// @nodoc
abstract mixin class $AdminUsersSearchRequestedCopyWith<$Res> implements $AdminDashboardEventCopyWith<$Res> {
  factory $AdminUsersSearchRequestedCopyWith(AdminUsersSearchRequested value, $Res Function(AdminUsersSearchRequested) _then) = _$AdminUsersSearchRequestedCopyWithImpl;
@useResult
$Res call({
 String search
});




}
/// @nodoc
class _$AdminUsersSearchRequestedCopyWithImpl<$Res>
    implements $AdminUsersSearchRequestedCopyWith<$Res> {
  _$AdminUsersSearchRequestedCopyWithImpl(this._self, this._then);

  final AdminUsersSearchRequested _self;
  final $Res Function(AdminUsersSearchRequested) _then;

/// Create a copy of AdminDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? search = null,}) {
  return _then(AdminUsersSearchRequested(
null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AdminUserDetailRequested implements AdminDashboardEvent {
  const AdminUserDetailRequested(this.userId);
  

 final  String userId;

/// Create a copy of AdminDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminUserDetailRequestedCopyWith<AdminUserDetailRequested> get copyWith => _$AdminUserDetailRequestedCopyWithImpl<AdminUserDetailRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminUserDetailRequested&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'AdminDashboardEvent.userDetailRequested(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $AdminUserDetailRequestedCopyWith<$Res> implements $AdminDashboardEventCopyWith<$Res> {
  factory $AdminUserDetailRequestedCopyWith(AdminUserDetailRequested value, $Res Function(AdminUserDetailRequested) _then) = _$AdminUserDetailRequestedCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$AdminUserDetailRequestedCopyWithImpl<$Res>
    implements $AdminUserDetailRequestedCopyWith<$Res> {
  _$AdminUserDetailRequestedCopyWithImpl(this._self, this._then);

  final AdminUserDetailRequested _self;
  final $Res Function(AdminUserDetailRequested) _then;

/// Create a copy of AdminDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(AdminUserDetailRequested(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AdminAdjustPointsSubmitted implements AdminDashboardEvent {
  const AdminAdjustPointsSubmitted({required this.userId, required this.pointsDelta, required this.reason});
  

 final  String userId;
 final  int pointsDelta;
 final  String reason;

/// Create a copy of AdminDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminAdjustPointsSubmittedCopyWith<AdminAdjustPointsSubmitted> get copyWith => _$AdminAdjustPointsSubmittedCopyWithImpl<AdminAdjustPointsSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminAdjustPointsSubmitted&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.pointsDelta, pointsDelta) || other.pointsDelta == pointsDelta)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,userId,pointsDelta,reason);

@override
String toString() {
  return 'AdminDashboardEvent.adjustPointsSubmitted(userId: $userId, pointsDelta: $pointsDelta, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $AdminAdjustPointsSubmittedCopyWith<$Res> implements $AdminDashboardEventCopyWith<$Res> {
  factory $AdminAdjustPointsSubmittedCopyWith(AdminAdjustPointsSubmitted value, $Res Function(AdminAdjustPointsSubmitted) _then) = _$AdminAdjustPointsSubmittedCopyWithImpl;
@useResult
$Res call({
 String userId, int pointsDelta, String reason
});




}
/// @nodoc
class _$AdminAdjustPointsSubmittedCopyWithImpl<$Res>
    implements $AdminAdjustPointsSubmittedCopyWith<$Res> {
  _$AdminAdjustPointsSubmittedCopyWithImpl(this._self, this._then);

  final AdminAdjustPointsSubmitted _self;
  final $Res Function(AdminAdjustPointsSubmitted) _then;

/// Create a copy of AdminDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? pointsDelta = null,Object? reason = null,}) {
  return _then(AdminAdjustPointsSubmitted(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,pointsDelta: null == pointsDelta ? _self.pointsDelta : pointsDelta // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
