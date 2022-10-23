// // Flutter imports:
// import 'package:flutter/material.dart';
// import 'package:frontend/core/utils/validators.dart';
// import 'package:frontend/core/widgets/custom_button_widget.dart';
// import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/custom_form_field_widget.dart';
// import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/input_field_widget.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({Key? key}) : super(key: key);

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();

//   String? firstName;
//   String? lastName;

//   FocusNode firstNameFocusNode = FocusNode();

//   final TextEditingController oldPasswordController = TextEditingController();

//   final TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           InputField(
//             textEditingController: emailController,
//             isCapitalized: true,
//             focusNode: firstNameFocusNode,
//             validator: (value) => Validators.validateFirstName(
//                 value, !firstNameFocusNode.hasFocus),
//             textInputAction: TextInputAction.next,
//             getInputFieldValue: (String value) {
//               setState(() {
//                 firstName = value;
//               });
//             },
//             hintText: 'Enter Email',
//           ),
//           SizedBox(height: size.height * 0.01),
//           CustomFormField(
//             fieldName: '',
//             textEditingController: oldPasswordController,
//             isObscure: true,
//             hint: 'Password',
//             validator: (value) => Validators.validatePassword(value, false),
//           ),
//           SizedBox(height: size.height * 0.03),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: ActionButton(
//                 background: Colors.grey,
//                 width: size.width,
//                 borderRadius: 16,
//                 text: Text(
//                   "Submit",
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                       ),
//                 ),
//                 onPressed: () {}),
//           )
//         ],
//       ),
//     );
//   }
// }
