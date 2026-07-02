// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {

 UIStatus get status;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'LoginState(status: $status)';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 UIStatus status
});


$UIStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,
  ));
}
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get status {
  
  return $UIStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginState value)  $default,){
final _that = this;
switch (_that) {
case _LoginState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UIStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UIStatus status)  $default,) {final _that = this;
switch (_that) {
case _LoginState():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UIStatus status)?  $default,) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _LoginState implements LoginState {
  const _LoginState({this.status = const UIStatus.initial()});
  

@override@JsonKey() final  UIStatus status;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'LoginState(status: $status)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 UIStatus status
});


@override $UIStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_LoginState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,
  ));
}

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get status {
  
  return $UIStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

/// @nodoc
mixin _$LoginEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent()';
}


}

/// @nodoc
class $LoginEventCopyWith<$Res>  {
$LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}


/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginSubmittedEvent value)?  loginSubmitted,TResult Function( RegisterSubmittedEvent value)?  registerSubmitted,TResult Function( ForgotPasswordSubmittedEvent value)?  forgotPasswordSubmitted,TResult Function( ResetPasswordSubmittedEvent value)?  resetPasswordSubmitted,TResult Function( LogoutRequestedEvent value)?  logoutRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginSubmittedEvent() when loginSubmitted != null:
return loginSubmitted(_that);case RegisterSubmittedEvent() when registerSubmitted != null:
return registerSubmitted(_that);case ForgotPasswordSubmittedEvent() when forgotPasswordSubmitted != null:
return forgotPasswordSubmitted(_that);case ResetPasswordSubmittedEvent() when resetPasswordSubmitted != null:
return resetPasswordSubmitted(_that);case LogoutRequestedEvent() when logoutRequested != null:
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginSubmittedEvent value)  loginSubmitted,required TResult Function( RegisterSubmittedEvent value)  registerSubmitted,required TResult Function( ForgotPasswordSubmittedEvent value)  forgotPasswordSubmitted,required TResult Function( ResetPasswordSubmittedEvent value)  resetPasswordSubmitted,required TResult Function( LogoutRequestedEvent value)  logoutRequested,}){
final _that = this;
switch (_that) {
case LoginSubmittedEvent():
return loginSubmitted(_that);case RegisterSubmittedEvent():
return registerSubmitted(_that);case ForgotPasswordSubmittedEvent():
return forgotPasswordSubmitted(_that);case ResetPasswordSubmittedEvent():
return resetPasswordSubmitted(_that);case LogoutRequestedEvent():
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginSubmittedEvent value)?  loginSubmitted,TResult? Function( RegisterSubmittedEvent value)?  registerSubmitted,TResult? Function( ForgotPasswordSubmittedEvent value)?  forgotPasswordSubmitted,TResult? Function( ResetPasswordSubmittedEvent value)?  resetPasswordSubmitted,TResult? Function( LogoutRequestedEvent value)?  logoutRequested,}){
final _that = this;
switch (_that) {
case LoginSubmittedEvent() when loginSubmitted != null:
return loginSubmitted(_that);case RegisterSubmittedEvent() when registerSubmitted != null:
return registerSubmitted(_that);case ForgotPasswordSubmittedEvent() when forgotPasswordSubmitted != null:
return forgotPasswordSubmitted(_that);case ResetPasswordSubmittedEvent() when resetPasswordSubmitted != null:
return resetPasswordSubmitted(_that);case LogoutRequestedEvent() when logoutRequested != null:
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String password)?  loginSubmitted,TResult Function( String email,  String password,  String firstName,  String lastName)?  registerSubmitted,TResult Function( String email)?  forgotPasswordSubmitted,TResult Function( String token,  String newPassword)?  resetPasswordSubmitted,TResult Function()?  logoutRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginSubmittedEvent() when loginSubmitted != null:
return loginSubmitted(_that.email,_that.password);case RegisterSubmittedEvent() when registerSubmitted != null:
return registerSubmitted(_that.email,_that.password,_that.firstName,_that.lastName);case ForgotPasswordSubmittedEvent() when forgotPasswordSubmitted != null:
return forgotPasswordSubmitted(_that.email);case ResetPasswordSubmittedEvent() when resetPasswordSubmitted != null:
return resetPasswordSubmitted(_that.token,_that.newPassword);case LogoutRequestedEvent() when logoutRequested != null:
return logoutRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String password)  loginSubmitted,required TResult Function( String email,  String password,  String firstName,  String lastName)  registerSubmitted,required TResult Function( String email)  forgotPasswordSubmitted,required TResult Function( String token,  String newPassword)  resetPasswordSubmitted,required TResult Function()  logoutRequested,}) {final _that = this;
switch (_that) {
case LoginSubmittedEvent():
return loginSubmitted(_that.email,_that.password);case RegisterSubmittedEvent():
return registerSubmitted(_that.email,_that.password,_that.firstName,_that.lastName);case ForgotPasswordSubmittedEvent():
return forgotPasswordSubmitted(_that.email);case ResetPasswordSubmittedEvent():
return resetPasswordSubmitted(_that.token,_that.newPassword);case LogoutRequestedEvent():
return logoutRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String password)?  loginSubmitted,TResult? Function( String email,  String password,  String firstName,  String lastName)?  registerSubmitted,TResult? Function( String email)?  forgotPasswordSubmitted,TResult? Function( String token,  String newPassword)?  resetPasswordSubmitted,TResult? Function()?  logoutRequested,}) {final _that = this;
switch (_that) {
case LoginSubmittedEvent() when loginSubmitted != null:
return loginSubmitted(_that.email,_that.password);case RegisterSubmittedEvent() when registerSubmitted != null:
return registerSubmitted(_that.email,_that.password,_that.firstName,_that.lastName);case ForgotPasswordSubmittedEvent() when forgotPasswordSubmitted != null:
return forgotPasswordSubmitted(_that.email);case ResetPasswordSubmittedEvent() when resetPasswordSubmitted != null:
return resetPasswordSubmitted(_that.token,_that.newPassword);case LogoutRequestedEvent() when logoutRequested != null:
return logoutRequested();case _:
  return null;

}
}

}

/// @nodoc


class LoginSubmittedEvent implements LoginEvent {
  const LoginSubmittedEvent(this.email, this.password);
  

 final  String email;
 final  String password;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginSubmittedEventCopyWith<LoginSubmittedEvent> get copyWith => _$LoginSubmittedEventCopyWithImpl<LoginSubmittedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSubmittedEvent&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'LoginEvent.loginSubmitted(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginSubmittedEventCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $LoginSubmittedEventCopyWith(LoginSubmittedEvent value, $Res Function(LoginSubmittedEvent) _then) = _$LoginSubmittedEventCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$LoginSubmittedEventCopyWithImpl<$Res>
    implements $LoginSubmittedEventCopyWith<$Res> {
  _$LoginSubmittedEventCopyWithImpl(this._self, this._then);

  final LoginSubmittedEvent _self;
  final $Res Function(LoginSubmittedEvent) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(LoginSubmittedEvent(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterSubmittedEvent implements LoginEvent {
  const RegisterSubmittedEvent({required this.email, required this.password, required this.firstName, required this.lastName});
  

 final  String email;
 final  String password;
 final  String firstName;
 final  String lastName;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterSubmittedEventCopyWith<RegisterSubmittedEvent> get copyWith => _$RegisterSubmittedEventCopyWithImpl<RegisterSubmittedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterSubmittedEvent&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,firstName,lastName);

@override
String toString() {
  return 'LoginEvent.registerSubmitted(email: $email, password: $password, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class $RegisterSubmittedEventCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $RegisterSubmittedEventCopyWith(RegisterSubmittedEvent value, $Res Function(RegisterSubmittedEvent) _then) = _$RegisterSubmittedEventCopyWithImpl;
@useResult
$Res call({
 String email, String password, String firstName, String lastName
});




}
/// @nodoc
class _$RegisterSubmittedEventCopyWithImpl<$Res>
    implements $RegisterSubmittedEventCopyWith<$Res> {
  _$RegisterSubmittedEventCopyWithImpl(this._self, this._then);

  final RegisterSubmittedEvent _self;
  final $Res Function(RegisterSubmittedEvent) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(RegisterSubmittedEvent(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForgotPasswordSubmittedEvent implements LoginEvent {
  const ForgotPasswordSubmittedEvent(this.email);
  

 final  String email;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordSubmittedEventCopyWith<ForgotPasswordSubmittedEvent> get copyWith => _$ForgotPasswordSubmittedEventCopyWithImpl<ForgotPasswordSubmittedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordSubmittedEvent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'LoginEvent.forgotPasswordSubmitted(email: $email)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordSubmittedEventCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $ForgotPasswordSubmittedEventCopyWith(ForgotPasswordSubmittedEvent value, $Res Function(ForgotPasswordSubmittedEvent) _then) = _$ForgotPasswordSubmittedEventCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ForgotPasswordSubmittedEventCopyWithImpl<$Res>
    implements $ForgotPasswordSubmittedEventCopyWith<$Res> {
  _$ForgotPasswordSubmittedEventCopyWithImpl(this._self, this._then);

  final ForgotPasswordSubmittedEvent _self;
  final $Res Function(ForgotPasswordSubmittedEvent) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(ForgotPasswordSubmittedEvent(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ResetPasswordSubmittedEvent implements LoginEvent {
  const ResetPasswordSubmittedEvent(this.token, this.newPassword);
  

 final  String token;
 final  String newPassword;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordSubmittedEventCopyWith<ResetPasswordSubmittedEvent> get copyWith => _$ResetPasswordSubmittedEventCopyWithImpl<ResetPasswordSubmittedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordSubmittedEvent&&(identical(other.token, token) || other.token == token)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}


@override
int get hashCode => Object.hash(runtimeType,token,newPassword);

@override
String toString() {
  return 'LoginEvent.resetPasswordSubmitted(token: $token, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordSubmittedEventCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $ResetPasswordSubmittedEventCopyWith(ResetPasswordSubmittedEvent value, $Res Function(ResetPasswordSubmittedEvent) _then) = _$ResetPasswordSubmittedEventCopyWithImpl;
@useResult
$Res call({
 String token, String newPassword
});




}
/// @nodoc
class _$ResetPasswordSubmittedEventCopyWithImpl<$Res>
    implements $ResetPasswordSubmittedEventCopyWith<$Res> {
  _$ResetPasswordSubmittedEventCopyWithImpl(this._self, this._then);

  final ResetPasswordSubmittedEvent _self;
  final $Res Function(ResetPasswordSubmittedEvent) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,Object? newPassword = null,}) {
  return _then(ResetPasswordSubmittedEvent(
null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LogoutRequestedEvent implements LoginEvent {
  const LogoutRequestedEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutRequestedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.logoutRequested()';
}


}




// dart format on
