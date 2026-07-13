// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_market_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobMarketEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobMarketEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JobMarketEvent()';
}


}

/// @nodoc
class $JobMarketEventCopyWith<$Res>  {
$JobMarketEventCopyWith(JobMarketEvent _, $Res Function(JobMarketEvent) __);
}


/// Adds pattern-matching-related methods to [JobMarketEvent].
extension JobMarketEventPatterns on JobMarketEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ListJobsEvent value)?  listJobs,TResult Function( GetJobDetailEvent value)?  getJobDetail,TResult Function( AddJobToCartEvent value)?  addJobToCart,TResult Function( ListCartItemsEvent value)?  listCartItems,TResult Function( RemoveJobFromCartEvent value)?  removeJobFromCart,TResult Function( CreateJobReviewEvent value)?  createJobReview,TResult Function( ListApplicationsEvent value)?  listApplications,TResult Function( ListJobReviewsEvent value)?  listJobReviews,TResult Function( UpdateCartStatusEvent value)?  updateCartStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ListJobsEvent() when listJobs != null:
return listJobs(_that);case GetJobDetailEvent() when getJobDetail != null:
return getJobDetail(_that);case AddJobToCartEvent() when addJobToCart != null:
return addJobToCart(_that);case ListCartItemsEvent() when listCartItems != null:
return listCartItems(_that);case RemoveJobFromCartEvent() when removeJobFromCart != null:
return removeJobFromCart(_that);case CreateJobReviewEvent() when createJobReview != null:
return createJobReview(_that);case ListApplicationsEvent() when listApplications != null:
return listApplications(_that);case ListJobReviewsEvent() when listJobReviews != null:
return listJobReviews(_that);case UpdateCartStatusEvent() when updateCartStatus != null:
return updateCartStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ListJobsEvent value)  listJobs,required TResult Function( GetJobDetailEvent value)  getJobDetail,required TResult Function( AddJobToCartEvent value)  addJobToCart,required TResult Function( ListCartItemsEvent value)  listCartItems,required TResult Function( RemoveJobFromCartEvent value)  removeJobFromCart,required TResult Function( CreateJobReviewEvent value)  createJobReview,required TResult Function( ListApplicationsEvent value)  listApplications,required TResult Function( ListJobReviewsEvent value)  listJobReviews,required TResult Function( UpdateCartStatusEvent value)  updateCartStatus,}){
final _that = this;
switch (_that) {
case ListJobsEvent():
return listJobs(_that);case GetJobDetailEvent():
return getJobDetail(_that);case AddJobToCartEvent():
return addJobToCart(_that);case ListCartItemsEvent():
return listCartItems(_that);case RemoveJobFromCartEvent():
return removeJobFromCart(_that);case CreateJobReviewEvent():
return createJobReview(_that);case ListApplicationsEvent():
return listApplications(_that);case ListJobReviewsEvent():
return listJobReviews(_that);case UpdateCartStatusEvent():
return updateCartStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ListJobsEvent value)?  listJobs,TResult? Function( GetJobDetailEvent value)?  getJobDetail,TResult? Function( AddJobToCartEvent value)?  addJobToCart,TResult? Function( ListCartItemsEvent value)?  listCartItems,TResult? Function( RemoveJobFromCartEvent value)?  removeJobFromCart,TResult? Function( CreateJobReviewEvent value)?  createJobReview,TResult? Function( ListApplicationsEvent value)?  listApplications,TResult? Function( ListJobReviewsEvent value)?  listJobReviews,TResult? Function( UpdateCartStatusEvent value)?  updateCartStatus,}){
final _that = this;
switch (_that) {
case ListJobsEvent() when listJobs != null:
return listJobs(_that);case GetJobDetailEvent() when getJobDetail != null:
return getJobDetail(_that);case AddJobToCartEvent() when addJobToCart != null:
return addJobToCart(_that);case ListCartItemsEvent() when listCartItems != null:
return listCartItems(_that);case RemoveJobFromCartEvent() when removeJobFromCart != null:
return removeJobFromCart(_that);case CreateJobReviewEvent() when createJobReview != null:
return createJobReview(_that);case ListApplicationsEvent() when listApplications != null:
return listApplications(_that);case ListJobReviewsEvent() when listJobReviews != null:
return listJobReviews(_that);case UpdateCartStatusEvent() when updateCartStatus != null:
return updateCartStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Map<String, dynamic> filters)?  listJobs,TResult Function( String jobId)?  getJobDetail,TResult Function( String jobId)?  addJobToCart,TResult Function()?  listCartItems,TResult Function( String cartItemId)?  removeJobFromCart,TResult Function( CreateReviewRequest request)?  createJobReview,TResult Function()?  listApplications,TResult Function( String? jobId)?  listJobReviews,TResult Function( String cartId,  String status)?  updateCartStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ListJobsEvent() when listJobs != null:
return listJobs(_that.filters);case GetJobDetailEvent() when getJobDetail != null:
return getJobDetail(_that.jobId);case AddJobToCartEvent() when addJobToCart != null:
return addJobToCart(_that.jobId);case ListCartItemsEvent() when listCartItems != null:
return listCartItems();case RemoveJobFromCartEvent() when removeJobFromCart != null:
return removeJobFromCart(_that.cartItemId);case CreateJobReviewEvent() when createJobReview != null:
return createJobReview(_that.request);case ListApplicationsEvent() when listApplications != null:
return listApplications();case ListJobReviewsEvent() when listJobReviews != null:
return listJobReviews(_that.jobId);case UpdateCartStatusEvent() when updateCartStatus != null:
return updateCartStatus(_that.cartId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Map<String, dynamic> filters)  listJobs,required TResult Function( String jobId)  getJobDetail,required TResult Function( String jobId)  addJobToCart,required TResult Function()  listCartItems,required TResult Function( String cartItemId)  removeJobFromCart,required TResult Function( CreateReviewRequest request)  createJobReview,required TResult Function()  listApplications,required TResult Function( String? jobId)  listJobReviews,required TResult Function( String cartId,  String status)  updateCartStatus,}) {final _that = this;
switch (_that) {
case ListJobsEvent():
return listJobs(_that.filters);case GetJobDetailEvent():
return getJobDetail(_that.jobId);case AddJobToCartEvent():
return addJobToCart(_that.jobId);case ListCartItemsEvent():
return listCartItems();case RemoveJobFromCartEvent():
return removeJobFromCart(_that.cartItemId);case CreateJobReviewEvent():
return createJobReview(_that.request);case ListApplicationsEvent():
return listApplications();case ListJobReviewsEvent():
return listJobReviews(_that.jobId);case UpdateCartStatusEvent():
return updateCartStatus(_that.cartId,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Map<String, dynamic> filters)?  listJobs,TResult? Function( String jobId)?  getJobDetail,TResult? Function( String jobId)?  addJobToCart,TResult? Function()?  listCartItems,TResult? Function( String cartItemId)?  removeJobFromCart,TResult? Function( CreateReviewRequest request)?  createJobReview,TResult? Function()?  listApplications,TResult? Function( String? jobId)?  listJobReviews,TResult? Function( String cartId,  String status)?  updateCartStatus,}) {final _that = this;
switch (_that) {
case ListJobsEvent() when listJobs != null:
return listJobs(_that.filters);case GetJobDetailEvent() when getJobDetail != null:
return getJobDetail(_that.jobId);case AddJobToCartEvent() when addJobToCart != null:
return addJobToCart(_that.jobId);case ListCartItemsEvent() when listCartItems != null:
return listCartItems();case RemoveJobFromCartEvent() when removeJobFromCart != null:
return removeJobFromCart(_that.cartItemId);case CreateJobReviewEvent() when createJobReview != null:
return createJobReview(_that.request);case ListApplicationsEvent() when listApplications != null:
return listApplications();case ListJobReviewsEvent() when listJobReviews != null:
return listJobReviews(_that.jobId);case UpdateCartStatusEvent() when updateCartStatus != null:
return updateCartStatus(_that.cartId,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class ListJobsEvent implements JobMarketEvent {
  const ListJobsEvent({required final  Map<String, dynamic> filters}): _filters = filters;
  

 final  Map<String, dynamic> _filters;
 Map<String, dynamic> get filters {
  if (_filters is EqualUnmodifiableMapView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_filters);
}


/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListJobsEventCopyWith<ListJobsEvent> get copyWith => _$ListJobsEventCopyWithImpl<ListJobsEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListJobsEvent&&const DeepCollectionEquality().equals(other._filters, _filters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_filters));

@override
String toString() {
  return 'JobMarketEvent.listJobs(filters: $filters)';
}


}

/// @nodoc
abstract mixin class $ListJobsEventCopyWith<$Res> implements $JobMarketEventCopyWith<$Res> {
  factory $ListJobsEventCopyWith(ListJobsEvent value, $Res Function(ListJobsEvent) _then) = _$ListJobsEventCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> filters
});




}
/// @nodoc
class _$ListJobsEventCopyWithImpl<$Res>
    implements $ListJobsEventCopyWith<$Res> {
  _$ListJobsEventCopyWithImpl(this._self, this._then);

  final ListJobsEvent _self;
  final $Res Function(ListJobsEvent) _then;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filters = null,}) {
  return _then(ListJobsEvent(
filters: null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class GetJobDetailEvent implements JobMarketEvent {
  const GetJobDetailEvent({required this.jobId});
  

 final  String jobId;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetJobDetailEventCopyWith<GetJobDetailEvent> get copyWith => _$GetJobDetailEventCopyWithImpl<GetJobDetailEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetJobDetailEvent&&(identical(other.jobId, jobId) || other.jobId == jobId));
}


@override
int get hashCode => Object.hash(runtimeType,jobId);

@override
String toString() {
  return 'JobMarketEvent.getJobDetail(jobId: $jobId)';
}


}

/// @nodoc
abstract mixin class $GetJobDetailEventCopyWith<$Res> implements $JobMarketEventCopyWith<$Res> {
  factory $GetJobDetailEventCopyWith(GetJobDetailEvent value, $Res Function(GetJobDetailEvent) _then) = _$GetJobDetailEventCopyWithImpl;
@useResult
$Res call({
 String jobId
});




}
/// @nodoc
class _$GetJobDetailEventCopyWithImpl<$Res>
    implements $GetJobDetailEventCopyWith<$Res> {
  _$GetJobDetailEventCopyWithImpl(this._self, this._then);

  final GetJobDetailEvent _self;
  final $Res Function(GetJobDetailEvent) _then;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? jobId = null,}) {
  return _then(GetJobDetailEvent(
jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddJobToCartEvent implements JobMarketEvent {
  const AddJobToCartEvent({required this.jobId});
  

 final  String jobId;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddJobToCartEventCopyWith<AddJobToCartEvent> get copyWith => _$AddJobToCartEventCopyWithImpl<AddJobToCartEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddJobToCartEvent&&(identical(other.jobId, jobId) || other.jobId == jobId));
}


@override
int get hashCode => Object.hash(runtimeType,jobId);

@override
String toString() {
  return 'JobMarketEvent.addJobToCart(jobId: $jobId)';
}


}

/// @nodoc
abstract mixin class $AddJobToCartEventCopyWith<$Res> implements $JobMarketEventCopyWith<$Res> {
  factory $AddJobToCartEventCopyWith(AddJobToCartEvent value, $Res Function(AddJobToCartEvent) _then) = _$AddJobToCartEventCopyWithImpl;
@useResult
$Res call({
 String jobId
});




}
/// @nodoc
class _$AddJobToCartEventCopyWithImpl<$Res>
    implements $AddJobToCartEventCopyWith<$Res> {
  _$AddJobToCartEventCopyWithImpl(this._self, this._then);

  final AddJobToCartEvent _self;
  final $Res Function(AddJobToCartEvent) _then;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? jobId = null,}) {
  return _then(AddJobToCartEvent(
jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ListCartItemsEvent implements JobMarketEvent {
  const ListCartItemsEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListCartItemsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JobMarketEvent.listCartItems()';
}


}




/// @nodoc


class RemoveJobFromCartEvent implements JobMarketEvent {
  const RemoveJobFromCartEvent({required this.cartItemId});
  

 final  String cartItemId;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveJobFromCartEventCopyWith<RemoveJobFromCartEvent> get copyWith => _$RemoveJobFromCartEventCopyWithImpl<RemoveJobFromCartEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveJobFromCartEvent&&(identical(other.cartItemId, cartItemId) || other.cartItemId == cartItemId));
}


@override
int get hashCode => Object.hash(runtimeType,cartItemId);

@override
String toString() {
  return 'JobMarketEvent.removeJobFromCart(cartItemId: $cartItemId)';
}


}

/// @nodoc
abstract mixin class $RemoveJobFromCartEventCopyWith<$Res> implements $JobMarketEventCopyWith<$Res> {
  factory $RemoveJobFromCartEventCopyWith(RemoveJobFromCartEvent value, $Res Function(RemoveJobFromCartEvent) _then) = _$RemoveJobFromCartEventCopyWithImpl;
@useResult
$Res call({
 String cartItemId
});




}
/// @nodoc
class _$RemoveJobFromCartEventCopyWithImpl<$Res>
    implements $RemoveJobFromCartEventCopyWith<$Res> {
  _$RemoveJobFromCartEventCopyWithImpl(this._self, this._then);

  final RemoveJobFromCartEvent _self;
  final $Res Function(RemoveJobFromCartEvent) _then;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cartItemId = null,}) {
  return _then(RemoveJobFromCartEvent(
cartItemId: null == cartItemId ? _self.cartItemId : cartItemId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateJobReviewEvent implements JobMarketEvent {
  const CreateJobReviewEvent({required this.request});
  

 final  CreateReviewRequest request;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateJobReviewEventCopyWith<CreateJobReviewEvent> get copyWith => _$CreateJobReviewEventCopyWithImpl<CreateJobReviewEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateJobReviewEvent&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'JobMarketEvent.createJobReview(request: $request)';
}


}

/// @nodoc
abstract mixin class $CreateJobReviewEventCopyWith<$Res> implements $JobMarketEventCopyWith<$Res> {
  factory $CreateJobReviewEventCopyWith(CreateJobReviewEvent value, $Res Function(CreateJobReviewEvent) _then) = _$CreateJobReviewEventCopyWithImpl;
@useResult
$Res call({
 CreateReviewRequest request
});




}
/// @nodoc
class _$CreateJobReviewEventCopyWithImpl<$Res>
    implements $CreateJobReviewEventCopyWith<$Res> {
  _$CreateJobReviewEventCopyWithImpl(this._self, this._then);

  final CreateJobReviewEvent _self;
  final $Res Function(CreateJobReviewEvent) _then;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(CreateJobReviewEvent(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CreateReviewRequest,
  ));
}


}

/// @nodoc


class ListApplicationsEvent implements JobMarketEvent {
  const ListApplicationsEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListApplicationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JobMarketEvent.listApplications()';
}


}




/// @nodoc


class ListJobReviewsEvent implements JobMarketEvent {
  const ListJobReviewsEvent({this.jobId});
  

 final  String? jobId;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListJobReviewsEventCopyWith<ListJobReviewsEvent> get copyWith => _$ListJobReviewsEventCopyWithImpl<ListJobReviewsEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListJobReviewsEvent&&(identical(other.jobId, jobId) || other.jobId == jobId));
}


@override
int get hashCode => Object.hash(runtimeType,jobId);

@override
String toString() {
  return 'JobMarketEvent.listJobReviews(jobId: $jobId)';
}


}

/// @nodoc
abstract mixin class $ListJobReviewsEventCopyWith<$Res> implements $JobMarketEventCopyWith<$Res> {
  factory $ListJobReviewsEventCopyWith(ListJobReviewsEvent value, $Res Function(ListJobReviewsEvent) _then) = _$ListJobReviewsEventCopyWithImpl;
@useResult
$Res call({
 String? jobId
});




}
/// @nodoc
class _$ListJobReviewsEventCopyWithImpl<$Res>
    implements $ListJobReviewsEventCopyWith<$Res> {
  _$ListJobReviewsEventCopyWithImpl(this._self, this._then);

  final ListJobReviewsEvent _self;
  final $Res Function(ListJobReviewsEvent) _then;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? jobId = freezed,}) {
  return _then(ListJobReviewsEvent(
jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UpdateCartStatusEvent implements JobMarketEvent {
  const UpdateCartStatusEvent({required this.cartId, required this.status});
  

 final  String cartId;
 final  String status;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCartStatusEventCopyWith<UpdateCartStatusEvent> get copyWith => _$UpdateCartStatusEventCopyWithImpl<UpdateCartStatusEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCartStatusEvent&&(identical(other.cartId, cartId) || other.cartId == cartId)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,cartId,status);

@override
String toString() {
  return 'JobMarketEvent.updateCartStatus(cartId: $cartId, status: $status)';
}


}

/// @nodoc
abstract mixin class $UpdateCartStatusEventCopyWith<$Res> implements $JobMarketEventCopyWith<$Res> {
  factory $UpdateCartStatusEventCopyWith(UpdateCartStatusEvent value, $Res Function(UpdateCartStatusEvent) _then) = _$UpdateCartStatusEventCopyWithImpl;
@useResult
$Res call({
 String cartId, String status
});




}
/// @nodoc
class _$UpdateCartStatusEventCopyWithImpl<$Res>
    implements $UpdateCartStatusEventCopyWith<$Res> {
  _$UpdateCartStatusEventCopyWithImpl(this._self, this._then);

  final UpdateCartStatusEvent _self;
  final $Res Function(UpdateCartStatusEvent) _then;

/// Create a copy of JobMarketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cartId = null,Object? status = null,}) {
  return _then(UpdateCartStatusEvent(
cartId: null == cartId ? _self.cartId : cartId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$JobMarketState {

 UIStatus get status;// Core data cache for the feature
 List<JobPostingModel> get jobs; JobDetailResponse? get jobDetail; List<JobReviewEntity> get reviews; List<UserCartModel> get cartItems; List<UserJobModel> get applications;// Specific action statuses to handle one-off side effects (like showing popups)
 UIStatus get addToCartStatus; UIStatus get removeFromCartStatus; UIStatus get createReviewStatus; UIStatus get updateCartStatus;
/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobMarketStateCopyWith<JobMarketState> get copyWith => _$JobMarketStateCopyWithImpl<JobMarketState>(this as JobMarketState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobMarketState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.jobs, jobs)&&(identical(other.jobDetail, jobDetail) || other.jobDetail == jobDetail)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&const DeepCollectionEquality().equals(other.cartItems, cartItems)&&const DeepCollectionEquality().equals(other.applications, applications)&&(identical(other.addToCartStatus, addToCartStatus) || other.addToCartStatus == addToCartStatus)&&(identical(other.removeFromCartStatus, removeFromCartStatus) || other.removeFromCartStatus == removeFromCartStatus)&&(identical(other.createReviewStatus, createReviewStatus) || other.createReviewStatus == createReviewStatus)&&(identical(other.updateCartStatus, updateCartStatus) || other.updateCartStatus == updateCartStatus));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(jobs),jobDetail,const DeepCollectionEquality().hash(reviews),const DeepCollectionEquality().hash(cartItems),const DeepCollectionEquality().hash(applications),addToCartStatus,removeFromCartStatus,createReviewStatus,updateCartStatus);

@override
String toString() {
  return 'JobMarketState(status: $status, jobs: $jobs, jobDetail: $jobDetail, reviews: $reviews, cartItems: $cartItems, applications: $applications, addToCartStatus: $addToCartStatus, removeFromCartStatus: $removeFromCartStatus, createReviewStatus: $createReviewStatus, updateCartStatus: $updateCartStatus)';
}


}

/// @nodoc
abstract mixin class $JobMarketStateCopyWith<$Res>  {
  factory $JobMarketStateCopyWith(JobMarketState value, $Res Function(JobMarketState) _then) = _$JobMarketStateCopyWithImpl;
@useResult
$Res call({
 UIStatus status, List<JobPostingModel> jobs, JobDetailResponse? jobDetail, List<JobReviewEntity> reviews, List<UserCartModel> cartItems, List<UserJobModel> applications, UIStatus addToCartStatus, UIStatus removeFromCartStatus, UIStatus createReviewStatus, UIStatus updateCartStatus
});


$UIStatusCopyWith<$Res> get status;$UIStatusCopyWith<$Res> get addToCartStatus;$UIStatusCopyWith<$Res> get removeFromCartStatus;$UIStatusCopyWith<$Res> get createReviewStatus;$UIStatusCopyWith<$Res> get updateCartStatus;

}
/// @nodoc
class _$JobMarketStateCopyWithImpl<$Res>
    implements $JobMarketStateCopyWith<$Res> {
  _$JobMarketStateCopyWithImpl(this._self, this._then);

  final JobMarketState _self;
  final $Res Function(JobMarketState) _then;

/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? jobs = null,Object? jobDetail = freezed,Object? reviews = null,Object? cartItems = null,Object? applications = null,Object? addToCartStatus = null,Object? removeFromCartStatus = null,Object? createReviewStatus = null,Object? updateCartStatus = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,jobs: null == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<JobPostingModel>,jobDetail: freezed == jobDetail ? _self.jobDetail : jobDetail // ignore: cast_nullable_to_non_nullable
as JobDetailResponse?,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<JobReviewEntity>,cartItems: null == cartItems ? _self.cartItems : cartItems // ignore: cast_nullable_to_non_nullable
as List<UserCartModel>,applications: null == applications ? _self.applications : applications // ignore: cast_nullable_to_non_nullable
as List<UserJobModel>,addToCartStatus: null == addToCartStatus ? _self.addToCartStatus : addToCartStatus // ignore: cast_nullable_to_non_nullable
as UIStatus,removeFromCartStatus: null == removeFromCartStatus ? _self.removeFromCartStatus : removeFromCartStatus // ignore: cast_nullable_to_non_nullable
as UIStatus,createReviewStatus: null == createReviewStatus ? _self.createReviewStatus : createReviewStatus // ignore: cast_nullable_to_non_nullable
as UIStatus,updateCartStatus: null == updateCartStatus ? _self.updateCartStatus : updateCartStatus // ignore: cast_nullable_to_non_nullable
as UIStatus,
  ));
}
/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get status {
  
  return $UIStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get addToCartStatus {
  
  return $UIStatusCopyWith<$Res>(_self.addToCartStatus, (value) {
    return _then(_self.copyWith(addToCartStatus: value));
  });
}/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get removeFromCartStatus {
  
  return $UIStatusCopyWith<$Res>(_self.removeFromCartStatus, (value) {
    return _then(_self.copyWith(removeFromCartStatus: value));
  });
}/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get createReviewStatus {
  
  return $UIStatusCopyWith<$Res>(_self.createReviewStatus, (value) {
    return _then(_self.copyWith(createReviewStatus: value));
  });
}/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get updateCartStatus {
  
  return $UIStatusCopyWith<$Res>(_self.updateCartStatus, (value) {
    return _then(_self.copyWith(updateCartStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [JobMarketState].
extension JobMarketStatePatterns on JobMarketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobMarketState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobMarketState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobMarketState value)  $default,){
final _that = this;
switch (_that) {
case _JobMarketState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobMarketState value)?  $default,){
final _that = this;
switch (_that) {
case _JobMarketState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UIStatus status,  List<JobPostingModel> jobs,  JobDetailResponse? jobDetail,  List<JobReviewEntity> reviews,  List<UserCartModel> cartItems,  List<UserJobModel> applications,  UIStatus addToCartStatus,  UIStatus removeFromCartStatus,  UIStatus createReviewStatus,  UIStatus updateCartStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobMarketState() when $default != null:
return $default(_that.status,_that.jobs,_that.jobDetail,_that.reviews,_that.cartItems,_that.applications,_that.addToCartStatus,_that.removeFromCartStatus,_that.createReviewStatus,_that.updateCartStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UIStatus status,  List<JobPostingModel> jobs,  JobDetailResponse? jobDetail,  List<JobReviewEntity> reviews,  List<UserCartModel> cartItems,  List<UserJobModel> applications,  UIStatus addToCartStatus,  UIStatus removeFromCartStatus,  UIStatus createReviewStatus,  UIStatus updateCartStatus)  $default,) {final _that = this;
switch (_that) {
case _JobMarketState():
return $default(_that.status,_that.jobs,_that.jobDetail,_that.reviews,_that.cartItems,_that.applications,_that.addToCartStatus,_that.removeFromCartStatus,_that.createReviewStatus,_that.updateCartStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UIStatus status,  List<JobPostingModel> jobs,  JobDetailResponse? jobDetail,  List<JobReviewEntity> reviews,  List<UserCartModel> cartItems,  List<UserJobModel> applications,  UIStatus addToCartStatus,  UIStatus removeFromCartStatus,  UIStatus createReviewStatus,  UIStatus updateCartStatus)?  $default,) {final _that = this;
switch (_that) {
case _JobMarketState() when $default != null:
return $default(_that.status,_that.jobs,_that.jobDetail,_that.reviews,_that.cartItems,_that.applications,_that.addToCartStatus,_that.removeFromCartStatus,_that.createReviewStatus,_that.updateCartStatus);case _:
  return null;

}
}

}

/// @nodoc


class _JobMarketState implements JobMarketState {
  const _JobMarketState({this.status = const UIStatus.initial(), final  List<JobPostingModel> jobs = const [], this.jobDetail, final  List<JobReviewEntity> reviews = const [], final  List<UserCartModel> cartItems = const [], final  List<UserJobModel> applications = const [], this.addToCartStatus = const UIStatus.initial(), this.removeFromCartStatus = const UIStatus.initial(), this.createReviewStatus = const UIStatus.initial(), this.updateCartStatus = const UIStatus.initial()}): _jobs = jobs,_reviews = reviews,_cartItems = cartItems,_applications = applications;
  

@override@JsonKey() final  UIStatus status;
// Core data cache for the feature
 final  List<JobPostingModel> _jobs;
// Core data cache for the feature
@override@JsonKey() List<JobPostingModel> get jobs {
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobs);
}

@override final  JobDetailResponse? jobDetail;
 final  List<JobReviewEntity> _reviews;
@override@JsonKey() List<JobReviewEntity> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

 final  List<UserCartModel> _cartItems;
@override@JsonKey() List<UserCartModel> get cartItems {
  if (_cartItems is EqualUnmodifiableListView) return _cartItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cartItems);
}

 final  List<UserJobModel> _applications;
@override@JsonKey() List<UserJobModel> get applications {
  if (_applications is EqualUnmodifiableListView) return _applications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_applications);
}

// Specific action statuses to handle one-off side effects (like showing popups)
@override@JsonKey() final  UIStatus addToCartStatus;
@override@JsonKey() final  UIStatus removeFromCartStatus;
@override@JsonKey() final  UIStatus createReviewStatus;
@override@JsonKey() final  UIStatus updateCartStatus;

/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobMarketStateCopyWith<_JobMarketState> get copyWith => __$JobMarketStateCopyWithImpl<_JobMarketState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobMarketState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._jobs, _jobs)&&(identical(other.jobDetail, jobDetail) || other.jobDetail == jobDetail)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&const DeepCollectionEquality().equals(other._cartItems, _cartItems)&&const DeepCollectionEquality().equals(other._applications, _applications)&&(identical(other.addToCartStatus, addToCartStatus) || other.addToCartStatus == addToCartStatus)&&(identical(other.removeFromCartStatus, removeFromCartStatus) || other.removeFromCartStatus == removeFromCartStatus)&&(identical(other.createReviewStatus, createReviewStatus) || other.createReviewStatus == createReviewStatus)&&(identical(other.updateCartStatus, updateCartStatus) || other.updateCartStatus == updateCartStatus));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_jobs),jobDetail,const DeepCollectionEquality().hash(_reviews),const DeepCollectionEquality().hash(_cartItems),const DeepCollectionEquality().hash(_applications),addToCartStatus,removeFromCartStatus,createReviewStatus,updateCartStatus);

@override
String toString() {
  return 'JobMarketState(status: $status, jobs: $jobs, jobDetail: $jobDetail, reviews: $reviews, cartItems: $cartItems, applications: $applications, addToCartStatus: $addToCartStatus, removeFromCartStatus: $removeFromCartStatus, createReviewStatus: $createReviewStatus, updateCartStatus: $updateCartStatus)';
}


}

/// @nodoc
abstract mixin class _$JobMarketStateCopyWith<$Res> implements $JobMarketStateCopyWith<$Res> {
  factory _$JobMarketStateCopyWith(_JobMarketState value, $Res Function(_JobMarketState) _then) = __$JobMarketStateCopyWithImpl;
@override @useResult
$Res call({
 UIStatus status, List<JobPostingModel> jobs, JobDetailResponse? jobDetail, List<JobReviewEntity> reviews, List<UserCartModel> cartItems, List<UserJobModel> applications, UIStatus addToCartStatus, UIStatus removeFromCartStatus, UIStatus createReviewStatus, UIStatus updateCartStatus
});


@override $UIStatusCopyWith<$Res> get status;@override $UIStatusCopyWith<$Res> get addToCartStatus;@override $UIStatusCopyWith<$Res> get removeFromCartStatus;@override $UIStatusCopyWith<$Res> get createReviewStatus;@override $UIStatusCopyWith<$Res> get updateCartStatus;

}
/// @nodoc
class __$JobMarketStateCopyWithImpl<$Res>
    implements _$JobMarketStateCopyWith<$Res> {
  __$JobMarketStateCopyWithImpl(this._self, this._then);

  final _JobMarketState _self;
  final $Res Function(_JobMarketState) _then;

/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? jobs = null,Object? jobDetail = freezed,Object? reviews = null,Object? cartItems = null,Object? applications = null,Object? addToCartStatus = null,Object? removeFromCartStatus = null,Object? createReviewStatus = null,Object? updateCartStatus = null,}) {
  return _then(_JobMarketState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UIStatus,jobs: null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<JobPostingModel>,jobDetail: freezed == jobDetail ? _self.jobDetail : jobDetail // ignore: cast_nullable_to_non_nullable
as JobDetailResponse?,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<JobReviewEntity>,cartItems: null == cartItems ? _self._cartItems : cartItems // ignore: cast_nullable_to_non_nullable
as List<UserCartModel>,applications: null == applications ? _self._applications : applications // ignore: cast_nullable_to_non_nullable
as List<UserJobModel>,addToCartStatus: null == addToCartStatus ? _self.addToCartStatus : addToCartStatus // ignore: cast_nullable_to_non_nullable
as UIStatus,removeFromCartStatus: null == removeFromCartStatus ? _self.removeFromCartStatus : removeFromCartStatus // ignore: cast_nullable_to_non_nullable
as UIStatus,createReviewStatus: null == createReviewStatus ? _self.createReviewStatus : createReviewStatus // ignore: cast_nullable_to_non_nullable
as UIStatus,updateCartStatus: null == updateCartStatus ? _self.updateCartStatus : updateCartStatus // ignore: cast_nullable_to_non_nullable
as UIStatus,
  ));
}

/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get status {
  
  return $UIStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get addToCartStatus {
  
  return $UIStatusCopyWith<$Res>(_self.addToCartStatus, (value) {
    return _then(_self.copyWith(addToCartStatus: value));
  });
}/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get removeFromCartStatus {
  
  return $UIStatusCopyWith<$Res>(_self.removeFromCartStatus, (value) {
    return _then(_self.copyWith(removeFromCartStatus: value));
  });
}/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get createReviewStatus {
  
  return $UIStatusCopyWith<$Res>(_self.createReviewStatus, (value) {
    return _then(_self.copyWith(createReviewStatus: value));
  });
}/// Create a copy of JobMarketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UIStatusCopyWith<$Res> get updateCartStatus {
  
  return $UIStatusCopyWith<$Res>(_self.updateCartStatus, (value) {
    return _then(_self.copyWith(updateCartStatus: value));
  });
}
}

// dart format on
