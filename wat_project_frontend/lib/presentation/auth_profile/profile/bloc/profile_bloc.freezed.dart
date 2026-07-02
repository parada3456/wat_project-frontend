// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GetProfileEvent value)?  getProfile,TResult Function( UpdateProfileSubmittedEvent value)?  updateProfile,TResult Function( UpdateLocationSubmittedEvent value)?  updateLocation,TResult Function( DeleteAccountSubmittedEvent value)?  deleteAccount,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GetProfileEvent() when getProfile != null:
return getProfile(_that);case UpdateProfileSubmittedEvent() when updateProfile != null:
return updateProfile(_that);case UpdateLocationSubmittedEvent() when updateLocation != null:
return updateLocation(_that);case DeleteAccountSubmittedEvent() when deleteAccount != null:
return deleteAccount(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GetProfileEvent value)  getProfile,required TResult Function( UpdateProfileSubmittedEvent value)  updateProfile,required TResult Function( UpdateLocationSubmittedEvent value)  updateLocation,required TResult Function( DeleteAccountSubmittedEvent value)  deleteAccount,}){
final _that = this;
switch (_that) {
case GetProfileEvent():
return getProfile(_that);case UpdateProfileSubmittedEvent():
return updateProfile(_that);case UpdateLocationSubmittedEvent():
return updateLocation(_that);case DeleteAccountSubmittedEvent():
return deleteAccount(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GetProfileEvent value)?  getProfile,TResult? Function( UpdateProfileSubmittedEvent value)?  updateProfile,TResult? Function( UpdateLocationSubmittedEvent value)?  updateLocation,TResult? Function( DeleteAccountSubmittedEvent value)?  deleteAccount,}){
final _that = this;
switch (_that) {
case GetProfileEvent() when getProfile != null:
return getProfile(_that);case UpdateProfileSubmittedEvent() when updateProfile != null:
return updateProfile(_that);case UpdateLocationSubmittedEvent() when updateLocation != null:
return updateLocation(_that);case DeleteAccountSubmittedEvent() when deleteAccount != null:
return deleteAccount(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  getProfile,TResult Function( String firstName,  String lastName,  String bio,  String avatarUrl)?  updateProfile,TResult Function( double latitude,  double longitude)?  updateLocation,TResult Function( String password)?  deleteAccount,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GetProfileEvent() when getProfile != null:
return getProfile();case UpdateProfileSubmittedEvent() when updateProfile != null:
return updateProfile(_that.firstName,_that.lastName,_that.bio,_that.avatarUrl);case UpdateLocationSubmittedEvent() when updateLocation != null:
return updateLocation(_that.latitude,_that.longitude);case DeleteAccountSubmittedEvent() when deleteAccount != null:
return deleteAccount(_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  getProfile,required TResult Function( String firstName,  String lastName,  String bio,  String avatarUrl)  updateProfile,required TResult Function( double latitude,  double longitude)  updateLocation,required TResult Function( String password)  deleteAccount,}) {final _that = this;
switch (_that) {
case GetProfileEvent():
return getProfile();case UpdateProfileSubmittedEvent():
return updateProfile(_that.firstName,_that.lastName,_that.bio,_that.avatarUrl);case UpdateLocationSubmittedEvent():
return updateLocation(_that.latitude,_that.longitude);case DeleteAccountSubmittedEvent():
return deleteAccount(_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  getProfile,TResult? Function( String firstName,  String lastName,  String bio,  String avatarUrl)?  updateProfile,TResult? Function( double latitude,  double longitude)?  updateLocation,TResult? Function( String password)?  deleteAccount,}) {final _that = this;
switch (_that) {
case GetProfileEvent() when getProfile != null:
return getProfile();case UpdateProfileSubmittedEvent() when updateProfile != null:
return updateProfile(_that.firstName,_that.lastName,_that.bio,_that.avatarUrl);case UpdateLocationSubmittedEvent() when updateLocation != null:
return updateLocation(_that.latitude,_that.longitude);case DeleteAccountSubmittedEvent() when deleteAccount != null:
return deleteAccount(_that.password);case _:
  return null;

}
}

}

/// @nodoc


class GetProfileEvent implements ProfileEvent {
  const GetProfileEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.getProfile()';
}


}




/// @nodoc


class UpdateProfileSubmittedEvent implements ProfileEvent {
  const UpdateProfileSubmittedEvent({required this.firstName, required this.lastName, required this.bio, required this.avatarUrl});
  

 final  String firstName;
 final  String lastName;
 final  String bio;
 final  String avatarUrl;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProfileSubmittedEventCopyWith<UpdateProfileSubmittedEvent> get copyWith => _$UpdateProfileSubmittedEventCopyWithImpl<UpdateProfileSubmittedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProfileSubmittedEvent&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,bio,avatarUrl);

@override
String toString() {
  return 'ProfileEvent.updateProfile(firstName: $firstName, lastName: $lastName, bio: $bio, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $UpdateProfileSubmittedEventCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $UpdateProfileSubmittedEventCopyWith(UpdateProfileSubmittedEvent value, $Res Function(UpdateProfileSubmittedEvent) _then) = _$UpdateProfileSubmittedEventCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String bio, String avatarUrl
});




}
/// @nodoc
class _$UpdateProfileSubmittedEventCopyWithImpl<$Res>
    implements $UpdateProfileSubmittedEventCopyWith<$Res> {
  _$UpdateProfileSubmittedEventCopyWithImpl(this._self, this._then);

  final UpdateProfileSubmittedEvent _self;
  final $Res Function(UpdateProfileSubmittedEvent) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? bio = null,Object? avatarUrl = null,}) {
  return _then(UpdateProfileSubmittedEvent(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpdateLocationSubmittedEvent implements ProfileEvent {
  const UpdateLocationSubmittedEvent({required this.latitude, required this.longitude});
  

 final  double latitude;
 final  double longitude;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateLocationSubmittedEventCopyWith<UpdateLocationSubmittedEvent> get copyWith => _$UpdateLocationSubmittedEventCopyWithImpl<UpdateLocationSubmittedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateLocationSubmittedEvent&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'ProfileEvent.updateLocation(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $UpdateLocationSubmittedEventCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $UpdateLocationSubmittedEventCopyWith(UpdateLocationSubmittedEvent value, $Res Function(UpdateLocationSubmittedEvent) _then) = _$UpdateLocationSubmittedEventCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$UpdateLocationSubmittedEventCopyWithImpl<$Res>
    implements $UpdateLocationSubmittedEventCopyWith<$Res> {
  _$UpdateLocationSubmittedEventCopyWithImpl(this._self, this._then);

  final UpdateLocationSubmittedEvent _self;
  final $Res Function(UpdateLocationSubmittedEvent) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(UpdateLocationSubmittedEvent(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class DeleteAccountSubmittedEvent implements ProfileEvent {
  const DeleteAccountSubmittedEvent(this.password);
  

 final  String password;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteAccountSubmittedEventCopyWith<DeleteAccountSubmittedEvent> get copyWith => _$DeleteAccountSubmittedEventCopyWithImpl<DeleteAccountSubmittedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteAccountSubmittedEvent&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'ProfileEvent.deleteAccount(password: $password)';
}


}

/// @nodoc
abstract mixin class $DeleteAccountSubmittedEventCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $DeleteAccountSubmittedEventCopyWith(DeleteAccountSubmittedEvent value, $Res Function(DeleteAccountSubmittedEvent) _then) = _$DeleteAccountSubmittedEventCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$DeleteAccountSubmittedEventCopyWithImpl<$Res>
    implements $DeleteAccountSubmittedEventCopyWith<$Res> {
  _$DeleteAccountSubmittedEventCopyWithImpl(this._self, this._then);

  final DeleteAccountSubmittedEvent _self;
  final $Res Function(DeleteAccountSubmittedEvent) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(DeleteAccountSubmittedEvent(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ProfileState {

 UIStatus get status; UserProfileModel? get profile; List<Badge> get badges; List<CreditRecord> get creditHistory;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other.badges, badges)&&const DeepCollectionEquality().equals(other.creditHistory, creditHistory));
}


@override
int get hashCode => Object.hash(runtimeType,status,profile,const DeepCollectionEquality().hash(badges),const DeepCollectionEquality().hash(creditHistory));

@override
String toString() {
  return 'ProfileState(status: $status, profile: $profile, badges: $badges, creditHistory: $creditHistory)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 UIStatus status, UserProfileModel? profile, List<Badge> badges, List<CreditRecord> creditHistory
});


$UIStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? profile = freezed,Object? badges = null,Object? creditHistory = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfileModel?,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<Badge>,creditHistory: null == creditHistory ? _self.creditHistory : creditHistory // ignore: cast_nullable_to_non_nullable
as List<CreditRecord>,
  ));
}
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get status {
  
  return $UIStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UIStatus status,  UserProfileModel? profile,  List<Badge> badges,  List<CreditRecord> creditHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.status,_that.profile,_that.badges,_that.creditHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UIStatus status,  UserProfileModel? profile,  List<Badge> badges,  List<CreditRecord> creditHistory)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.status,_that.profile,_that.badges,_that.creditHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UIStatus status,  UserProfileModel? profile,  List<Badge> badges,  List<CreditRecord> creditHistory)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.status,_that.profile,_that.badges,_that.creditHistory);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState implements ProfileState {
  const _ProfileState({this.status = const UIStatus.initial(), this.profile, final  List<Badge> badges = const [], final  List<CreditRecord> creditHistory = const []}): _badges = badges,_creditHistory = creditHistory;
  

@override@JsonKey() final  UIStatus status;
@override final  UserProfileModel? profile;
 final  List<Badge> _badges;
@override@JsonKey() List<Badge> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

 final  List<CreditRecord> _creditHistory;
@override@JsonKey() List<CreditRecord> get creditHistory {
  if (_creditHistory is EqualUnmodifiableListView) return _creditHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_creditHistory);
}


/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other._badges, _badges)&&const DeepCollectionEquality().equals(other._creditHistory, _creditHistory));
}


@override
int get hashCode => Object.hash(runtimeType,status,profile,const DeepCollectionEquality().hash(_badges),const DeepCollectionEquality().hash(_creditHistory));

@override
String toString() {
  return 'ProfileState(status: $status, profile: $profile, badges: $badges, creditHistory: $creditHistory)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 UIStatus status, UserProfileModel? profile, List<Badge> badges, List<CreditRecord> creditHistory
});


@override $UIStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? profile = freezed,Object? badges = null,Object? creditHistory = null,}) {
  return _then(_ProfileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfileModel?,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<Badge>,creditHistory: null == creditHistory ? _self._creditHistory : creditHistory // ignore: cast_nullable_to_non_nullable
as List<CreditRecord>,
  ));
}

/// Create a copy of ProfileState
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
