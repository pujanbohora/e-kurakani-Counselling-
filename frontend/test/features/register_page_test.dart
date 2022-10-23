import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/auth/sign_up/domain/usecases/login_with_pasword.dart';
import 'package:frontend/features/auth/sign_up/domain/usecases/sign_up_register_user.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/view/sign_up_view.dart';
import 'package:frontend/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/sign_up/presentation/bloc/signup_bloc/sign_up_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    await configureInjection();
    var signUpRepositorUser = getIt<SignUpRegisterUser>();
    var loginWithPasswordUsecase = getIt<LoginWithPassword>();
    var preference = getIt<SharedPreferences>();
    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
                loginWithPasswordUsecase, signUpRepositorUser, preference)),
      ],
      child: const MaterialApp(home: SignupPage()),
    )
        // MaterialApp(home: SigninPage()),
        );

    final titlefinder = find.text('SIGNUP');

    expect(titlefinder, findsOneWidget);
  });
}
