// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsEvent()';
}


}

/// @nodoc
class $NotificationsEventCopyWith<$Res>  {
$NotificationsEventCopyWith(NotificationsEvent _, $Res Function(NotificationsEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationsEvent].
extension NotificationsEventPatterns on NotificationsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadNotificationsEvent value)?  loadNotifications,TResult Function( MarkNotificationReadEvent value)?  markNotificationRead,TResult Function( MarkAllNotificationsReadEvent value)?  markAllNotificationsRead,TResult Function( DeleteNotificationEvent value)?  deleteNotification,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications(_that);case MarkNotificationReadEvent() when markNotificationRead != null:
return markNotificationRead(_that);case MarkAllNotificationsReadEvent() when markAllNotificationsRead != null:
return markAllNotificationsRead(_that);case DeleteNotificationEvent() when deleteNotification != null:
return deleteNotification(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadNotificationsEvent value)  loadNotifications,required TResult Function( MarkNotificationReadEvent value)  markNotificationRead,required TResult Function( MarkAllNotificationsReadEvent value)  markAllNotificationsRead,required TResult Function( DeleteNotificationEvent value)  deleteNotification,}){
final _that = this;
switch (_that) {
case LoadNotificationsEvent():
return loadNotifications(_that);case MarkNotificationReadEvent():
return markNotificationRead(_that);case MarkAllNotificationsReadEvent():
return markAllNotificationsRead(_that);case DeleteNotificationEvent():
return deleteNotification(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadNotificationsEvent value)?  loadNotifications,TResult? Function( MarkNotificationReadEvent value)?  markNotificationRead,TResult? Function( MarkAllNotificationsReadEvent value)?  markAllNotificationsRead,TResult? Function( DeleteNotificationEvent value)?  deleteNotification,}){
final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications(_that);case MarkNotificationReadEvent() when markNotificationRead != null:
return markNotificationRead(_that);case MarkAllNotificationsReadEvent() when markAllNotificationsRead != null:
return markAllNotificationsRead(_that);case DeleteNotificationEvent() when deleteNotification != null:
return deleteNotification(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadNotifications,TResult Function( String notificationId)?  markNotificationRead,TResult Function()?  markAllNotificationsRead,TResult Function( String notificationId)?  deleteNotification,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications();case MarkNotificationReadEvent() when markNotificationRead != null:
return markNotificationRead(_that.notificationId);case MarkAllNotificationsReadEvent() when markAllNotificationsRead != null:
return markAllNotificationsRead();case DeleteNotificationEvent() when deleteNotification != null:
return deleteNotification(_that.notificationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadNotifications,required TResult Function( String notificationId)  markNotificationRead,required TResult Function()  markAllNotificationsRead,required TResult Function( String notificationId)  deleteNotification,}) {final _that = this;
switch (_that) {
case LoadNotificationsEvent():
return loadNotifications();case MarkNotificationReadEvent():
return markNotificationRead(_that.notificationId);case MarkAllNotificationsReadEvent():
return markAllNotificationsRead();case DeleteNotificationEvent():
return deleteNotification(_that.notificationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadNotifications,TResult? Function( String notificationId)?  markNotificationRead,TResult? Function()?  markAllNotificationsRead,TResult? Function( String notificationId)?  deleteNotification,}) {final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications();case MarkNotificationReadEvent() when markNotificationRead != null:
return markNotificationRead(_that.notificationId);case MarkAllNotificationsReadEvent() when markAllNotificationsRead != null:
return markAllNotificationsRead();case DeleteNotificationEvent() when deleteNotification != null:
return deleteNotification(_that.notificationId);case _:
  return null;

}
}

}

/// @nodoc


class LoadNotificationsEvent implements NotificationsEvent {
  const LoadNotificationsEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadNotificationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsEvent.loadNotifications()';
}


}




/// @nodoc


class MarkNotificationReadEvent implements NotificationsEvent {
  const MarkNotificationReadEvent(this.notificationId);
  

 final  String notificationId;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkNotificationReadEventCopyWith<MarkNotificationReadEvent> get copyWith => _$MarkNotificationReadEventCopyWithImpl<MarkNotificationReadEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkNotificationReadEvent&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId);

@override
String toString() {
  return 'NotificationsEvent.markNotificationRead(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class $MarkNotificationReadEventCopyWith<$Res> implements $NotificationsEventCopyWith<$Res> {
  factory $MarkNotificationReadEventCopyWith(MarkNotificationReadEvent value, $Res Function(MarkNotificationReadEvent) _then) = _$MarkNotificationReadEventCopyWithImpl;
@useResult
$Res call({
 String notificationId
});




}
/// @nodoc
class _$MarkNotificationReadEventCopyWithImpl<$Res>
    implements $MarkNotificationReadEventCopyWith<$Res> {
  _$MarkNotificationReadEventCopyWithImpl(this._self, this._then);

  final MarkNotificationReadEvent _self;
  final $Res Function(MarkNotificationReadEvent) _then;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notificationId = null,}) {
  return _then(MarkNotificationReadEvent(
null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MarkAllNotificationsReadEvent implements NotificationsEvent {
  const MarkAllNotificationsReadEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkAllNotificationsReadEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsEvent.markAllNotificationsRead()';
}


}




/// @nodoc


class DeleteNotificationEvent implements NotificationsEvent {
  const DeleteNotificationEvent(this.notificationId);
  

 final  String notificationId;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteNotificationEventCopyWith<DeleteNotificationEvent> get copyWith => _$DeleteNotificationEventCopyWithImpl<DeleteNotificationEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteNotificationEvent&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId);

@override
String toString() {
  return 'NotificationsEvent.deleteNotification(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class $DeleteNotificationEventCopyWith<$Res> implements $NotificationsEventCopyWith<$Res> {
  factory $DeleteNotificationEventCopyWith(DeleteNotificationEvent value, $Res Function(DeleteNotificationEvent) _then) = _$DeleteNotificationEventCopyWithImpl;
@useResult
$Res call({
 String notificationId
});




}
/// @nodoc
class _$DeleteNotificationEventCopyWithImpl<$Res>
    implements $DeleteNotificationEventCopyWith<$Res> {
  _$DeleteNotificationEventCopyWithImpl(this._self, this._then);

  final DeleteNotificationEvent _self;
  final $Res Function(DeleteNotificationEvent) _then;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notificationId = null,}) {
  return _then(DeleteNotificationEvent(
null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
