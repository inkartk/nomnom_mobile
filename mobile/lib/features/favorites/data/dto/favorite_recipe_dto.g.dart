// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_recipe_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteRecipeDtoImpl _$$FavoriteRecipeDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$FavoriteRecipeDtoImpl(
      userId: json['userId'] as String,
      recipe: RecipeDto.fromJson(json['recipe'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FavoriteRecipeDtoImplToJson(
        _$FavoriteRecipeDtoImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'recipe': instance.recipe,
    };
