import 'package:frontend/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/features/profiles/domain/repository/counsellor_repository.dart';
import 'package:frontend/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyCounsellorProfileUsecase
    implements Usecase<CounsellorProfile, CounsellorProfile> {
  var counsellorProfileRepository = getIt<CounsellorProfileRepository>();

  ApplyCounsellorProfileUsecase(this.counsellorProfileRepository);

  @override
  Future<Either<Failure, CounsellorProfile>> call(
      CounsellorProfile data) async {
    // TODO: implement call

    return await counsellorProfileRepository.applyVerification(data);
  }
}

@injectable
class GetCounsellorProfileUsecase
    implements Usecase<CounsellorProfile, String> {
  var getCounsellorProfileRepository = getIt<GetCounsellorProfileRepository>();
  @override
  Future<Either<Failure, CounsellorProfile>> call(String userId) async {
    // TODO: implement call

    return await getCounsellorProfileRepository.getCounsellor(userId);
  }
}

@injectable
class GetCounsellorProfileRequestUsecase
    implements Usecase<List<CounsellorProfile>, NoParams> {
  var getCounsellorProfileRepository = getIt<GetCounsellorProfileRepository>();
  @override
  Future<Either<Failure, List<CounsellorProfile>>> call(
      NoParams noParams) async {
    // TODO: implement call

    return await getCounsellorProfileRepository.getCounsellorProfileRequests();
  }
}

@injectable
class ChangeCounsellorProfileStatusUsecase
    implements Usecase<CounsellorProfile, CounsellorProfile> {
  var counsellorProfileRepository = getIt<CounsellorProfileRepository>();

  ChangeCounsellorProfileStatusUsecase(this.counsellorProfileRepository);

  @override
  Future<Either<Failure, CounsellorProfile>> call(
      CounsellorProfile data) async {
    // TODO: implement call

    return await counsellorProfileRepository.changeStatus(data);
  }
}

@injectable
class EditCounsellorProfileUsecase
    implements Usecase<CounsellorProfile, CounsellorProfile> {
  var counsellorProfileRepository = getIt<CounsellorProfileRepository>();

  EditCounsellorProfileUsecase(this.counsellorProfileRepository);

  @override
  Future<Either<Failure, CounsellorProfile>> call(
      CounsellorProfile data) async {
    // TODO: implement call

    return await counsellorProfileRepository.editCounsellorProfile(data);
  }
}

@injectable
class DeleteCounsellorAttachmentUseCase
    implements Usecase<Map<String, dynamic>, String> {
  // var emailVerificationRepository = getIt<emailVerificationRepository>();

  var counsellorProfileRepository = getIt<CounsellorProfileRepository>();

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(String id) async {
    // TODO: implement call
    return await counsellorProfileRepository.deleteCounsellorAttachment(id);
  }
}

// @injectable

// class SaveCounsellorAttachmentUploadUsecase implements Usecase<>
