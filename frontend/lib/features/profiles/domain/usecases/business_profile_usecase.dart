import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/repository/business_repository.dart';
import 'package:frontend/features/profiles/domain/repository/counsellor_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyBusinessProfileUsecase
    implements Usecase<BusinessProfile, BusinessProfile> {
  var businessProfileRepository = getIt<BusinessProfileRepository>();

  ApplyBusinessProfileUsecase(this.businessProfileRepository);

  @override
  Future<Either<Failure, BusinessProfile>> call(BusinessProfile data) async {
    // TODO: implement call

    return await businessProfileRepository.applyVerification(data);
  }
}

@injectable
class GetBusinessProfileUsecase implements Usecase<BusinessProfile, String> {
  var getBusinessProfileRepository = getIt<GetBusinessProfileRepository>();
  @override
  Future<Either<Failure, BusinessProfile>> call(String userId) async {
    // TODO: implement call

    return await getBusinessProfileRepository.getBusiness(userId);
  }
}

@injectable
class GetBusinessProfileRequestUsecase
    implements Usecase<List<BusinessProfile>, NoParams> {
  var getBusinessProfileRepository = getIt<GetBusinessProfileRepository>();
  @override
  Future<Either<Failure, List<BusinessProfile>>> call(NoParams noParams) async {
    // TODO: implement call

    return await getBusinessProfileRepository.getBusinessProfileRequests();
  }
}

@injectable
class ChangeBusinessProfileStatusUsecase
    implements Usecase<BusinessProfile, BusinessProfile> {
  var businessProfileRepository = getIt<BusinessProfileRepository>();

  ChangeBusinessProfileStatusUsecase(this.businessProfileRepository);

  @override
  Future<Either<Failure, BusinessProfile>> call(BusinessProfile data) async {
    // TODO: implement call

    return await businessProfileRepository.changeStatus(data);
  }
}

@injectable
class EditBusinessProfileUsecase
    implements Usecase<BusinessProfile, BusinessProfile> {
  var businessProfileRepository = getIt<BusinessProfileRepository>();

  EditBusinessProfileUsecase(this.businessProfileRepository);

  @override
  Future<Either<Failure, BusinessProfile>> call(BusinessProfile data) async {
    // TODO: implement call

    return await businessProfileRepository.editBusinessProfile(data);
  }
}

@injectable
class DeleteBusinessAttachmentUseCase
    implements Usecase<Map<String, dynamic>, String> {
  // var emailVerificationRepository = getIt<emailVerificationRepository>();

  var businessProfileRepository = getIt<BusinessProfileRepository>();

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(String id) async {
    // TODO: implement call
    return await businessProfileRepository.deleteBusinessAttachment(id);
  }
}


// @injectable

// class SaveCounsellorAttachmentUploadUsecase implements Usecase<>
