// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_radar_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SocialRadarEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialRadarEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarEvent()';
}


}

/// @nodoc
class $SocialRadarEventCopyWith<$Res>  {
$SocialRadarEventCopyWith(SocialRadarEvent _, $Res Function(SocialRadarEvent) __);
}


/// Adds pattern-matching-related methods to [SocialRadarEvent].
extension SocialRadarEventPatterns on SocialRadarEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadSocialRadar value)?  loadSocialRadar,TResult Function( GetRadarUsers value)?  getRadarUsers,TResult Function( ListPendingRequests value)?  listPendingRequests,TResult Function( ListFriends value)?  listFriends,TResult Function( SendFriendRequest value)?  sendFriendRequest,TResult Function( RespondToFriendRequest value)?  respondToFriendRequest,TResult Function( RemoveFriend value)?  removeFriend,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadSocialRadar() when loadSocialRadar != null:
return loadSocialRadar(_that);case GetRadarUsers() when getRadarUsers != null:
return getRadarUsers(_that);case ListPendingRequests() when listPendingRequests != null:
return listPendingRequests(_that);case ListFriends() when listFriends != null:
return listFriends(_that);case SendFriendRequest() when sendFriendRequest != null:
return sendFriendRequest(_that);case RespondToFriendRequest() when respondToFriendRequest != null:
return respondToFriendRequest(_that);case RemoveFriend() when removeFriend != null:
return removeFriend(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadSocialRadar value)  loadSocialRadar,required TResult Function( GetRadarUsers value)  getRadarUsers,required TResult Function( ListPendingRequests value)  listPendingRequests,required TResult Function( ListFriends value)  listFriends,required TResult Function( SendFriendRequest value)  sendFriendRequest,required TResult Function( RespondToFriendRequest value)  respondToFriendRequest,required TResult Function( RemoveFriend value)  removeFriend,}){
final _that = this;
switch (_that) {
case LoadSocialRadar():
return loadSocialRadar(_that);case GetRadarUsers():
return getRadarUsers(_that);case ListPendingRequests():
return listPendingRequests(_that);case ListFriends():
return listFriends(_that);case SendFriendRequest():
return sendFriendRequest(_that);case RespondToFriendRequest():
return respondToFriendRequest(_that);case RemoveFriend():
return removeFriend(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadSocialRadar value)?  loadSocialRadar,TResult? Function( GetRadarUsers value)?  getRadarUsers,TResult? Function( ListPendingRequests value)?  listPendingRequests,TResult? Function( ListFriends value)?  listFriends,TResult? Function( SendFriendRequest value)?  sendFriendRequest,TResult? Function( RespondToFriendRequest value)?  respondToFriendRequest,TResult? Function( RemoveFriend value)?  removeFriend,}){
final _that = this;
switch (_that) {
case LoadSocialRadar() when loadSocialRadar != null:
return loadSocialRadar(_that);case GetRadarUsers() when getRadarUsers != null:
return getRadarUsers(_that);case ListPendingRequests() when listPendingRequests != null:
return listPendingRequests(_that);case ListFriends() when listFriends != null:
return listFriends(_that);case SendFriendRequest() when sendFriendRequest != null:
return sendFriendRequest(_that);case RespondToFriendRequest() when respondToFriendRequest != null:
return respondToFriendRequest(_that);case RemoveFriend() when removeFriend != null:
return removeFriend(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadSocialRadar,TResult Function()?  getRadarUsers,TResult Function()?  listPendingRequests,TResult Function()?  listFriends,TResult Function( String targetUserId)?  sendFriendRequest,TResult Function( String friendshipId,  bool accept)?  respondToFriendRequest,TResult Function( String friendId)?  removeFriend,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadSocialRadar() when loadSocialRadar != null:
return loadSocialRadar();case GetRadarUsers() when getRadarUsers != null:
return getRadarUsers();case ListPendingRequests() when listPendingRequests != null:
return listPendingRequests();case ListFriends() when listFriends != null:
return listFriends();case SendFriendRequest() when sendFriendRequest != null:
return sendFriendRequest(_that.targetUserId);case RespondToFriendRequest() when respondToFriendRequest != null:
return respondToFriendRequest(_that.friendshipId,_that.accept);case RemoveFriend() when removeFriend != null:
return removeFriend(_that.friendId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadSocialRadar,required TResult Function()  getRadarUsers,required TResult Function()  listPendingRequests,required TResult Function()  listFriends,required TResult Function( String targetUserId)  sendFriendRequest,required TResult Function( String friendshipId,  bool accept)  respondToFriendRequest,required TResult Function( String friendId)  removeFriend,}) {final _that = this;
switch (_that) {
case LoadSocialRadar():
return loadSocialRadar();case GetRadarUsers():
return getRadarUsers();case ListPendingRequests():
return listPendingRequests();case ListFriends():
return listFriends();case SendFriendRequest():
return sendFriendRequest(_that.targetUserId);case RespondToFriendRequest():
return respondToFriendRequest(_that.friendshipId,_that.accept);case RemoveFriend():
return removeFriend(_that.friendId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadSocialRadar,TResult? Function()?  getRadarUsers,TResult? Function()?  listPendingRequests,TResult? Function()?  listFriends,TResult? Function( String targetUserId)?  sendFriendRequest,TResult? Function( String friendshipId,  bool accept)?  respondToFriendRequest,TResult? Function( String friendId)?  removeFriend,}) {final _that = this;
switch (_that) {
case LoadSocialRadar() when loadSocialRadar != null:
return loadSocialRadar();case GetRadarUsers() when getRadarUsers != null:
return getRadarUsers();case ListPendingRequests() when listPendingRequests != null:
return listPendingRequests();case ListFriends() when listFriends != null:
return listFriends();case SendFriendRequest() when sendFriendRequest != null:
return sendFriendRequest(_that.targetUserId);case RespondToFriendRequest() when respondToFriendRequest != null:
return respondToFriendRequest(_that.friendshipId,_that.accept);case RemoveFriend() when removeFriend != null:
return removeFriend(_that.friendId);case _:
  return null;

}
}

}

/// @nodoc


class LoadSocialRadar implements SocialRadarEvent {
  const LoadSocialRadar();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadSocialRadar);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarEvent.loadSocialRadar()';
}


}




/// @nodoc


class GetRadarUsers implements SocialRadarEvent {
  const GetRadarUsers();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetRadarUsers);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarEvent.getRadarUsers()';
}


}




/// @nodoc


class ListPendingRequests implements SocialRadarEvent {
  const ListPendingRequests();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListPendingRequests);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarEvent.listPendingRequests()';
}


}




/// @nodoc


class ListFriends implements SocialRadarEvent {
  const ListFriends();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListFriends);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialRadarEvent.listFriends()';
}


}




/// @nodoc


class SendFriendRequest implements SocialRadarEvent {
  const SendFriendRequest(this.targetUserId);
  

 final  String targetUserId;

/// Create a copy of SocialRadarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendFriendRequestCopyWith<SendFriendRequest> get copyWith => _$SendFriendRequestCopyWithImpl<SendFriendRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendFriendRequest&&(identical(other.targetUserId, targetUserId) || other.targetUserId == targetUserId));
}


@override
int get hashCode => Object.hash(runtimeType,targetUserId);

@override
String toString() {
  return 'SocialRadarEvent.sendFriendRequest(targetUserId: $targetUserId)';
}


}

/// @nodoc
abstract mixin class $SendFriendRequestCopyWith<$Res> implements $SocialRadarEventCopyWith<$Res> {
  factory $SendFriendRequestCopyWith(SendFriendRequest value, $Res Function(SendFriendRequest) _then) = _$SendFriendRequestCopyWithImpl;
@useResult
$Res call({
 String targetUserId
});




}
/// @nodoc
class _$SendFriendRequestCopyWithImpl<$Res>
    implements $SendFriendRequestCopyWith<$Res> {
  _$SendFriendRequestCopyWithImpl(this._self, this._then);

  final SendFriendRequest _self;
  final $Res Function(SendFriendRequest) _then;

/// Create a copy of SocialRadarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetUserId = null,}) {
  return _then(SendFriendRequest(
null == targetUserId ? _self.targetUserId : targetUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RespondToFriendRequest implements SocialRadarEvent {
  const RespondToFriendRequest({required this.friendshipId, required this.accept});
  

 final  String friendshipId;
 final  bool accept;

/// Create a copy of SocialRadarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RespondToFriendRequestCopyWith<RespondToFriendRequest> get copyWith => _$RespondToFriendRequestCopyWithImpl<RespondToFriendRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RespondToFriendRequest&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.accept, accept) || other.accept == accept));
}


@override
int get hashCode => Object.hash(runtimeType,friendshipId,accept);

@override
String toString() {
  return 'SocialRadarEvent.respondToFriendRequest(friendshipId: $friendshipId, accept: $accept)';
}


}

/// @nodoc
abstract mixin class $RespondToFriendRequestCopyWith<$Res> implements $SocialRadarEventCopyWith<$Res> {
  factory $RespondToFriendRequestCopyWith(RespondToFriendRequest value, $Res Function(RespondToFriendRequest) _then) = _$RespondToFriendRequestCopyWithImpl;
@useResult
$Res call({
 String friendshipId, bool accept
});




}
/// @nodoc
class _$RespondToFriendRequestCopyWithImpl<$Res>
    implements $RespondToFriendRequestCopyWith<$Res> {
  _$RespondToFriendRequestCopyWithImpl(this._self, this._then);

  final RespondToFriendRequest _self;
  final $Res Function(RespondToFriendRequest) _then;

/// Create a copy of SocialRadarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friendshipId = null,Object? accept = null,}) {
  return _then(RespondToFriendRequest(
friendshipId: null == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String,accept: null == accept ? _self.accept : accept // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class RemoveFriend implements SocialRadarEvent {
  const RemoveFriend(this.friendId);
  

 final  String friendId;

/// Create a copy of SocialRadarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveFriendCopyWith<RemoveFriend> get copyWith => _$RemoveFriendCopyWithImpl<RemoveFriend>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveFriend&&(identical(other.friendId, friendId) || other.friendId == friendId));
}


@override
int get hashCode => Object.hash(runtimeType,friendId);

@override
String toString() {
  return 'SocialRadarEvent.removeFriend(friendId: $friendId)';
}


}

/// @nodoc
abstract mixin class $RemoveFriendCopyWith<$Res> implements $SocialRadarEventCopyWith<$Res> {
  factory $RemoveFriendCopyWith(RemoveFriend value, $Res Function(RemoveFriend) _then) = _$RemoveFriendCopyWithImpl;
@useResult
$Res call({
 String friendId
});




}
/// @nodoc
class _$RemoveFriendCopyWithImpl<$Res>
    implements $RemoveFriendCopyWith<$Res> {
  _$RemoveFriendCopyWithImpl(this._self, this._then);

  final RemoveFriend _self;
  final $Res Function(RemoveFriend) _then;

/// Create a copy of SocialRadarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friendId = null,}) {
  return _then(RemoveFriend(
null == friendId ? _self.friendId : friendId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
