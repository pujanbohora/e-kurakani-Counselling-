// Package imports:
import 'package:equatable/equatable.dart';
import 'dart:io';

// Project imports:
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class CustomerDashboardResponseEntity extends Equatable {
  final List<AddCategoryModel>? categories;
  final List<CounsellorProfileModel>? counsellors;

  CustomerDashboardResponseEntity({
    this.categories,
    this.counsellors,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        counsellors,
        categories,
      ];
}
