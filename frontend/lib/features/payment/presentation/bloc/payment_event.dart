part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent extends Equatable {}

class KhaltiPaymentEvent extends PaymentEvent {
  final BuildContext context;

  KhaltiPaymentEvent({required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
