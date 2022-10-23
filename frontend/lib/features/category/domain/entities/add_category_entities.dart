// Package imports:
import 'package:equatable/equatable.dart';
import 'dart:io';

// Project imports:
import 'package:frontend/features/category/data/model/add_category_model.dart';

class AddCategoryEntity extends Equatable {
  final String? id;
  final String? name;
  final String? parent;
  final String? image;
  final List<AddCategoryModel>? children;
  final File? imageData;

  AddCategoryEntity({
    this.id,
    this.name,
    this.children,
    this.parent,
    this.image,
    this.imageData,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        children,
        parent,
        image,
        imageData,
      ];
}
