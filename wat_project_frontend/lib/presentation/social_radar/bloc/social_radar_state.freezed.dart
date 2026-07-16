// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_radar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SocialRadarState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialRadarState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarState()';
}


}

/// @nodoc
class $SocialRadarStateCopyWith<$Res>  {
$SocialRadarStateCopyWith(SocialRadarState _, $Res Function(SocialRadarState) __);
}


/// Adds pattern-matching-related methods to [SocialRadarState].
extension SocialRadarStatePatterns on SocialRadarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SocialRadarInitial value)?  initial,TResult Function( SocialRadarLoading value)?  loading,TResult Function( SocialRadarFailure value)?  failure,TResult Function( SocialRadarLoadSuccess value)?  loadSuccess,TResult Function( RadarUsersLoadSuccess value)?  radarUsersLoadSuccess,TResult Function( PendingRequestsLoadSuccess value)?  pendingRequestsLoadSuccess,TResult Function( FriendsLoadSuccess value)?  friendsLoadSuccess,TResult Function( SendFriendRequestSuccess value)?  sendFriendRequestSuccess,TResult Function( RespondToFriendRequestSuccess value)?  respondToFriendRequestSuccess,TResult Function( RemoveFriendSuccess value)?  removeFriendSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SocialRadarInitial() when initial != null:
return initial(_that);case SocialRadarLoading() when loading != null:
return loading(_that);case SocialRadarFailure() when failure != null:
return failure(_that);case SocialRadarLoadSuccess() when loadSuccess != null:
return loadSuccess(_that);case RadarUsersLoadSuccess() when radarUsersLoadSuccess != null:
return radarUsersLoadSuccess(_that);case PendingRequestsLoadSuccess() when pendingRequestsLoadSuccess != null:
return pendingRequestsLoadSuccess(_that);case FriendsLoadSuccess() when friendsLoadSuccess != null:
return friendsLoadSuccess(_that);case SendFriendRequestSuccess() when sendFriendRequestSuccess != null:
return sendFriendRequestSuccess(_that);case RespondToFriendRequestSuccess() when respondToFriendRequestSuccess != null:
return respondToFriendRequestSuccess(_that);case RemoveFriendSuccess() when removeFriendSuccess != null:
return removeFriendSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SocialRadarInitial value)  initial,required TResult Function( SocialRadarLoading value)  loading,required TResult Function( SocialRadarFailure value)  failure,required TResult Function( SocialRadarLoadSuccess value)  loadSuccess,required TResult Function( RadarUsersLoadSuccess value)  radarUsersLoadSuccess,required TResult Function( PendingRequestsLoadSuccess value)  pendingRequestsLoadSuccess,required TResult Function( FriendsLoadSuccess value)  friendsLoadSuccess,required TResult Function( SendFriendRequestSuccess value)  sendFriendRequestSuccess,required TResult Function( RespondToFriendRequestSuccess value)  respondToFriendRequestSuccess,required TResult Function( RemoveFriendSuccess value)  removeFriendSuccess,}){
final _that = this;
switch (_that) {
case SocialRadarInitial():
return initial(_that);case SocialRadarLoading():
return loading(_that);case SocialRadarFailure():
return failure(_that);case SocialRadarLoadSuccess():
return loadSuccess(_that);case RadarUsersLoadSuccess():
return radarUsersLoadSuccess(_that);case PendingRequestsLoadSuccess():
return pendingRequestsLoadSuccess(_that);case FriendsLoadSuccess():
return friendsLoadSuccess(_that);case SendFriendRequestSuccess():
return sendFriendRequestSuccess(_that);case RespondToFriendRequestSuccess():
return respondToFriendRequestSuccess(_that);case RemoveFriendSuccess():
return removeFriendSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SocialRadarInitial value)?  initial,TResult? Function( SocialRadarLoading value)?  loading,TResult? Function( SocialRadarFailure value)?  failure,TResult? Function( SocialRadarLoadSuccess value)?  loadSuccess,TResult? Function( RadarUsersLoadSuccess value)?  radarUsersLoadSuccess,TResult? Function( PendingRequestsLoadSuccess value)?  pendingRequestsLoadSuccess,TResult? Function( FriendsLoadSuccess value)?  friendsLoadSuccess,TResult? Function( SendFriendRequestSuccess value)?  sendFriendRequestSuccess,TResult? Function( RespondToFriendRequestSuccess value)?  respondToFriendRequestSuccess,TResult? Function( RemoveFriendSuccess value)?  removeFriendSuccess,}){
final _that = this;
switch (_that) {
case SocialRadarInitial() when initial != null:
return initial(_that);case SocialRadarLoading() when loading != null:
return loading(_that);case SocialRadarFailure() when failure != null:
return failure(_that);case SocialRadarLoadSuccess() when loadSuccess != null:
return loadSuccess(_that);case RadarUsersLoadSuccess() when radarUsersLoadSuccess != null:
return radarUsersLoadSuccess(_that);case PendingRequestsLoadSuccess() when pendingRequestsLoadSuccess != null:
return pendingRequestsLoadSuccess(_that);case FriendsLoadSuccess() when friendsLoadSuccess != null:
return friendsLoadSuccess(_that);case SendFriendRequestSuccess() when sendFriendRequestSuccess != null:
return sendFriendRequestSuccess(_that);case RespondToFriendRequestSuccess() when respondToFriendRequestSuccess != null:
return respondToFriendRequestSuccess(_that);case RemoveFriendSuccess() when removeFriendSuccess != null:
return removeFriendSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  failure,TResult Function( List<RadarEntry> radarUsers,  List<FriendshipModel> friends,  List<FriendshipModel> pendingRequests)?  loadSuccess,TResult Function( List<RadarEntry> radarUsers)?  radarUsersLoadSuccess,TResult Function( List<FriendshipModel> pendingRequests)?  pendingRequestsLoadSuccess,TResult Function( List<FriendshipModel> friends)?  friendsLoadSuccess,TResult Function()?  sendFriendRequestSuccess,TResult Function()?  respondToFriendRequestSuccess,TResult Function()?  removeFriendSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SocialRadarInitial() when initial != null:
return initial();case SocialRadarLoading() when loading != null:
return loading();case SocialRadarFailure() when failure != null:
return failure(_that.message);case SocialRadarLoadSuccess() when loadSuccess != null:
return loadSuccess(_that.radarUsers,_that.friends,_that.pendingRequests);case RadarUsersLoadSuccess() when radarUsersLoadSuccess != null:
return radarUsersLoadSuccess(_that.radarUsers);case PendingRequestsLoadSuccess() when pendingRequestsLoadSuccess != null:
return pendingRequestsLoadSuccess(_that.pendingRequests);case FriendsLoadSuccess() when friendsLoadSuccess != null:
return friendsLoadSuccess(_that.friends);case SendFriendRequestSuccess() when sendFriendRequestSuccess != null:
return sendFriendRequestSuccess();case RespondToFriendRequestSuccess() when respondToFriendRequestSuccess != null:
return respondToFriendRequestSuccess();case RemoveFriendSuccess() when removeFriendSuccess != null:
return removeFriendSuccess();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  failure,required TResult Function( List<RadarEntry> radarUsers,  List<FriendshipModel> friends,  List<FriendshipModel> pendingRequests)  loadSuccess,required TResult Function( List<RadarEntry> radarUsers)  radarUsersLoadSuccess,required TResult Function( List<FriendshipModel> pendingRequests)  pendingRequestsLoadSuccess,required TResult Function( List<FriendshipModel> friends)  friendsLoadSuccess,required TResult Function()  sendFriendRequestSuccess,required TResult Function()  respondToFriendRequestSuccess,required TResult Function()  removeFriendSuccess,}) {final _that = this;
switch (_that) {
case SocialRadarInitial():
return initial();case SocialRadarLoading():
return loading();case SocialRadarFailure():
return failure(_that.message);case SocialRadarLoadSuccess():
return loadSuccess(_that.radarUsers,_that.friends,_that.pendingRequests);case RadarUsersLoadSuccess():
return radarUsersLoadSuccess(_that.radarUsers);case PendingRequestsLoadSuccess():
return pendingRequestsLoadSuccess(_that.pendingRequests);case FriendsLoadSuccess():
return friendsLoadSuccess(_that.friends);case SendFriendRequestSuccess():
return sendFriendRequestSuccess();case RespondToFriendRequestSuccess():
return respondToFriendRequestSuccess();case RemoveFriendSuccess():
return removeFriendSuccess();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  failure,TResult? Function( List<RadarEntry> radarUsers,  List<FriendshipModel> friends,  List<FriendshipModel> pendingRequests)?  loadSuccess,TResult? Function( List<RadarEntry> radarUsers)?  radarUsersLoadSuccess,TResult? Function( List<FriendshipModel> pendingRequests)?  pendingRequestsLoadSuccess,TResult? Function( List<FriendshipModel> friends)?  friendsLoadSuccess,TResult? Function()?  sendFriendRequestSuccess,TResult? Function()?  respondToFriendRequestSuccess,TResult? Function()?  removeFriendSuccess,}) {final _that = this;
switch (_that) {
case SocialRadarInitial() when initial != null:
return initial();case SocialRadarLoading() when loading != null:
return loading();case SocialRadarFailure() when failure != null:
return failure(_that.message);case SocialRadarLoadSuccess() when loadSuccess != null:
return loadSuccess(_that.radarUsers,_that.friends,_that.pendingRequests);case RadarUsersLoadSuccess() when radarUsersLoadSuccess != null:
return radarUsersLoadSuccess(_that.radarUsers);case PendingRequestsLoadSuccess() when pendingRequestsLoadSuccess != null:
return pendingRequestsLoadSuccess(_that.pendingRequests);case FriendsLoadSuccess() when friendsLoadSuccess != null:
return friendsLoadSuccess(_that.friends);case SendFriendRequestSuccess() when sendFriendRequestSuccess != null:
return sendFriendRequestSuccess();case RespondToFriendRequestSuccess() when respondToFriendRequestSuccess != null:
return respondToFriendRequestSuccess();case RemoveFriendSuccess() when removeFriendSuccess != null:
return removeFriendSuccess();case _:
  return null;

}
}

}

/// @nodoc


class SocialRadarInitial implements SocialRadarState {
  const SocialRadarInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialRadarInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarState.initial()';
}


}




/// @nodoc


class SocialRadarLoading implements SocialRadarState {
  const SocialRadarLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialRadarLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarState.loading()';
}


}




/// @nodoc


class SocialRadarFailure implements SocialRadarState {
  const SocialRadarFailure(this.message);
  

 final  String message;

/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialRadarFailureCopyWith<SocialRadarFailure> get copyWith => _$SocialRadarFailureCopyWithImpl<SocialRadarFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialRadarFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SocialRadarState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $SocialRadarFailureCopyWith<$Res> implements $SocialRadarStateCopyWith<$Res> {
  factory $SocialRadarFailureCopyWith(SocialRadarFailure value, $Res Function(SocialRadarFailure) _then) = _$SocialRadarFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SocialRadarFailureCopyWithImpl<$Res>
    implements $SocialRadarFailureCopyWith<$Res> {
  _$SocialRadarFailureCopyWithImpl(this._self, this._then);

  final SocialRadarFailure _self;
  final $Res Function(SocialRadarFailure) _then;

/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SocialRadarFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SocialRadarLoadSuccess implements SocialRadarState {
  const SocialRadarLoadSuccess({required final  List<RadarEntry> radarUsers, required final  List<FriendshipModel> friends, required final  List<FriendshipModel> pendingRequests}): _radarUsers = radarUsers,_friends = friends,_pendingRequests = pendingRequests;
  

 final  List<RadarEntry> _radarUsers;
 List<RadarEntry> get radarUsers {
  if (_radarUsers is EqualUnmodifiableListView) return _radarUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_radarUsers);
}

 final  List<FriendshipModel> _friends;
 List<FriendshipModel> get friends {
  if (_friends is EqualUnmodifiableListView) return _friends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_friends);
}

 final  List<FriendshipModel> _pendingRequests;
 List<FriendshipModel> get pendingRequests {
  if (_pendingRequests is EqualUnmodifiableListView) return _pendingRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingRequests);
}


/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialRadarLoadSuccessCopyWith<SocialRadarLoadSuccess> get copyWith => _$SocialRadarLoadSuccessCopyWithImpl<SocialRadarLoadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialRadarLoadSuccess&&const DeepCollectionEquality().equals(other._radarUsers, _radarUsers)&&const DeepCollectionEquality().equals(other._friends, _friends)&&const DeepCollectionEquality().equals(other._pendingRequests, _pendingRequests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_radarUsers),const DeepCollectionEquality().hash(_friends),const DeepCollectionEquality().hash(_pendingRequests));

@override
String toString() {
  return 'SocialRadarState.loadSuccess(radarUsers: $radarUsers, friends: $friends, pendingRequests: $pendingRequests)';
}


}

/// @nodoc
abstract mixin class $SocialRadarLoadSuccessCopyWith<$Res> implements $SocialRadarStateCopyWith<$Res> {
  factory $SocialRadarLoadSuccessCopyWith(SocialRadarLoadSuccess value, $Res Function(SocialRadarLoadSuccess) _then) = _$SocialRadarLoadSuccessCopyWithImpl;
@useResult
$Res call({
 List<RadarEntry> radarUsers, List<FriendshipModel> friends, List<FriendshipModel> pendingRequests
});




}
/// @nodoc
class _$SocialRadarLoadSuccessCopyWithImpl<$Res>
    implements $SocialRadarLoadSuccessCopyWith<$Res> {
  _$SocialRadarLoadSuccessCopyWithImpl(this._self, this._then);

  final SocialRadarLoadSuccess _self;
  final $Res Function(SocialRadarLoadSuccess) _then;

/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? radarUsers = null,Object? friends = null,Object? pendingRequests = null,}) {
  return _then(SocialRadarLoadSuccess(
radarUsers: null == radarUsers ? _self._radarUsers : radarUsers // ignore: cast_nullable_to_non_nullable
as List<RadarEntry>,friends: null == friends ? _self._friends : friends // ignore: cast_nullable_to_non_nullable
as List<FriendshipModel>,pendingRequests: null == pendingRequests ? _self._pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as List<FriendshipModel>,
  ));
}


}

/// @nodoc


class RadarUsersLoadSuccess implements SocialRadarState {
  const RadarUsersLoadSuccess(final  List<RadarEntry> radarUsers): _radarUsers = radarUsers;
  

 final  List<RadarEntry> _radarUsers;
 List<RadarEntry> get radarUsers {
  if (_radarUsers is EqualUnmodifiableListView) return _radarUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_radarUsers);
}


/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RadarUsersLoadSuccessCopyWith<RadarUsersLoadSuccess> get copyWith => _$RadarUsersLoadSuccessCopyWithImpl<RadarUsersLoadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RadarUsersLoadSuccess&&const DeepCollectionEquality().equals(other._radarUsers, _radarUsers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_radarUsers));

@override
String toString() {
  return 'SocialRadarState.radarUsersLoadSuccess(radarUsers: $radarUsers)';
}


}

/// @nodoc
abstract mixin class $RadarUsersLoadSuccessCopyWith<$Res> implements $SocialRadarStateCopyWith<$Res> {
  factory $RadarUsersLoadSuccessCopyWith(RadarUsersLoadSuccess value, $Res Function(RadarUsersLoadSuccess) _then) = _$RadarUsersLoadSuccessCopyWithImpl;
@useResult
$Res call({
 List<RadarEntry> radarUsers
});




}
/// @nodoc
class _$RadarUsersLoadSuccessCopyWithImpl<$Res>
    implements $RadarUsersLoadSuccessCopyWith<$Res> {
  _$RadarUsersLoadSuccessCopyWithImpl(this._self, this._then);

  final RadarUsersLoadSuccess _self;
  final $Res Function(RadarUsersLoadSuccess) _then;

/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? radarUsers = null,}) {
  return _then(RadarUsersLoadSuccess(
null == radarUsers ? _self._radarUsers : radarUsers // ignore: cast_nullable_to_non_nullable
as List<RadarEntry>,
  ));
}


}

/// @nodoc


class PendingRequestsLoadSuccess implements SocialRadarState {
  const PendingRequestsLoadSuccess(final  List<FriendshipModel> pendingRequests): _pendingRequests = pendingRequests;
  

 final  List<FriendshipModel> _pendingRequests;
 List<FriendshipModel> get pendingRequests {
  if (_pendingRequests is EqualUnmodifiableListView) return _pendingRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingRequests);
}


/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingRequestsLoadSuccessCopyWith<PendingRequestsLoadSuccess> get copyWith => _$PendingRequestsLoadSuccessCopyWithImpl<PendingRequestsLoadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingRequestsLoadSuccess&&const DeepCollectionEquality().equals(other._pendingRequests, _pendingRequests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pendingRequests));

@override
String toString() {
  return 'SocialRadarState.pendingRequestsLoadSuccess(pendingRequests: $pendingRequests)';
}


}

/// @nodoc
abstract mixin class $PendingRequestsLoadSuccessCopyWith<$Res> implements $SocialRadarStateCopyWith<$Res> {
  factory $PendingRequestsLoadSuccessCopyWith(PendingRequestsLoadSuccess value, $Res Function(PendingRequestsLoadSuccess) _then) = _$PendingRequestsLoadSuccessCopyWithImpl;
@useResult
$Res call({
 List<FriendshipModel> pendingRequests
});




}
/// @nodoc
class _$PendingRequestsLoadSuccessCopyWithImpl<$Res>
    implements $PendingRequestsLoadSuccessCopyWith<$Res> {
  _$PendingRequestsLoadSuccessCopyWithImpl(this._self, this._then);

  final PendingRequestsLoadSuccess _self;
  final $Res Function(PendingRequestsLoadSuccess) _then;

/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pendingRequests = null,}) {
  return _then(PendingRequestsLoadSuccess(
null == pendingRequests ? _self._pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as List<FriendshipModel>,
  ));
}


}

/// @nodoc


class FriendsLoadSuccess implements SocialRadarState {
  const FriendsLoadSuccess(final  List<FriendshipModel> friends): _friends = friends;
  

 final  List<FriendshipModel> _friends;
 List<FriendshipModel> get friends {
  if (_friends is EqualUnmodifiableListView) return _friends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_friends);
}


/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendsLoadSuccessCopyWith<FriendsLoadSuccess> get copyWith => _$FriendsLoadSuccessCopyWithImpl<FriendsLoadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendsLoadSuccess&&const DeepCollectionEquality().equals(other._friends, _friends));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_friends));

@override
String toString() {
  return 'SocialRadarState.friendsLoadSuccess(friends: $friends)';
}


}

/// @nodoc
abstract mixin class $FriendsLoadSuccessCopyWith<$Res> implements $SocialRadarStateCopyWith<$Res> {
  factory $FriendsLoadSuccessCopyWith(FriendsLoadSuccess value, $Res Function(FriendsLoadSuccess) _then) = _$FriendsLoadSuccessCopyWithImpl;
@useResult
$Res call({
 List<FriendshipModel> friends
});




}
/// @nodoc
class _$FriendsLoadSuccessCopyWithImpl<$Res>
    implements $FriendsLoadSuccessCopyWith<$Res> {
  _$FriendsLoadSuccessCopyWithImpl(this._self, this._then);

  final FriendsLoadSuccess _self;
  final $Res Function(FriendsLoadSuccess) _then;

/// Create a copy of SocialRadarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friends = null,}) {
  return _then(FriendsLoadSuccess(
null == friends ? _self._friends : friends // ignore: cast_nullable_to_non_nullable
as List<FriendshipModel>,
  ));
}


}

/// @nodoc


class SendFriendRequestSuccess implements SocialRadarState {
  const SendFriendRequestSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendFriendRequestSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarState.sendFriendRequestSuccess()';
}


}




/// @nodoc


class RespondToFriendRequestSuccess implements SocialRadarState {
  const RespondToFriendRequestSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RespondToFriendRequestSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarState.respondToFriendRequestSuccess()';
}


}




/// @nodoc


class RemoveFriendSuccess implements SocialRadarState {
  const RemoveFriendSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveFriendSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarState.removeFriendSuccess()';
}


}




// dart format on
