// Package imports:
import 'package:dartz/dartz.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';

// Project imports:
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import '../../../../core/error/errors.dart';

abstract class BusinessProfileRepository {
  Future<Either<Failure, BusinessProfile>> applyVerification(
      BusinessProfile data);
  Future<Either<Failure, BusinessProfile>> changeStatus(BusinessProfile data);
  Future<Either<Failure, BusinessProfile>> editBusinessProfile(
      BusinessProfile data);
  Future<Either<Failure, Map<String, dynamic>>> deleteBusinessAttachment(id);
}

abstract class GetBusinessProfileRepository {
  Future<Either<Failure, BusinessProfile>> getBusiness(String userId);
  Future<Either<Failure, List<BusinessProfile>>> getBusinessProfileRequests();
}
