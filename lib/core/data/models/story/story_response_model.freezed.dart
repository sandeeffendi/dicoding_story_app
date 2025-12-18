// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoryResponseModel {

 bool get error; String get message; List<StoryModel> get listStory;
/// Create a copy of StoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryResponseModelCopyWith<StoryResponseModel> get copyWith => _$StoryResponseModelCopyWithImpl<StoryResponseModel>(this as StoryResponseModel, _$identity);

  /// Serializes this StoryResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryResponseModel&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.listStory, listStory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,message,const DeepCollectionEquality().hash(listStory));

@override
String toString() {
  return 'StoryResponseModel(error: $error, message: $message, listStory: $listStory)';
}


}

/// @nodoc
abstract mixin class $StoryResponseModelCopyWith<$Res>  {
  factory $StoryResponseModelCopyWith(StoryResponseModel value, $Res Function(StoryResponseModel) _then) = _$StoryResponseModelCopyWithImpl;
@useResult
$Res call({
 bool error, String message, List<StoryModel> listStory
});




}
/// @nodoc
class _$StoryResponseModelCopyWithImpl<$Res>
    implements $StoryResponseModelCopyWith<$Res> {
  _$StoryResponseModelCopyWithImpl(this._self, this._then);

  final StoryResponseModel _self;
  final $Res Function(StoryResponseModel) _then;

/// Create a copy of StoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,Object? message = null,Object? listStory = null,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,listStory: null == listStory ? _self.listStory : listStory // ignore: cast_nullable_to_non_nullable
as List<StoryModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoryResponseModel].
extension StoryResponseModelPatterns on StoryResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _StoryResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _StoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool error,  String message,  List<StoryModel> listStory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryResponseModel() when $default != null:
return $default(_that.error,_that.message,_that.listStory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool error,  String message,  List<StoryModel> listStory)  $default,) {final _that = this;
switch (_that) {
case _StoryResponseModel():
return $default(_that.error,_that.message,_that.listStory);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool error,  String message,  List<StoryModel> listStory)?  $default,) {final _that = this;
switch (_that) {
case _StoryResponseModel() when $default != null:
return $default(_that.error,_that.message,_that.listStory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryResponseModel implements StoryResponseModel {
  const _StoryResponseModel({required this.error, required this.message, required final  List<StoryModel> listStory}): _listStory = listStory;
  factory _StoryResponseModel.fromJson(Map<String, dynamic> json) => _$StoryResponseModelFromJson(json);

@override final  bool error;
@override final  String message;
 final  List<StoryModel> _listStory;
@override List<StoryModel> get listStory {
  if (_listStory is EqualUnmodifiableListView) return _listStory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listStory);
}


/// Create a copy of StoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryResponseModelCopyWith<_StoryResponseModel> get copyWith => __$StoryResponseModelCopyWithImpl<_StoryResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryResponseModel&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._listStory, _listStory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,message,const DeepCollectionEquality().hash(_listStory));

@override
String toString() {
  return 'StoryResponseModel(error: $error, message: $message, listStory: $listStory)';
}


}

/// @nodoc
abstract mixin class _$StoryResponseModelCopyWith<$Res> implements $StoryResponseModelCopyWith<$Res> {
  factory _$StoryResponseModelCopyWith(_StoryResponseModel value, $Res Function(_StoryResponseModel) _then) = __$StoryResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool error, String message, List<StoryModel> listStory
});




}
/// @nodoc
class __$StoryResponseModelCopyWithImpl<$Res>
    implements _$StoryResponseModelCopyWith<$Res> {
  __$StoryResponseModelCopyWithImpl(this._self, this._then);

  final _StoryResponseModel _self;
  final $Res Function(_StoryResponseModel) _then;

/// Create a copy of StoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? message = null,Object? listStory = null,}) {
  return _then(_StoryResponseModel(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,listStory: null == listStory ? _self._listStory : listStory // ignore: cast_nullable_to_non_nullable
as List<StoryModel>,
  ));
}


}

// dart format on
