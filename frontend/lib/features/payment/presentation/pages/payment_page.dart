// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class KhaltiPaymentPage extends StatefulWidget {
  const KhaltiPaymentPage({Key? key}) : super(key: key);

  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  TextEditingController amountController = TextEditingController();

  getAmt() {
    return int.parse(amountController.text) * 100; // Converting to paisa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khalti Payment Integration'),
      ),
      body: BlocProvider<PaymentBloc>(
        create: (context) => PaymentBloc(),
        child: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            // if (state is KhaltiPaymentFailedState) {
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text(state.onFailure),
            //     duration: Duration(seconds: 1),
            //   ));
            // } else if (state is KhaltiPaymentLoadedState) {
            //   print("this is reponse of sucess and the token");
            //   print(state.paymentSuccessModel);
            //   print(state.paymentSuccessModel.token);
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text(state.onSuccess),
            //     duration: Duration(seconds: 1),
            //   ));
            // } else if (state is KhaltiPaymentCanceldState) {
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text(state.onCancel),
            //     duration: Duration(seconds: 1),
            //   ));
            // }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  const SizedBox(height: 15),
                  // For Amount
                  // TextField(
                  //   controller: amountController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: const InputDecoration(
                  //       labelText: "Enter Amount to pay",
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.black),
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.green),
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //       )),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // For Button
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.red)),
                      height: 50,
                      color: const Color(0xFF56328c),
                      child: const Text(
                        'Pay With Khalti',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      onPressed: () {
                        print("this is inside the button pressed");
                        // BlocProvider.of<PaymentBloc>(context)
                        //   ..add(KhaltiPaymentEvent(context: context));
                        KhaltiScope.of(context).pay(
                          config: PaymentConfig(
                            amount: 10000,
                            productIdentity: 'dells-sssssg5-g5510-2021',
                            productName: 'Product Name',
                          ),
                          preferences: [
                            PaymentPreference.khalti,
                          ],
                          onSuccess: (su) {
                            // print(config);
                            print("this is inside the onsucess of the khalti app");
                            print(su);
                            const successsnackBar = SnackBar(
                              content: Text('Payment Successful'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(successsnackBar);
                          },
                          onFailure: (fa) {
                            const failedsnackBar = SnackBar(
                              content: Text('Payment Failed'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(failedsnackBar);
                          },
                          onCancel: () {
                            const cancelsnackBar = SnackBar(
                              content: Text('Payment Cancelled'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(cancelsnackBar);
                          },
                        );
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
