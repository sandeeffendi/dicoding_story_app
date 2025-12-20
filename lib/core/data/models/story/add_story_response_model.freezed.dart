// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_story_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddStoryResponseModel {

 bool get error; String get message;
/// Create a copy of AddStoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddStoryResponseModelCopyWith<AddStoryResponseModel> get copyWith => _$AddStoryResponseModelCopyWithImpl<AddStoryResponseModel>(this as AddStoryResponseModel, _$identity);

  /// Serializes this AddStoryResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddStoryResponseModel&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,message);

@override
String toString() {
  return 'AddStoryResponseModel(error: $error, message: $message)';
}


}

/// @nodoc
abstract mixin class $AddStoryResponseModelCopyWith<$Res>  {
  factory $AddStoryResponseModelCopyWith(AddStoryResponseModel value, $Res Function(AddStoryResponseModel) _then) = _$AddStoryResponseModelCopyWithImpl;
@useResult
$Res call({
 bool error, String message
});




}
/// @nodoc
class _$AddStoryResponseModelCopyWithImpl<$Res>
    implements $AddStoryResponseModelCopyWith<$Res> {
  _$AddStoryResponseModelCopyWithImpl(this._self, this._then);

  final AddStoryResponseModel _self;
  final $Res Function(AddStoryResponseModel) _then;

/// Create a copy of AddStoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,Object? message = null,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AddStoryResponseModel].
extension AddStoryResponseModelPatterns on AddStoryResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddStoryResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddStoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddStoryResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _AddStoryResponseModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddStoryResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _AddStoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool error,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddStoryResponseModel() when $default != null:
return $default(_that.error,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool error,  String message)  $default,) {final _that = this;
switch (_that) {
case _AddStoryResponseModel():
return $default(_that.error,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool error,  String message)?  $default,) {final _that = this;
switch (_that) {
case _AddStoryResponseModel() when $default != null:
return $default(_that.error,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddStoryResponseModel implements AddStoryResponseModel {
  const _AddStoryResponseModel({required this.error, required this.message});
  factory _AddStoryResponseModel.fromJson(Map<String, dynamic> json) => _$AddStoryResponseModelFromJson(json);

@override final  bool error;
@override final  String message;

/// Create a copy of AddStoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddStoryResponseModelCopyWith<_AddStoryResponseModel> get copyWith => __$AddStoryResponseModelCopyWithImpl<_AddStoryResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddStoryResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddStoryResponseModel&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,message);

@override
String toString() {
  return 'AddStoryResponseModel(error: $error, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AddStoryResponseModelCopyWith<$Res> implements $AddStoryResponseModelCopyWith<$Res> {
  factory _$AddStoryResponseModelCopyWith(_AddStoryResponseModel value, $Res Function(_AddStoryResponseModel) _then) = __$AddStoryResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool error, String message
});




}
/// @nodoc
class __$AddStoryResponseModelCopyWithImpl<$Res>
    implements _$AddStoryResponseModelCopyWith<$Res> {
  __$AddStoryResponseModelCopyWithImpl(this._self, this._then);

  final _AddStoryResponseModel _self;
  final $Res Function(_AddStoryResponseModel) _then;

/// Create a copy of AddStoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? message = null,}) {
  return _then(_AddStoryResponseModel(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
