// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeDtoImpl _$$RecipeDtoImplFromJson(Map<String, dynamic> json) =>
    _$RecipeDtoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$RecipeDtoImplToJson(_$RecipeDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'instructions': instance.instructions,
      'imageUrl': instance.imageUrl,
    };
