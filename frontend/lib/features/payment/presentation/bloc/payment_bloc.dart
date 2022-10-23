import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<KhaltiPaymentEvent>(
      (event, emit) {
        KhaltiScope.of(event.context).pay(
          config: PaymentConfig(
            amount: 10000,
            productIdentity: 'dells-sssssg5-g5510-2021',
            productName: 'Product Name',
          ),
          preferences: [
            PaymentPreference.khalti,
          ],
          onSuccess: (su) {
            print("orint the response of the khalti mannnn");
            print(su);

            emit(KhaltiPaymentLoadedState(
                onSuccess: "Payment Successful", paymentSuccessModel: su));

            // const successsnackBar = SnackBar(
            //   content: Text('Payment Successful'),
            // );
            // ScaffoldMessenger.of(event.context).showSnackBar(successsnackBar);
          },
          onFailure: (fa) {
            emit(KhaltiPaymentFailedState(onFailure: "Payment Successful"));
            // const failedsnackBar = SnackBar(
            //   content: Text('Payment Failed'),
            // );
            // ScaffoldMessenger.of(event.context).showSnackBar(failedsnackBar);
          },
          onCancel: () {
            emit(KhaltiPaymentCanceldState(onCancel: "Payment Successful"));
            // const cancelsnackBar = SnackBar(
            //   content: Text('Payment Cancelled'),
            // );
            // ScaffoldMessenger.of(event.context).showSnackBar(cancelsnackBar);
          },
        );
      },
    );
  }
}
