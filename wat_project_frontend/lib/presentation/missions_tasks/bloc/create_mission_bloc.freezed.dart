// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_mission_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateMissionEvent {

 CreateMissionRequest get request;
/// Create a copy of CreateMissionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateMissionEventCopyWith<CreateMissionEvent> get copyWith => _$CreateMissionEventCopyWithImpl<CreateMissionEvent>(this as CreateMissionEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateMissionEvent&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'CreateMissionEvent(request: $request)';
}


}

/// @nodoc
abstract mixin class $CreateMissionEventCopyWith<$Res>  {
  factory $CreateMissionEventCopyWith(CreateMissionEvent value, $Res Function(CreateMissionEvent) _then) = _$CreateMissionEventCopyWithImpl;
@useResult
$Res call({
 CreateMissionRequest request
});




}
/// @nodoc
class _$CreateMissionEventCopyWithImpl<$Res>
    implements $CreateMissionEventCopyWith<$Res> {
  _$CreateMissionEventCopyWithImpl(this._self, this._then);

  final CreateMissionEvent _self;
  final $Res Function(CreateMissionEvent) _then;

/// Create a copy of CreateMissionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? request = null,}) {
  return _then(_self.copyWith(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CreateMissionRequest,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateMissionEvent].
extension CreateMissionEventPatterns on CreateMissionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CreateMissionSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CreateMissionSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CreateMissionSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case CreateMissionSubmitted():
return submitted(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CreateMissionSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case CreateMissionSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CreateMissionRequest request)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CreateMissionSubmitted() when submitted != null:
return submitted(_that.request);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CreateMissionRequest request)  submitted,}) {final _that = this;
switch (_that) {
case CreateMissionSubmitted():
return submitted(_that.request);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CreateMissionRequest request)?  submitted,}) {final _that = this;
switch (_that) {
case CreateMissionSubmitted() when submitted != null:
return submitted(_that.request);case _:
  return null;

}
}

}

/// @nodoc


class CreateMissionSubmitted implements CreateMissionEvent {
  const CreateMissionSubmitted({required this.request});
  

@override final  CreateMissionRequest request;

/// Create a copy of CreateMissionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateMissionSubmittedCopyWith<CreateMissionSubmitted> get copyWith => _$CreateMissionSubmittedCopyWithImpl<CreateMissionSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateMissionSubmitted&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'CreateMissionEvent.submitted(request: $request)';
}


}

/// @nodoc
abstract mixin class $CreateMissionSubmittedCopyWith<$Res> implements $CreateMissionEventCopyWith<$Res> {
  factory $CreateMissionSubmittedCopyWith(CreateMissionSubmitted value, $Res Function(CreateMissionSubmitted) _then) = _$CreateMissionSubmittedCopyWithImpl;
@override @useResult
$Res call({
 CreateMissionRequest request
});




}
/// @nodoc
class _$CreateMissionSubmittedCopyWithImpl<$Res>
    implements $CreateMissionSubmittedCopyWith<$Res> {
  _$CreateMissionSubmittedCopyWithImpl(this._self, this._then);

  final CreateMissionSubmitted _self;
  final $Res Function(CreateMissionSubmitted) _then;

/// Create a copy of CreateMissionEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(CreateMissionSubmitted(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CreateMissionRequest,
  ));
}


}

/// @nodoc
mixin _$CreateMissionState {

 UIStatus get status; MissionModel? get createdMission;
/// Create a copy of CreateMissionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateMissionStateCopyWith<CreateMissionState> get copyWith => _$CreateMissionStateCopyWithImpl<CreateMissionState>(this as CreateMissionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateMissionState&&(identical(other.status, status) || other.status == status)&&(identical(other.createdMission, createdMission) || other.createdMission == createdMission));
}


@override
int get hashCode => Object.hash(runtimeType,status,createdMission);

@override
String toString() {
  return 'CreateMissionState(status: $status, createdMission: $createdMission)';
}


}

/// @nodoc
abstract mixin class $CreateMissionStateCopyWith<$Res>  {
  factory $CreateMissionStateCopyWith(CreateMissionState value, $Res Function(CreateMissionState) _then) = _$CreateMissionStateCopyWithImpl;
@useResult
$Res call({
 UIStatus status, MissionModel? createdMission
});


$UIStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$CreateMissionStateCopyWithImpl<$Res>
    implements $CreateMissionStateCopyWith<$Res> {
  _$CreateMissionStateCopyWithImpl(this._self, this._then);

  final CreateMissionState _self;
  final $Res Function(CreateMissionState) _then;

/// Create a copy of CreateMissionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? createdMission = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,createdMission: freezed == createdMission ? _self.createdMission : createdMission // ignore: cast_nullable_to_non_nullable
as MissionModel?,
  ));
}
/// Create a copy of CreateMissionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get status {
  
  return $UIStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateMissionState].
extension CreateMissionStatePatterns on CreateMissionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateMissionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateMissionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateMissionState value)  $default,){
final _that = this;
switch (_that) {
case _CreateMissionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateMissionState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateMissionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UIStatus status,  MissionModel? createdMission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateMissionState() when $default != null:
return $default(_that.status,_that.createdMission);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UIStatus status,  MissionModel? createdMission)  $default,) {final _that = this;
switch (_that) {
case _CreateMissionState():
return $default(_that.status,_that.createdMission);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UIStatus status,  MissionModel? createdMission)?  $default,) {final _that = this;
switch (_that) {
case _CreateMissionState() when $default != null:
return $default(_that.status,_that.createdMission);case _:
  return null;

}
}

}

/// @nodoc


class _CreateMissionState implements CreateMissionState {
  const _CreateMissionState({this.status = const UIStatus.initial(), this.createdMission});
  

@override@JsonKey() final  UIStatus status;
@override final  MissionModel? createdMission;

/// Create a copy of CreateMissionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateMissionStateCopyWith<_CreateMissionState> get copyWith => __$CreateMissionStateCopyWithImpl<_CreateMissionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateMissionState&&(identical(other.status, status) || other.status == status)&&(identical(other.createdMission, createdMission) || other.createdMission == createdMission));
}


@override
int get hashCode => Object.hash(runtimeType,status,createdMission);

@override
String toString() {
  return 'CreateMissionState(status: $status, createdMission: $createdMission)';
}


}

/// @nodoc
abstract mixin class _$CreateMissionStateCopyWith<$Res> implements $CreateMissionStateCopyWith<$Res> {
  factory _$CreateMissionStateCopyWith(_CreateMissionState value, $Res Function(_CreateMissionState) _then) = __$CreateMissionStateCopyWithImpl;
@override @useResult
$Res call({
 UIStatus status, MissionModel? createdMission
});


@override $UIStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$CreateMissionStateCopyWithImpl<$Res>
    implements _$CreateMissionStateCopyWith<$Res> {
  __$CreateMissionStateCopyWithImpl(this._self, this._then);

  final _CreateMissionState _self;
  final $Res Function(_CreateMissionState) _then;

/// Create a copy of CreateMissionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? createdMission = freezed,}) {
  return _then(_CreateMissionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,createdMission: freezed == createdMission ? _self.createdMission : createdMission // ignore: cast_nullable_to_non_nullable
as MissionModel?,
  ));
}

/// Create a copy of CreateMissionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get status {
  
  return $UIStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
