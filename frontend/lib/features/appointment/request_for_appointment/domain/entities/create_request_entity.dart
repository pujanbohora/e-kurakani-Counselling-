// Package imports:
import 'package:equatable/equatable.dart';

class CreateRequestEntiry extends Equatable {
  final String? user;
  final String? counsellor;
  final String? date;
  final String? time;
  final String? remarks;
  final double? amount;
  final String? token;

  const CreateRequestEntiry(
      {this.user,
      this.counsellor,
      this.date,
      this.time,
      this.remarks,
      this.amount,
      this.token});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [user, counsellor, date, time, remarks, amount, token];
}
