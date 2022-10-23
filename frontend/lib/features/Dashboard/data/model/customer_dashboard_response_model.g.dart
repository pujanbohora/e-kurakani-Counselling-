// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_dashboard_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDashboardResponseModel _$CustomerDashboardResponseModelFromJson(
        Map<String, dynamic> json) =>
    CustomerDashboardResponseModel(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => AddCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      counsellors: (json['counsellors'] as List<dynamic>?)
          ?.map(
              (e) => CounsellorProfileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerDashboardResponseModelToJson(
        CustomerDashboardResponseModel instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'counsellors': instance.counsellors,
    };
