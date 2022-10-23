// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';

class CategoryCounsellorResponse extends Equatable {
  final String? id;
  final String? name;
  final List<CounsellorProfileModel>? counsellors;

  const CategoryCounsellorResponse(this.id, this.name, this.counsellors);

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        counsellors,
      ];
}
