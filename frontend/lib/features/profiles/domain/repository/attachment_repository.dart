// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import '../../../../core/error/errors.dart';

abstract class AttachmentRepository {
  Future<Either<Failure, ProfileAttachments>> addCounsellorAttachment(
      ProfileAttachments data);
  Future<Either<Failure, ProfileAttachments>> updateCounsellorAttachment(
      ProfileAttachments data);
  Future<Either<Failure, ProfileAttachments>> addBusinessAttachment(
      ProfileAttachments data);
}
