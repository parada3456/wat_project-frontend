// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journey_gamification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JourneyGamificationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyGamificationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JourneyGamificationEvent()';
}


}

/// @nodoc
class $JourneyGamificationEventCopyWith<$Res>  {
$JourneyGamificationEventCopyWith(JourneyGamificationEvent _, $Res Function(JourneyGamificationEvent) __);
}


/// Adds pattern-matching-related methods to [JourneyGamificationEvent].
extension JourneyGamificationEventPatterns on JourneyGamificationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JourneyPhasesRequested value)?  journeyPhasesRequested,TResult Function( JourneyHistoryRequested value)?  journeyHistoryRequested,TResult Function( LeaderboardRequested value)?  leaderboardRequested,TResult Function( AdvancePhaseSubmitted value)?  advancePhaseSubmitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JourneyPhasesRequested() when journeyPhasesRequested != null:
return journeyPhasesRequested(_that);case JourneyHistoryRequested() when journeyHistoryRequested != null:
return journeyHistoryRequested(_that);case LeaderboardRequested() when leaderboardRequested != null:
return leaderboardRequested(_that);case AdvancePhaseSubmitted() when advancePhaseSubmitted != null:
return advancePhaseSubmitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JourneyPhasesRequested value)  journeyPhasesRequested,required TResult Function( JourneyHistoryRequested value)  journeyHistoryRequested,required TResult Function( LeaderboardRequested value)  leaderboardRequested,required TResult Function( AdvancePhaseSubmitted value)  advancePhaseSubmitted,}){
final _that = this;
switch (_that) {
case JourneyPhasesRequested():
return journeyPhasesRequested(_that);case JourneyHistoryRequested():
return journeyHistoryRequested(_that);case LeaderboardRequested():
return leaderboardRequested(_that);case AdvancePhaseSubmitted():
return advancePhaseSubmitted(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JourneyPhasesRequested value)?  journeyPhasesRequested,TResult? Function( JourneyHistoryRequested value)?  journeyHistoryRequested,TResult? Function( LeaderboardRequested value)?  leaderboardRequested,TResult? Function( AdvancePhaseSubmitted value)?  advancePhaseSubmitted,}){
final _that = this;
switch (_that) {
case JourneyPhasesRequested() when journeyPhasesRequested != null:
return journeyPhasesRequested(_that);case JourneyHistoryRequested() when journeyHistoryRequested != null:
return journeyHistoryRequested(_that);case LeaderboardRequested() when leaderboardRequested != null:
return leaderboardRequested(_that);case AdvancePhaseSubmitted() when advancePhaseSubmitted != null:
return advancePhaseSubmitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  journeyPhasesRequested,TResult Function()?  journeyHistoryRequested,TResult Function( String? scope,  String? jobId)?  leaderboardRequested,TResult Function()?  advancePhaseSubmitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JourneyPhasesRequested() when journeyPhasesRequested != null:
return journeyPhasesRequested();case JourneyHistoryRequested() when journeyHistoryRequested != null:
return journeyHistoryRequested();case LeaderboardRequested() when leaderboardRequested != null:
return leaderboardRequested(_that.scope,_that.jobId);case AdvancePhaseSubmitted() when advancePhaseSubmitted != null:
return advancePhaseSubmitted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  journeyPhasesRequested,required TResult Function()  journeyHistoryRequested,required TResult Function( String? scope,  String? jobId)  leaderboardRequested,required TResult Function()  advancePhaseSubmitted,}) {final _that = this;
switch (_that) {
case JourneyPhasesRequested():
return journeyPhasesRequested();case JourneyHistoryRequested():
return journeyHistoryRequested();case LeaderboardRequested():
return leaderboardRequested(_that.scope,_that.jobId);case AdvancePhaseSubmitted():
return advancePhaseSubmitted();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  journeyPhasesRequested,TResult? Function()?  journeyHistoryRequested,TResult? Function( String? scope,  String? jobId)?  leaderboardRequested,TResult? Function()?  advancePhaseSubmitted,}) {final _that = this;
switch (_that) {
case JourneyPhasesRequested() when journeyPhasesRequested != null:
return journeyPhasesRequested();case JourneyHistoryRequested() when journeyHistoryRequested != null:
return journeyHistoryRequested();case LeaderboardRequested() when leaderboardRequested != null:
return leaderboardRequested(_that.scope,_that.jobId);case AdvancePhaseSubmitted() when advancePhaseSubmitted != null:
return advancePhaseSubmitted();case _:
  return null;

}
}

}

/// @nodoc


class JourneyPhasesRequested implements JourneyGamificationEvent {
  const JourneyPhasesRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyPhasesRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JourneyGamificationEvent.journeyPhasesRequested()';
}


}




/// @nodoc


class JourneyHistoryRequested implements JourneyGamificationEvent {
  const JourneyHistoryRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyHistoryRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JourneyGamificationEvent.journeyHistoryRequested()';
}


}




/// @nodoc


class LeaderboardRequested implements JourneyGamificationEvent {
  const LeaderboardRequested({this.scope, this.jobId});
  

 final  String? scope;
 final  String? jobId;

/// Create a copy of JourneyGamificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderboardRequestedCopyWith<LeaderboardRequested> get copyWith => _$LeaderboardRequestedCopyWithImpl<LeaderboardRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardRequested&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.jobId, jobId) || other.jobId == jobId));
}


@override
int get hashCode => Object.hash(runtimeType,scope,jobId);

@override
String toString() {
  return 'JourneyGamificationEvent.leaderboardRequested(scope: $scope, jobId: $jobId)';
}


}

/// @nodoc
abstract mixin class $LeaderboardRequestedCopyWith<$Res> implements $JourneyGamificationEventCopyWith<$Res> {
  factory $LeaderboardRequestedCopyWith(LeaderboardRequested value, $Res Function(LeaderboardRequested) _then) = _$LeaderboardRequestedCopyWithImpl;
@useResult
$Res call({
 String? scope, String? jobId
});




}
/// @nodoc
class _$LeaderboardRequestedCopyWithImpl<$Res>
    implements $LeaderboardRequestedCopyWith<$Res> {
  _$LeaderboardRequestedCopyWithImpl(this._self, this._then);

  final LeaderboardRequested _self;
  final $Res Function(LeaderboardRequested) _then;

/// Create a copy of JourneyGamificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scope = freezed,Object? jobId = freezed,}) {
  return _then(LeaderboardRequested(
scope: freezed == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AdvancePhaseSubmitted implements JourneyGamificationEvent {
  const AdvancePhaseSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdvancePhaseSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JourneyGamificationEvent.advancePhaseSubmitted()';
}


}




/// @nodoc
mixin _$JourneyGamificationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyGamificationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JourneyGamificationState()';
}


}

/// @nodoc
class $JourneyGamificationStateCopyWith<$Res>  {
$JourneyGamificationStateCopyWith(JourneyGamificationState _, $Res Function(JourneyGamificationState) __);
}


/// Adds pattern-matching-related methods to [JourneyGamificationState].
extension JourneyGamificationStatePatterns on JourneyGamificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JourneyGamificationInitial value)?  initial,TResult Function( JourneyGamificationLoading value)?  loading,TResult Function( JourneyPhasesLoadSuccess value)?  phasesLoadSuccess,TResult Function( JourneyHistoryLoadSuccess value)?  historyLoadSuccess,TResult Function( LeaderboardLoadSuccess value)?  leaderboardLoadSuccess,TResult Function( AdvancePhaseSuccess value)?  advancePhaseSuccess,TResult Function( JourneyGamificationFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JourneyGamificationInitial() when initial != null:
return initial(_that);case JourneyGamificationLoading() when loading != null:
return loading(_that);case JourneyPhasesLoadSuccess() when phasesLoadSuccess != null:
return phasesLoadSuccess(_that);case JourneyHistoryLoadSuccess() when historyLoadSuccess != null:
return historyLoadSuccess(_that);case LeaderboardLoadSuccess() when leaderboardLoadSuccess != null:
return leaderboardLoadSuccess(_that);case AdvancePhaseSuccess() when advancePhaseSuccess != null:
return advancePhaseSuccess(_that);case JourneyGamificationFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JourneyGamificationInitial value)  initial,required TResult Function( JourneyGamificationLoading value)  loading,required TResult Function( JourneyPhasesLoadSuccess value)  phasesLoadSuccess,required TResult Function( JourneyHistoryLoadSuccess value)  historyLoadSuccess,required TResult Function( LeaderboardLoadSuccess value)  leaderboardLoadSuccess,required TResult Function( AdvancePhaseSuccess value)  advancePhaseSuccess,required TResult Function( JourneyGamificationFailure value)  failure,}){
final _that = this;
switch (_that) {
case JourneyGamificationInitial():
return initial(_that);case JourneyGamificationLoading():
return loading(_that);case JourneyPhasesLoadSuccess():
return phasesLoadSuccess(_that);case JourneyHistoryLoadSuccess():
return historyLoadSuccess(_that);case LeaderboardLoadSuccess():
return leaderboardLoadSuccess(_that);case AdvancePhaseSuccess():
return advancePhaseSuccess(_that);case JourneyGamificationFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JourneyGamificationInitial value)?  initial,TResult? Function( JourneyGamificationLoading value)?  loading,TResult? Function( JourneyPhasesLoadSuccess value)?  phasesLoadSuccess,TResult? Function( JourneyHistoryLoadSuccess value)?  historyLoadSuccess,TResult? Function( LeaderboardLoadSuccess value)?  leaderboardLoadSuccess,TResult? Function( AdvancePhaseSuccess value)?  advancePhaseSuccess,TResult? Function( JourneyGamificationFailure value)?  failure,}){
final _that = this;
switch (_that) {
case JourneyGamificationInitial() when initial != null:
return initial(_that);case JourneyGamificationLoading() when loading != null:
return loading(_that);case JourneyPhasesLoadSuccess() when phasesLoadSuccess != null:
return phasesLoadSuccess(_that);case JourneyHistoryLoadSuccess() when historyLoadSuccess != null:
return historyLoadSuccess(_that);case LeaderboardLoadSuccess() when leaderboardLoadSuccess != null:
return leaderboardLoadSuccess(_that);case AdvancePhaseSuccess() when advancePhaseSuccess != null:
return advancePhaseSuccess(_that);case JourneyGamificationFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<JourneyPhaseModel> phases)?  phasesLoadSuccess,TResult Function( List<UserPhaseHistoryModel> history)?  historyLoadSuccess,TResult Function( List<LeaderboardEntry> leaderboard)?  leaderboardLoadSuccess,TResult Function( bool success)?  advancePhaseSuccess,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JourneyGamificationInitial() when initial != null:
return initial();case JourneyGamificationLoading() when loading != null:
return loading();case JourneyPhasesLoadSuccess() when phasesLoadSuccess != null:
return phasesLoadSuccess(_that.phases);case JourneyHistoryLoadSuccess() when historyLoadSuccess != null:
return historyLoadSuccess(_that.history);case LeaderboardLoadSuccess() when leaderboardLoadSuccess != null:
return leaderboardLoadSuccess(_that.leaderboard);case AdvancePhaseSuccess() when advancePhaseSuccess != null:
return advancePhaseSuccess(_that.success);case JourneyGamificationFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<JourneyPhaseModel> phases)  phasesLoadSuccess,required TResult Function( List<UserPhaseHistoryModel> history)  historyLoadSuccess,required TResult Function( List<LeaderboardEntry> leaderboard)  leaderboardLoadSuccess,required TResult Function( bool success)  advancePhaseSuccess,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case JourneyGamificationInitial():
return initial();case JourneyGamificationLoading():
return loading();case JourneyPhasesLoadSuccess():
return phasesLoadSuccess(_that.phases);case JourneyHistoryLoadSuccess():
return historyLoadSuccess(_that.history);case LeaderboardLoadSuccess():
return leaderboardLoadSuccess(_that.leaderboard);case AdvancePhaseSuccess():
return advancePhaseSuccess(_that.success);case JourneyGamificationFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<JourneyPhaseModel> phases)?  phasesLoadSuccess,TResult? Function( List<UserPhaseHistoryModel> history)?  historyLoadSuccess,TResult? Function( List<LeaderboardEntry> leaderboard)?  leaderboardLoadSuccess,TResult? Function( bool success)?  advancePhaseSuccess,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case JourneyGamificationInitial() when initial != null:
return initial();case JourneyGamificationLoading() when loading != null:
return loading();case JourneyPhasesLoadSuccess() when phasesLoadSuccess != null:
return phasesLoadSuccess(_that.phases);case JourneyHistoryLoadSuccess() when historyLoadSuccess != null:
return historyLoadSuccess(_that.history);case LeaderboardLoadSuccess() when leaderboardLoadSuccess != null:
return leaderboardLoadSuccess(_that.leaderboard);case AdvancePhaseSuccess() when advancePhaseSuccess != null:
return advancePhaseSuccess(_that.success);case JourneyGamificationFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class JourneyGamificationInitial implements JourneyGamificationState {
  const JourneyGamificationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyGamificationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JourneyGamificationState.initial()';
}


}




/// @nodoc


class JourneyGamificationLoading implements JourneyGamificationState {
  const JourneyGamificationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyGamificationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JourneyGamificationState.loading()';
}


}




/// @nodoc


class JourneyPhasesLoadSuccess implements JourneyGamificationState {
  const JourneyPhasesLoadSuccess(final  List<JourneyPhaseModel> phases): _phases = phases;
  

 final  List<JourneyPhaseModel> _phases;
 List<JourneyPhaseModel> get phases {
  if (_phases is EqualUnmodifiableListView) return _phases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_phases);
}


/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JourneyPhasesLoadSuccessCopyWith<JourneyPhasesLoadSuccess> get copyWith => _$JourneyPhasesLoadSuccessCopyWithImpl<JourneyPhasesLoadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyPhasesLoadSuccess&&const DeepCollectionEquality().equals(other._phases, _phases));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_phases));

@override
String toString() {
  return 'JourneyGamificationState.phasesLoadSuccess(phases: $phases)';
}


}

/// @nodoc
abstract mixin class $JourneyPhasesLoadSuccessCopyWith<$Res> implements $JourneyGamificationStateCopyWith<$Res> {
  factory $JourneyPhasesLoadSuccessCopyWith(JourneyPhasesLoadSuccess value, $Res Function(JourneyPhasesLoadSuccess) _then) = _$JourneyPhasesLoadSuccessCopyWithImpl;
@useResult
$Res call({
 List<JourneyPhaseModel> phases
});




}
/// @nodoc
class _$JourneyPhasesLoadSuccessCopyWithImpl<$Res>
    implements $JourneyPhasesLoadSuccessCopyWith<$Res> {
  _$JourneyPhasesLoadSuccessCopyWithImpl(this._self, this._then);

  final JourneyPhasesLoadSuccess _self;
  final $Res Function(JourneyPhasesLoadSuccess) _then;

/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phases = null,}) {
  return _then(JourneyPhasesLoadSuccess(
null == phases ? _self._phases : phases // ignore: cast_nullable_to_non_nullable
as List<JourneyPhaseModel>,
  ));
}


}

/// @nodoc


class JourneyHistoryLoadSuccess implements JourneyGamificationState {
  const JourneyHistoryLoadSuccess(final  List<UserPhaseHistoryModel> history): _history = history;
  

 final  List<UserPhaseHistoryModel> _history;
 List<UserPhaseHistoryModel> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JourneyHistoryLoadSuccessCopyWith<JourneyHistoryLoadSuccess> get copyWith => _$JourneyHistoryLoadSuccessCopyWithImpl<JourneyHistoryLoadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyHistoryLoadSuccess&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'JourneyGamificationState.historyLoadSuccess(history: $history)';
}


}

/// @nodoc
abstract mixin class $JourneyHistoryLoadSuccessCopyWith<$Res> implements $JourneyGamificationStateCopyWith<$Res> {
  factory $JourneyHistoryLoadSuccessCopyWith(JourneyHistoryLoadSuccess value, $Res Function(JourneyHistoryLoadSuccess) _then) = _$JourneyHistoryLoadSuccessCopyWithImpl;
@useResult
$Res call({
 List<UserPhaseHistoryModel> history
});




}
/// @nodoc
class _$JourneyHistoryLoadSuccessCopyWithImpl<$Res>
    implements $JourneyHistoryLoadSuccessCopyWith<$Res> {
  _$JourneyHistoryLoadSuccessCopyWithImpl(this._self, this._then);

  final JourneyHistoryLoadSuccess _self;
  final $Res Function(JourneyHistoryLoadSuccess) _then;

/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(JourneyHistoryLoadSuccess(
null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<UserPhaseHistoryModel>,
  ));
}


}

/// @nodoc


class LeaderboardLoadSuccess implements JourneyGamificationState {
  const LeaderboardLoadSuccess(final  List<LeaderboardEntry> leaderboard): _leaderboard = leaderboard;
  

 final  List<LeaderboardEntry> _leaderboard;
 List<LeaderboardEntry> get leaderboard {
  if (_leaderboard is EqualUnmodifiableListView) return _leaderboard;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leaderboard);
}


/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderboardLoadSuccessCopyWith<LeaderboardLoadSuccess> get copyWith => _$LeaderboardLoadSuccessCopyWithImpl<LeaderboardLoadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardLoadSuccess&&const DeepCollectionEquality().equals(other._leaderboard, _leaderboard));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_leaderboard));

@override
String toString() {
  return 'JourneyGamificationState.leaderboardLoadSuccess(leaderboard: $leaderboard)';
}


}

/// @nodoc
abstract mixin class $LeaderboardLoadSuccessCopyWith<$Res> implements $JourneyGamificationStateCopyWith<$Res> {
  factory $LeaderboardLoadSuccessCopyWith(LeaderboardLoadSuccess value, $Res Function(LeaderboardLoadSuccess) _then) = _$LeaderboardLoadSuccessCopyWithImpl;
@useResult
$Res call({
 List<LeaderboardEntry> leaderboard
});




}
/// @nodoc
class _$LeaderboardLoadSuccessCopyWithImpl<$Res>
    implements $LeaderboardLoadSuccessCopyWith<$Res> {
  _$LeaderboardLoadSuccessCopyWithImpl(this._self, this._then);

  final LeaderboardLoadSuccess _self;
  final $Res Function(LeaderboardLoadSuccess) _then;

/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaderboard = null,}) {
  return _then(LeaderboardLoadSuccess(
null == leaderboard ? _self._leaderboard : leaderboard // ignore: cast_nullable_to_non_nullable
as List<LeaderboardEntry>,
  ));
}


}

/// @nodoc


class AdvancePhaseSuccess implements JourneyGamificationState {
  const AdvancePhaseSuccess(this.success);
  

 final  bool success;

/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdvancePhaseSuccessCopyWith<AdvancePhaseSuccess> get copyWith => _$AdvancePhaseSuccessCopyWithImpl<AdvancePhaseSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdvancePhaseSuccess&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,success);

@override
String toString() {
  return 'JourneyGamificationState.advancePhaseSuccess(success: $success)';
}


}

/// @nodoc
abstract mixin class $AdvancePhaseSuccessCopyWith<$Res> implements $JourneyGamificationStateCopyWith<$Res> {
  factory $AdvancePhaseSuccessCopyWith(AdvancePhaseSuccess value, $Res Function(AdvancePhaseSuccess) _then) = _$AdvancePhaseSuccessCopyWithImpl;
@useResult
$Res call({
 bool success
});




}
/// @nodoc
class _$AdvancePhaseSuccessCopyWithImpl<$Res>
    implements $AdvancePhaseSuccessCopyWith<$Res> {
  _$AdvancePhaseSuccessCopyWithImpl(this._self, this._then);

  final AdvancePhaseSuccess _self;
  final $Res Function(AdvancePhaseSuccess) _then;

/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? success = null,}) {
  return _then(AdvancePhaseSuccess(
null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class JourneyGamificationFailure implements JourneyGamificationState {
  const JourneyGamificationFailure(this.message);
  

 final  String message;

/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JourneyGamificationFailureCopyWith<JourneyGamificationFailure> get copyWith => _$JourneyGamificationFailureCopyWithImpl<JourneyGamificationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyGamificationFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'JourneyGamificationState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $JourneyGamificationFailureCopyWith<$Res> implements $JourneyGamificationStateCopyWith<$Res> {
  factory $JourneyGamificationFailureCopyWith(JourneyGamificationFailure value, $Res Function(JourneyGamificationFailure) _then) = _$JourneyGamificationFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$JourneyGamificationFailureCopyWithImpl<$Res>
    implements $JourneyGamificationFailureCopyWith<$Res> {
  _$JourneyGamificationFailureCopyWithImpl(this._self, this._then);

  final JourneyGamificationFailure _self;
  final $Res Function(JourneyGamificationFailure) _then;

/// Create a copy of JourneyGamificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(JourneyGamificationFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
