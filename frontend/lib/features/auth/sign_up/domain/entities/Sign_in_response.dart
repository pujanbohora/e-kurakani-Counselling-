// For credentials and user's data

// Project imports:
import 'package:frontend/features/auth/sign_up/data/model/credentials_secret.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';

class SigninResponse {
  final UserModel? user;
  final String? refresh;
  final String? access;

  SigninResponse({this.user, this.access, this.refresh});
}
