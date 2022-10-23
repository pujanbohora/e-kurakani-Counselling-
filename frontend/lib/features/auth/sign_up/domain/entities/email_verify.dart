// Package imports:
import 'package:equatable/equatable.dart';

class EmailVerifyCode extends Equatable {
  final String? otp;
  final String? message;
  final bool? success;
  final String? email;

  const EmailVerifyCode({this.email, this.otp, this.message, this.success});

  @override
  // TODO: implement props
  List<Object?> get props => [otp, email, message, success];
}
