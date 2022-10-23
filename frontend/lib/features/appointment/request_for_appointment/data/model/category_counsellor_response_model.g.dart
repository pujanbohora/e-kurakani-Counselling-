// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_counsellor_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryCounsellorResponseModel _$CategoryCounsellorResponseModelFromJson(
        Map<String, dynamic> json) =>
    CategoryCounsellorResponseModel(
      json['id'].toString(),
      json['name'] as String?,
      (json['counsellors'] as List<dynamic>?)
          ?.map(
              (e) => CounsellorProfileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryCounsellorResponseModelToJson(
        CategoryCounsellorResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'counsellors': instance.counsellors,
    };
