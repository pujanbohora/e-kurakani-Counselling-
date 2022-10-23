// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCategoryModel _$AddCategoryModelFromJson(Map<String, dynamic> json) =>
    AddCategoryModel(
      id: json['id'].toString(),
      name: json['name'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => AddCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      parent: json['parent'].toString(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$AddCategoryModelToJson(AddCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parent': instance.parent,
      'image': instance.image,
      'children': instance.children,
    };
