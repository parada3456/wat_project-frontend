// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_task_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MissionTaskEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionTaskEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MissionTaskEvent()';
}


}

/// @nodoc
class $MissionTaskEventCopyWith<$Res>  {
$MissionTaskEventCopyWith(MissionTaskEvent _, $Res Function(MissionTaskEvent) __);
}


/// Adds pattern-matching-related methods to [MissionTaskEvent].
extension MissionTaskEventPatterns on MissionTaskEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MissionsTasksListRequested value)?  listRequested,TResult Function( MissionTaskDetailRequested value)?  detailRequested,TResult Function( MissionTaskProofSubmitted value)?  proofSubmitted,TResult Function( MissionTaskToggleRequested value)?  toggleRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MissionsTasksListRequested() when listRequested != null:
return listRequested(_that);case MissionTaskDetailRequested() when detailRequested != null:
return detailRequested(_that);case MissionTaskProofSubmitted() when proofSubmitted != null:
return proofSubmitted(_that);case MissionTaskToggleRequested() when toggleRequested != null:
return toggleRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MissionsTasksListRequested value)  listRequested,required TResult Function( MissionTaskDetailRequested value)  detailRequested,required TResult Function( MissionTaskProofSubmitted value)  proofSubmitted,required TResult Function( MissionTaskToggleRequested value)  toggleRequested,}){
final _that = this;
switch (_that) {
case MissionsTasksListRequested():
return listRequested(_that);case MissionTaskDetailRequested():
return detailRequested(_that);case MissionTaskProofSubmitted():
return proofSubmitted(_that);case MissionTaskToggleRequested():
return toggleRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MissionsTasksListRequested value)?  listRequested,TResult? Function( MissionTaskDetailRequested value)?  detailRequested,TResult? Function( MissionTaskProofSubmitted value)?  proofSubmitted,TResult? Function( MissionTaskToggleRequested value)?  toggleRequested,}){
final _that = this;
switch (_that) {
case MissionsTasksListRequested() when listRequested != null:
return listRequested(_that);case MissionTaskDetailRequested() when detailRequested != null:
return detailRequested(_that);case MissionTaskProofSubmitted() when proofSubmitted != null:
return proofSubmitted(_that);case MissionTaskToggleRequested() when toggleRequested != null:
return toggleRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  listRequested,TResult Function( String missionId)?  detailRequested,TResult Function( String missionId,  File file)?  proofSubmitted,TResult Function( String userMissionId,  String taskId,  bool completed)?  toggleRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MissionsTasksListRequested() when listRequested != null:
return listRequested();case MissionTaskDetailRequested() when detailRequested != null:
return detailRequested(_that.missionId);case MissionTaskProofSubmitted() when proofSubmitted != null:
return proofSubmitted(_that.missionId,_that.file);case MissionTaskToggleRequested() when toggleRequested != null:
return toggleRequested(_that.userMissionId,_that.taskId,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  listRequested,required TResult Function( String missionId)  detailRequested,required TResult Function( String missionId,  File file)  proofSubmitted,required TResult Function( String userMissionId,  String taskId,  bool completed)  toggleRequested,}) {final _that = this;
switch (_that) {
case MissionsTasksListRequested():
return listRequested();case MissionTaskDetailRequested():
return detailRequested(_that.missionId);case MissionTaskProofSubmitted():
return proofSubmitted(_that.missionId,_that.file);case MissionTaskToggleRequested():
return toggleRequested(_that.userMissionId,_that.taskId,_that.completed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  listRequested,TResult? Function( String missionId)?  detailRequested,TResult? Function( String missionId,  File file)?  proofSubmitted,TResult? Function( String userMissionId,  String taskId,  bool completed)?  toggleRequested,}) {final _that = this;
switch (_that) {
case MissionsTasksListRequested() when listRequested != null:
return listRequested();case MissionTaskDetailRequested() when detailRequested != null:
return detailRequested(_that.missionId);case MissionTaskProofSubmitted() when proofSubmitted != null:
return proofSubmitted(_that.missionId,_that.file);case MissionTaskToggleRequested() when toggleRequested != null:
return toggleRequested(_that.userMissionId,_that.taskId,_that.completed);case _:
  return null;

}
}

}

/// @nodoc


class MissionsTasksListRequested implements MissionTaskEvent {
  const MissionsTasksListRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionsTasksListRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MissionTaskEvent.listRequested()';
}


}




/// @nodoc


class MissionTaskDetailRequested implements MissionTaskEvent {
  const MissionTaskDetailRequested(this.missionId);
  

 final  String missionId;

/// Create a copy of MissionTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionTaskDetailRequestedCopyWith<MissionTaskDetailRequested> get copyWith => _$MissionTaskDetailRequestedCopyWithImpl<MissionTaskDetailRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionTaskDetailRequested&&(identical(other.missionId, missionId) || other.missionId == missionId));
}


@override
int get hashCode => Object.hash(runtimeType,missionId);

@override
String toString() {
  return 'MissionTaskEvent.detailRequested(missionId: $missionId)';
}


}

/// @nodoc
abstract mixin class $MissionTaskDetailRequestedCopyWith<$Res> implements $MissionTaskEventCopyWith<$Res> {
  factory $MissionTaskDetailRequestedCopyWith(MissionTaskDetailRequested value, $Res Function(MissionTaskDetailRequested) _then) = _$MissionTaskDetailRequestedCopyWithImpl;
@useResult
$Res call({
 String missionId
});




}
/// @nodoc
class _$MissionTaskDetailRequestedCopyWithImpl<$Res>
    implements $MissionTaskDetailRequestedCopyWith<$Res> {
  _$MissionTaskDetailRequestedCopyWithImpl(this._self, this._then);

  final MissionTaskDetailRequested _self;
  final $Res Function(MissionTaskDetailRequested) _then;

/// Create a copy of MissionTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? missionId = null,}) {
  return _then(MissionTaskDetailRequested(
null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MissionTaskProofSubmitted implements MissionTaskEvent {
  const MissionTaskProofSubmitted({required this.missionId, required this.file});
  

 final  String missionId;
 final  File file;

/// Create a copy of MissionTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionTaskProofSubmittedCopyWith<MissionTaskProofSubmitted> get copyWith => _$MissionTaskProofSubmittedCopyWithImpl<MissionTaskProofSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionTaskProofSubmitted&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,missionId,file);

@override
String toString() {
  return 'MissionTaskEvent.proofSubmitted(missionId: $missionId, file: $file)';
}


}

/// @nodoc
abstract mixin class $MissionTaskProofSubmittedCopyWith<$Res> implements $MissionTaskEventCopyWith<$Res> {
  factory $MissionTaskProofSubmittedCopyWith(MissionTaskProofSubmitted value, $Res Function(MissionTaskProofSubmitted) _then) = _$MissionTaskProofSubmittedCopyWithImpl;
@useResult
$Res call({
 String missionId, File file
});




}
/// @nodoc
class _$MissionTaskProofSubmittedCopyWithImpl<$Res>
    implements $MissionTaskProofSubmittedCopyWith<$Res> {
  _$MissionTaskProofSubmittedCopyWithImpl(this._self, this._then);

  final MissionTaskProofSubmitted _self;
  final $Res Function(MissionTaskProofSubmitted) _then;

/// Create a copy of MissionTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? missionId = null,Object? file = null,}) {
  return _then(MissionTaskProofSubmitted(
missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class MissionTaskToggleRequested implements MissionTaskEvent {
  const MissionTaskToggleRequested({required this.userMissionId, required this.taskId, required this.completed});
  

 final  String userMissionId;
 final  String taskId;
 final  bool completed;

/// Create a copy of MissionTaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionTaskToggleRequestedCopyWith<MissionTaskToggleRequested> get copyWith => _$MissionTaskToggleRequestedCopyWithImpl<MissionTaskToggleRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionTaskToggleRequested&&(identical(other.userMissionId, userMissionId) || other.userMissionId == userMissionId)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.completed, completed) || other.completed == completed));
}


@override
int get hashCode => Object.hash(runtimeType,userMissionId,taskId,completed);

@override
String toString() {
  return 'MissionTaskEvent.toggleRequested(userMissionId: $userMissionId, taskId: $taskId, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $MissionTaskToggleRequestedCopyWith<$Res> implements $MissionTaskEventCopyWith<$Res> {
  factory $MissionTaskToggleRequestedCopyWith(MissionTaskToggleRequested value, $Res Function(MissionTaskToggleRequested) _then) = _$MissionTaskToggleRequestedCopyWithImpl;
@useResult
$Res call({
 String userMissionId, String taskId, bool completed
});




}
/// @nodoc
class _$MissionTaskToggleRequestedCopyWithImpl<$Res>
    implements $MissionTaskToggleRequestedCopyWith<$Res> {
  _$MissionTaskToggleRequestedCopyWithImpl(this._self, this._then);

  final MissionTaskToggleRequested _self;
  final $Res Function(MissionTaskToggleRequested) _then;

/// Create a copy of MissionTaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userMissionId = null,Object? taskId = null,Object? completed = null,}) {
  return _then(MissionTaskToggleRequested(
userMissionId: null == userMissionId ? _self.userMissionId : userMissionId // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$MissionTaskState {

 UIStatus get status; List<MissionDetailModel> get missions; MissionDetailModel? get detail;
/// Create a copy of MissionTaskState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionTaskStateCopyWith<MissionTaskState> get copyWith => _$MissionTaskStateCopyWithImpl<MissionTaskState>(this as MissionTaskState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionTaskState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.missions, missions)&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(missions),detail);

@override
String toString() {
  return 'MissionTaskState(status: $status, missions: $missions, detail: $detail)';
}


}

/// @nodoc
abstract mixin class $MissionTaskStateCopyWith<$Res>  {
  factory $MissionTaskStateCopyWith(MissionTaskState value, $Res Function(MissionTaskState) _then) = _$MissionTaskStateCopyWithImpl;
@useResult
$Res call({
 UIStatus status, List<MissionDetailModel> missions, MissionDetailModel? detail
});


$UIStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$MissionTaskStateCopyWithImpl<$Res>
    implements $MissionTaskStateCopyWith<$Res> {
  _$MissionTaskStateCopyWithImpl(this._self, this._then);

  final MissionTaskState _self;
  final $Res Function(MissionTaskState) _then;

/// Create a copy of MissionTaskState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? missions = null,Object? detail = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,missions: null == missions ? _self.missions : missions // ignore: cast_nullable_to_non_nullable
as List<MissionDetailModel>,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as MissionDetailModel?,
  ));
}
/// Create a copy of MissionTaskState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get status {
  
  return $UIStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [MissionTaskState].
extension MissionTaskStatePatterns on MissionTaskState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionTaskState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionTaskState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionTaskState value)  $default,){
final _that = this;
switch (_that) {
case _MissionTaskState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionTaskState value)?  $default,){
final _that = this;
switch (_that) {
case _MissionTaskState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UIStatus status,  List<MissionDetailModel> missions,  MissionDetailModel? detail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionTaskState() when $default != null:
return $default(_that.status,_that.missions,_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UIStatus status,  List<MissionDetailModel> missions,  MissionDetailModel? detail)  $default,) {final _that = this;
switch (_that) {
case _MissionTaskState():
return $default(_that.status,_that.missions,_that.detail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UIStatus status,  List<MissionDetailModel> missions,  MissionDetailModel? detail)?  $default,) {final _that = this;
switch (_that) {
case _MissionTaskState() when $default != null:
return $default(_that.status,_that.missions,_that.detail);case _:
  return null;

}
}

}

/// @nodoc


class _MissionTaskState implements MissionTaskState {
  const _MissionTaskState({this.status = const UIStatus.initial(), final  List<MissionDetailModel> missions = const [], this.detail}): _missions = missions;
  

@override@JsonKey() final  UIStatus status;
 final  List<MissionDetailModel> _missions;
@override@JsonKey() List<MissionDetailModel> get missions {
  if (_missions is EqualUnmodifiableListView) return _missions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missions);
}

@override final  MissionDetailModel? detail;

/// Create a copy of MissionTaskState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionTaskStateCopyWith<_MissionTaskState> get copyWith => __$MissionTaskStateCopyWithImpl<_MissionTaskState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionTaskState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._missions, _missions)&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_missions),detail);

@override
String toString() {
  return 'MissionTaskState(status: $status, missions: $missions, detail: $detail)';
}


}

/// @nodoc
abstract mixin class _$MissionTaskStateCopyWith<$Res> implements $MissionTaskStateCopyWith<$Res> {
  factory _$MissionTaskStateCopyWith(_MissionTaskState value, $Res Function(_MissionTaskState) _then) = __$MissionTaskStateCopyWithImpl;
@override @useResult
$Res call({
 UIStatus status, List<MissionDetailModel> missions, MissionDetailModel? detail
});


@override $UIStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$MissionTaskStateCopyWithImpl<$Res>
    implements _$MissionTaskStateCopyWith<$Res> {
  __$MissionTaskStateCopyWithImpl(this._self, this._then);

  final _MissionTaskState _self;
  final $Res Function(_MissionTaskState) _then;

/// Create a copy of MissionTaskState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? missions = null,Object? detail = freezed,}) {
  return _then(_MissionTaskState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,missions: null == missions ? _self._missions : missions // ignore: cast_nullable_to_non_nullable
as List<MissionDetailModel>,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as MissionDetailModel?,
  ));
}

/// Create a copy of MissionTaskState
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
