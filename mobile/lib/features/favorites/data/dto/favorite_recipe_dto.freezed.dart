// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_recipe_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteRecipeDto _$FavoriteRecipeDtoFromJson(Map<String, dynamic> json) {
  return _FavoriteRecipeDto.fromJson(json);
}

/// @nodoc
mixin _$FavoriteRecipeDto {
  String get userId => throw _privateConstructorUsedError;
  RecipeDto get recipe => throw _privateConstructorUsedError;

  /// Serializes this FavoriteRecipeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteRecipeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteRecipeDtoCopyWith<FavoriteRecipeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteRecipeDtoCopyWith<$Res> {
  factory $FavoriteRecipeDtoCopyWith(
          FavoriteRecipeDto value, $Res Function(FavoriteRecipeDto) then) =
      _$FavoriteRecipeDtoCopyWithImpl<$Res, FavoriteRecipeDto>;
  @useResult
  $Res call({String userId, RecipeDto recipe});

  $RecipeDtoCopyWith<$Res> get recipe;
}

/// @nodoc
class _$FavoriteRecipeDtoCopyWithImpl<$Res, $Val extends FavoriteRecipeDto>
    implements $FavoriteRecipeDtoCopyWith<$Res> {
  _$FavoriteRecipeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteRecipeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? recipe = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      recipe: null == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as RecipeDto,
    ) as $Val);
  }

  /// Create a copy of FavoriteRecipeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecipeDtoCopyWith<$Res> get recipe {
    return $RecipeDtoCopyWith<$Res>(_value.recipe, (value) {
      return _then(_value.copyWith(recipe: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FavoriteRecipeDtoImplCopyWith<$Res>
    implements $FavoriteRecipeDtoCopyWith<$Res> {
  factory _$$FavoriteRecipeDtoImplCopyWith(_$FavoriteRecipeDtoImpl value,
          $Res Function(_$FavoriteRecipeDtoImpl) then) =
      __$$FavoriteRecipeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, RecipeDto recipe});

  @override
  $RecipeDtoCopyWith<$Res> get recipe;
}

/// @nodoc
class __$$FavoriteRecipeDtoImplCopyWithImpl<$Res>
    extends _$FavoriteRecipeDtoCopyWithImpl<$Res, _$FavoriteRecipeDtoImpl>
    implements _$$FavoriteRecipeDtoImplCopyWith<$Res> {
  __$$FavoriteRecipeDtoImplCopyWithImpl(_$FavoriteRecipeDtoImpl _value,
      $Res Function(_$FavoriteRecipeDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteRecipeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? recipe = null,
  }) {
    return _then(_$FavoriteRecipeDtoImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      recipe: null == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as RecipeDto,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteRecipeDtoImpl implements _FavoriteRecipeDto {
  const _$FavoriteRecipeDtoImpl({required this.userId, required this.recipe});

  factory _$FavoriteRecipeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteRecipeDtoImplFromJson(json);

  @override
  final String userId;
  @override
  final RecipeDto recipe;

  @override
  String toString() {
    return 'FavoriteRecipeDto(userId: $userId, recipe: $recipe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteRecipeDtoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.recipe, recipe) || other.recipe == recipe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, recipe);

  /// Create a copy of FavoriteRecipeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteRecipeDtoImplCopyWith<_$FavoriteRecipeDtoImpl> get copyWith =>
      __$$FavoriteRecipeDtoImplCopyWithImpl<_$FavoriteRecipeDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteRecipeDtoImplToJson(
      this,
    );
  }
}

abstract class _FavoriteRecipeDto implements FavoriteRecipeDto {
  const factory _FavoriteRecipeDto(
      {required final String userId,
      required final RecipeDto recipe}) = _$FavoriteRecipeDtoImpl;

  factory _FavoriteRecipeDto.fromJson(Map<String, dynamic> json) =
      _$FavoriteRecipeDtoImpl.fromJson;

  @override
  String get userId;
  @override
  RecipeDto get recipe;

  /// Create a copy of FavoriteRecipeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteRecipeDtoImplCopyWith<_$FavoriteRecipeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
