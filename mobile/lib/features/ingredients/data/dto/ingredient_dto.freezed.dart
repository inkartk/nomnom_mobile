// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ingredient_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IngredientDto _$IngredientDtoFromJson(Map<String, dynamic> json) {
  return _IngredientDto.fromJson(json);
}

/// @nodoc
mixin _$IngredientDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  DateTime get expirationDate => throw _privateConstructorUsedError;

  /// Serializes this IngredientDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IngredientDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IngredientDtoCopyWith<IngredientDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientDtoCopyWith<$Res> {
  factory $IngredientDtoCopyWith(
          IngredientDto value, $Res Function(IngredientDto) then) =
      _$IngredientDtoCopyWithImpl<$Res, IngredientDto>;
  @useResult
  $Res call(
      {String id,
      String name,
      double quantity,
      String unit,
      DateTime expirationDate});
}

/// @nodoc
class _$IngredientDtoCopyWithImpl<$Res, $Val extends IngredientDto>
    implements $IngredientDtoCopyWith<$Res> {
  _$IngredientDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IngredientDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? expirationDate = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      expirationDate: null == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IngredientDtoImplCopyWith<$Res>
    implements $IngredientDtoCopyWith<$Res> {
  factory _$$IngredientDtoImplCopyWith(
          _$IngredientDtoImpl value, $Res Function(_$IngredientDtoImpl) then) =
      __$$IngredientDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double quantity,
      String unit,
      DateTime expirationDate});
}

/// @nodoc
class __$$IngredientDtoImplCopyWithImpl<$Res>
    extends _$IngredientDtoCopyWithImpl<$Res, _$IngredientDtoImpl>
    implements _$$IngredientDtoImplCopyWith<$Res> {
  __$$IngredientDtoImplCopyWithImpl(
      _$IngredientDtoImpl _value, $Res Function(_$IngredientDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of IngredientDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? expirationDate = null,
  }) {
    return _then(_$IngredientDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      expirationDate: null == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IngredientDtoImpl implements _IngredientDto {
  const _$IngredientDtoImpl(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.unit,
      required this.expirationDate});

  factory _$IngredientDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IngredientDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double quantity;
  @override
  final String unit;
  @override
  final DateTime expirationDate;

  @override
  String toString() {
    return 'IngredientDto(id: $id, name: $name, quantity: $quantity, unit: $unit, expirationDate: $expirationDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IngredientDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, quantity, unit, expirationDate);

  /// Create a copy of IngredientDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IngredientDtoImplCopyWith<_$IngredientDtoImpl> get copyWith =>
      __$$IngredientDtoImplCopyWithImpl<_$IngredientDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IngredientDtoImplToJson(
      this,
    );
  }
}

abstract class _IngredientDto implements IngredientDto {
  const factory _IngredientDto(
      {required final String id,
      required final String name,
      required final double quantity,
      required final String unit,
      required final DateTime expirationDate}) = _$IngredientDtoImpl;

  factory _IngredientDto.fromJson(Map<String, dynamic> json) =
      _$IngredientDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get quantity;
  @override
  String get unit;
  @override
  DateTime get expirationDate;

  /// Create a copy of IngredientDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IngredientDtoImplCopyWith<_$IngredientDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
