part of 'payment_bloc.dart';

@immutable
abstract class PaymentState extends Equatable {}

class PaymentInitial extends PaymentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class KhaltiPaymentLoadingState extends PaymentState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class KhaltiPaymentLoadedState extends PaymentState {
  PaymentSuccessModel paymentSuccessModel;
  final String onSuccess;

  KhaltiPaymentLoadedState({required this.onSuccess, required this.paymentSuccessModel});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class KhaltiPaymentFailedState extends PaymentState {
  final String onFailure;

  KhaltiPaymentFailedState({required this.onFailure});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class KhaltiPaymentCanceldState extends PaymentState {
  final String onCancel;

  KhaltiPaymentCanceldState({required this.onCancel});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

