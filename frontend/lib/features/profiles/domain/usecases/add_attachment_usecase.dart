// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/features/profiles/domain/repository/attachment_repository.dart';
import 'package:frontend/injectable.dart';

@injectable
class AddAttachment implements Usecase<ProfileAttachments, ProfileAttachments> {
  var attachmentRepository = getIt<AttachmentRepository>();

  AddAttachment(this.attachmentRepository);

  @override
  Future<Either<Failure, ProfileAttachments>> call(
      ProfileAttachments data) async {
    // TODO: implement call
    return await attachmentRepository.addCounsellorAttachment(data);
  }
}

@injectable
class AddBusinessAttachment
    implements Usecase<ProfileAttachments, ProfileAttachments> {
  var attachmentRepository = getIt<AttachmentRepository>();

  AddBusinessAttachment(this.attachmentRepository);

  @override
  Future<Either<Failure, ProfileAttachments>> call(
      ProfileAttachments data) async {
    // TODO: implement call
    return await attachmentRepository.addBusinessAttachment(data);
  }
}
