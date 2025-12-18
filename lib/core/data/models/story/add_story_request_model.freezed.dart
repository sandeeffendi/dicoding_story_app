// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_story_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddStoryRequestModel {

 String get description; List<int> get photo;
/// Create a copy of AddStoryRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddStoryRequestModelCopyWith<AddStoryRequestModel> get copyWith => _$AddStoryRequestModelCopyWithImpl<AddStoryRequestModel>(this as AddStoryRequestModel, _$identity);

  /// Serializes this AddStoryRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddStoryRequestModel&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.photo, photo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,const DeepCollectionEquality().hash(photo));

@override
String toString() {
  return 'AddStoryRequestModel(description: $description, photo: $photo)';
}


}

/// @nodoc
abstract mixin class $AddStoryRequestModelCopyWith<$Res>  {
  factory $AddStoryRequestModelCopyWith(AddStoryRequestModel value, $Res Function(AddStoryRequestModel) _then) = _$AddStoryRequestModelCopyWithImpl;
@useResult
$Res call({
 String description, List<int> photo
});




}
/// @nodoc
class _$AddStoryRequestModelCopyWithImpl<$Res>
    implements $AddStoryRequestModelCopyWith<$Res> {
  _$AddStoryRequestModelCopyWithImpl(this._self, this._then);

  final AddStoryRequestModel _self;
  final $Res Function(AddStoryRequestModel) _then;

/// Create a copy of AddStoryRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? photo = null,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [AddStoryRequestModel].
extension AddStoryRequestModelPatterns on AddStoryRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddStoryRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddStoryRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddStoryRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _AddStoryRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddStoryRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _AddStoryRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  List<int> photo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddStoryRequestModel() when $default != null:
return $default(_that.description,_that.photo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  List<int> photo)  $default,) {final _that = this;
switch (_that) {
case _AddStoryRequestModel():
return $default(_that.description,_that.photo);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  List<int> photo)?  $default,) {final _that = this;
switch (_that) {
case _AddStoryRequestModel() when $default != null:
return $default(_that.description,_that.photo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddStoryRequestModel implements AddStoryRequestModel {
  const _AddStoryRequestModel({required this.description, required final  List<int> photo}): _photo = photo;
  factory _AddStoryRequestModel.fromJson(Map<String, dynamic> json) => _$AddStoryRequestModelFromJson(json);

@override final  String description;
 final  List<int> _photo;
@override List<int> get photo {
  if (_photo is EqualUnmodifiableListView) return _photo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photo);
}


/// Create a copy of AddStoryRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddStoryRequestModelCopyWith<_AddStoryRequestModel> get copyWith => __$AddStoryRequestModelCopyWithImpl<_AddStoryRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddStoryRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddStoryRequestModel&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._photo, _photo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,const DeepCollectionEquality().hash(_photo));

@override
String toString() {
  return 'AddStoryRequestModel(description: $description, photo: $photo)';
}


}

/// @nodoc
abstract mixin class _$AddStoryRequestModelCopyWith<$Res> implements $AddStoryRequestModelCopyWith<$Res> {
  factory _$AddStoryRequestModelCopyWith(_AddStoryRequestModel value, $Res Function(_AddStoryRequestModel) _then) = __$AddStoryRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String description, List<int> photo
});




}
/// @nodoc
class __$AddStoryRequestModelCopyWithImpl<$Res>
    implements _$AddStoryRequestModelCopyWith<$Res> {
  __$AddStoryRequestModelCopyWithImpl(this._self, this._then);

  final _AddStoryRequestModel _self;
  final $Res Function(_AddStoryRequestModel) _then;

/// Create a copy of AddStoryRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? photo = null,}) {
  return _then(_AddStoryRequestModel(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photo: null == photo ? _self._photo : photo // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
