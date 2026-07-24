// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_credit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserCreditModel {

 int get rank; String get userId; String get name; String? get avatarUrl; int get creditScore;
/// Create a copy of UserCreditModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCreditModelCopyWith<UserCreditModel> get copyWith => _$UserCreditModelCopyWithImpl<UserCreditModel>(this as UserCreditModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserCreditModel&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.creditScore, creditScore) || other.creditScore == creditScore));
}


@override
int get hashCode => Object.hash(runtimeType,rank,userId,name,avatarUrl,creditScore);

@override
String toString() {
  return 'UserCreditModel(rank: $rank, userId: $userId, name: $name, avatarUrl: $avatarUrl, creditScore: $creditScore)';
}


}

/// @nodoc
abstract mixin class $UserCreditModelCopyWith<$Res>  {
  factory $UserCreditModelCopyWith(UserCreditModel value, $Res Function(UserCreditModel) _then) = _$UserCreditModelCopyWithImpl;
@useResult
$Res call({
 int rank, String userId, String name, String? avatarUrl, int creditScore
});




}
/// @nodoc
class _$UserCreditModelCopyWithImpl<$Res>
    implements $UserCreditModelCopyWith<$Res> {
  _$UserCreditModelCopyWithImpl(this._self, this._then);

  final UserCreditModel _self;
  final $Res Function(UserCreditModel) _then;

/// Create a copy of UserCreditModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = null,Object? userId = null,Object? name = null,Object? avatarUrl = freezed,Object? creditScore = null,}) {
  return _then(_self.copyWith(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,creditScore: null == creditScore ? _self.creditScore : creditScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserCreditModel].
extension UserCreditModelPatterns on UserCreditModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserCreditModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserCreditModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserCreditModel value)  $default,){
final _that = this;
switch (_that) {
case _UserCreditModel():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserCreditModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserCreditModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rank,  String userId,  String name,  String? avatarUrl,  int creditScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserCreditModel() when $default != null:
return $default(_that.rank,_that.userId,_that.name,_that.avatarUrl,_that.creditScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rank,  String userId,  String name,  String? avatarUrl,  int creditScore)  $default,) {final _that = this;
switch (_that) {
case _UserCreditModel():
return $default(_that.rank,_that.userId,_that.name,_that.avatarUrl,_that.creditScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rank,  String userId,  String name,  String? avatarUrl,  int creditScore)?  $default,) {final _that = this;
switch (_that) {
case _UserCreditModel() when $default != null:
return $default(_that.rank,_that.userId,_that.name,_that.avatarUrl,_that.creditScore);case _:
  return null;

}
}

}

/// @nodoc


class _UserCreditModel implements UserCreditModel {
  const _UserCreditModel({required this.rank, required this.userId, required this.name, this.avatarUrl, required this.creditScore});
  

@override final  int rank;
@override final  String userId;
@override final  String name;
@override final  String? avatarUrl;
@override final  int creditScore;

/// Create a copy of UserCreditModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCreditModelCopyWith<_UserCreditModel> get copyWith => __$UserCreditModelCopyWithImpl<_UserCreditModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCreditModel&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.creditScore, creditScore) || other.creditScore == creditScore));
}


@override
int get hashCode => Object.hash(runtimeType,rank,userId,name,avatarUrl,creditScore);

@override
String toString() {
  return 'UserCreditModel(rank: $rank, userId: $userId, name: $name, avatarUrl: $avatarUrl, creditScore: $creditScore)';
}


}

/// @nodoc
abstract mixin class _$UserCreditModelCopyWith<$Res> implements $UserCreditModelCopyWith<$Res> {
  factory _$UserCreditModelCopyWith(_UserCreditModel value, $Res Function(_UserCreditModel) _then) = __$UserCreditModelCopyWithImpl;
@override @useResult
$Res call({
 int rank, String userId, String name, String? avatarUrl, int creditScore
});




}
/// @nodoc
class __$UserCreditModelCopyWithImpl<$Res>
    implements _$UserCreditModelCopyWith<$Res> {
  __$UserCreditModelCopyWithImpl(this._self, this._then);

  final _UserCreditModel _self;
  final $Res Function(_UserCreditModel) _then;

/// Create a copy of UserCreditModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = null,Object? userId = null,Object? name = null,Object? avatarUrl = freezed,Object? creditScore = null,}) {
  return _then(_UserCreditModel(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,creditScore: null == creditScore ? _self.creditScore : creditScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
