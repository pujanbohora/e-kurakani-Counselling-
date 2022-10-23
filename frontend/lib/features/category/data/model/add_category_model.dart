// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';

part 'add_category_model.g.dart';

@JsonSerializable()
class AddCategoryModel extends AddCategoryEntity {
  AddCategoryModel(
      {String? id,
      String? name,
      List<AddCategoryModel>? children,
      String? parent,
      String? image,})
      : super(
          id: id,
          name: name,
          children: children,
          parent: parent,
          image: image,
        );

  factory AddCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$AddCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCategoryModelToJson(this);
}
