// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journey_gamification_event.dart';

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




// dart format on
